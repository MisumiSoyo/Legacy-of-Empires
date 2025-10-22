import json
import copy

def apply_changes(original_file, changes_file, output_file):
    with open(original_file, 'r', encoding='utf-8') as f:
        original_data = json.load(f)

    with open(changes_file, 'r', encoding='utf-8') as f:
        changes = json.load(f)

    modified_data = copy.deepcopy(original_data)

    for change in changes["changes"]:
        action = change["action"]
        civ_ids = change["civ_id"] if isinstance(change["civ_id"], list) else [change["civ_id"]]
        use_type = change.get("Use Type", "")

        for civ_id in civ_ids:
            target_civs = []
            if civ_id == "all":
                target_civs = modified_data["civs"]
            else:
                for civ in modified_data["civs"]:
                    if civ["civ_id"] == civ_id:
                        target_civs.append(civ)

            for civ in target_civs:
                if use_type in ["Unit", "Tech"]:
                    target_list = civ["civ_techs_units"]
                elif use_type == "Building":
                    target_list = civ["civ_techs_buildings"]
                else:
                    continue

                if action == "add":
                    new_item = {key: value for key, value in change.items() if key not in ["action", "civ_id", "position", "target_id"]}
                    insert_position = len(target_list)
                    position = change.get("position", "last").lower()
                    target_id = change.get("target_id", None)
                    if position == "first":
                        insert_position = 0
                    elif position in ["before", "after"] and target_id is not None:
                        for idx, item in enumerate(target_list):
                            if item["Node ID"] == target_id:
                                if position == "before":
                                    insert_position = idx
                                else:
                                    insert_position = idx + 1
                                break
                    target_list.insert(insert_position, new_item)
                elif action == "modify":
                    node_ids = change["Node ID"] if isinstance(change["Node ID"], list) else [change["Node ID"]]
                    for node_id in node_ids:
                        for item in target_list:
                            if item["Node ID"] == node_id and item.get("Use Type") == use_type:
                                for key, value in change.items():
                                    if key not in ["action", "civ_id", "Node ID"]:
                                        item[key] = value
                                break
                            elif item["Node ID"] == node_id and item.get("Use Type") != use_type:
                                pass  # 删除警告信息
                elif action == "delete":
                    node_ids = change["Node ID"] if isinstance(change["Node ID"], list) else [change["Node ID"]]
                    target_list[:] = [
                        item for item in target_list
                        if item["Node ID"] not in node_ids or (item.get("Use Type") != use_type)
                    ]
                    for node_id in node_ids:
                        if not any(item["Node ID"] == node_id and item.get("Use Type") == use_type for item in target_list):
                            pass  # 删除警告信息

    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(modified_data, f, indent=4, ensure_ascii=False)

apply_changes(
    original_file="E:/Programs/steamapps/common/AoE2DE/resources/_common/dat/civTechTrees.json",
    changes_file="ctt_changes.json",
    output_file="civTechTrees.json"
)
