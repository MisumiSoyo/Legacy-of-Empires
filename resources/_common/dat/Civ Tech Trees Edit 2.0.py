import json
import copy
import os
from pathlib import Path

def load_civs_from_folder(folder_path):
    """从CivTechTrees文件夹加载所有文明数据"""
    civs = []
    civ_files = {}  # 用于记录每个civ_id对应的文件名
    
    folder = Path(folder_path)
    if not folder.exists():
        raise FileNotFoundError(f"文件夹不存在: {folder_path}")
    
    for json_file in folder.glob("*.json"):
        with open(json_file, 'r', encoding='utf-8') as f:
            civ_data = json.load(f)
            # 假设每个文件包含一个文明的数据
            if isinstance(civ_data, dict) and "civ_id" in civ_data:
                civs.append(civ_data)
                civ_files[civ_data["civ_id"]] = json_file.name
            elif isinstance(civ_data, list) and len(civ_data) > 0:
                # 如果文件包含列表，取第一个元素（或遍历所有）
                for civ in civ_data:
                    if "civ_id" in civ:
                        civs.append(civ)
                        civ_files[civ["civ_id"]] = json_file.name
    
    return {"civs": civs}, civ_files

def save_civs_to_folder(output_folder, civs_data, civ_files_mapping):
    """将修改后的文明数据保存到输出文件夹"""
    folder = Path(output_folder)
    # 如果文件夹不存在则创建，存在则直接使用
    folder.mkdir(parents=True, exist_ok=True)
    
    for civ in civs_data["civs"]:
        civ_id = civ["civ_id"]
        if civ_id in civ_files_mapping:
            file_name = civ_files_mapping[civ_id]
        else:
            # 如果没有记录（新增的文明），使用civ_id作为文件名
            file_name = f"{civ_id}.json"
        
        file_path = folder / file_name
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(civ, f, indent=4, ensure_ascii=False)

def apply_changes(original_folder, changes_file, output_folder="CivTechTrees"):
    # 从源文件夹加载所有文明数据
    modified_data, civ_files = load_civs_from_folder(original_folder)
    
    with open(changes_file, 'r', encoding='utf-8') as f:
        changes = json.load(f)

    for change in changes["changes"]:
        action = change["action"]
        civ_ids = change["civ_id"] if isinstance(change["civ_id"], list) else [change["civ_id"]]
        use_type = change.get("Use Type", "")

        if action == "deleteciv":
            modified_data["civs"] = [civ for civ in modified_data["civs"] if civ["civ_id"] not in civ_ids]
            # 同时从文件映射中删除
            for cid in civ_ids:
                if cid in civ_files:
                    del civ_files[cid]
            continue

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
                    new_item = {key: value for key, value in change.items() if key not in ["action", "civ_id", "position", "target_id", "note"]}
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
                            if item["Node ID"] == node_id and (item.get("Use Type") == use_type or (item.get("Use Type") == "Building" and use_type == "Unit")):
                                for key, value in change.items():
                                    if key not in ["action", "civ_id", "Node ID", "note"]:
                                        item[key] = value
                                break
                            elif item["Node ID"] == node_id and item.get("Use Type") != use_type:
                                pass
                elif action == "delete":
                    node_ids = change["Node ID"] if isinstance(change["Node ID"], list) else [change["Node ID"]]
                    target_list[:] = [
                        item for item in target_list
                        if item["Node ID"] not in node_ids or (item.get("Use Type") != use_type) and not (item.get("Use Type") == "Building" and use_type == "Unit")
                    ]

    # 保存到输出文件夹（当前目录下的CivTechTrees）
    save_civs_to_folder(output_folder, modified_data, civ_files)

# 使用示例
apply_changes(
    original_folder="E:/Programs/steamapps/common/AoE2DE/resources/_common/dat/CivTechTrees",
    changes_file="ctt_changes.json"
)
