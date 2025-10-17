import json
import copy

def apply_changes(original_file, changes_file, output_file):
    # 读取原始文件
    with open(original_file, 'r', encoding='utf-8') as f:
        original_data = json.load(f)

    # 读取修改文件
    with open(changes_file, 'r', encoding='utf-8') as f:
        changes = json.load(f)

    # 创建原始数据的副本，避免修改原始数据
    modified_data = copy.deepcopy(original_data)

    # 遍历每个修改指令
    for change in changes["changes"]:
        action = change["action"]
        civ_ids = change["civ_id"] if isinstance(change["civ_id"], list) else [change["civ_id"]]
        use_type = change.get("Use Type", "")  # 获取 Use Type 字段

        # 确定目标列表（Unit 或 Tech 或 Building）
        for civ_id in civ_ids:
            # 如果 civ_id 是 "all"，则处理所有文明
            target_civs = []
            if civ_id == "all":
                target_civs = modified_data["civs"]
            else:
                # 查找指定的文明
                for civ in modified_data["civs"]:
                    if civ["civ_id"] == civ_id:
                        target_civs.append(civ)

            for civ in target_civs:
                if use_type in ["Unit", "Tech"]:
                    target_list = civ["civ_techs_units"]
                elif use_type == "Building":
                    target_list = civ["civ_techs_buildings"]
                else:
                    continue  # 跳过未知的 Use Type

                if action == "add":
                    # 添加新单位、科技或建筑
                    # 过滤掉 action 和 civ_id 字段，保留其他所有字段
                    new_item = {key: value for key, value in change.items() if key not in ["action", "civ_id", "position", "target_id"]}
                    
                    # 默认插入到末尾
                    insert_position = len(target_list)
                    
                    # 根据 position 和 target_id 确定插入位置
                    position = change.get("position", "last").lower()
                    target_id = change.get("target_id", None)
                    
                    if position == "first":
                        insert_position = 0
                    elif position in ["before", "after"] and target_id is not None:
                        for idx, item in enumerate(target_list):
                            if item["Node ID"] == target_id:
                                if position == "before":
                                    insert_position = idx
                                else:  # after
                                    insert_position = idx + 1
                                break
                    
                    # 插入新项目
                    target_list.insert(insert_position, new_item)
                elif action == "modify":
                    # 修改现有单位、科技或建筑
                    node_ids = change["Node ID"] if isinstance(change["Node ID"], list) else [change["Node ID"]]
                    
                    for node_id in node_ids:
                        for item in target_list:
                            if item["Node ID"] == node_id:
                                # 更新字段（过滤掉 action 和 civ_id）
                                for key, value in change.items():
                                    if key not in ["action", "civ_id", "Node ID"]:
                                        item[key] = value
                                break
                elif action == "delete":
                    # 删除单位、科技或建筑
                    node_ids = change["Node ID"] if isinstance(change["Node ID"], list) else [change["Node ID"]]
                    # 记录删除前的节点
                    target_list[:] = [item for item in target_list if item["Node ID"] not in node_ids]

    # 保存修改后的文件
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(modified_data, f, indent=4, ensure_ascii=False)

# 示例调用
apply_changes(
    original_file="E:/Programs/steamapps/common/AoE2DE/resources/_common/dat/civTechTrees.json",
    changes_file="ctt_changes.json",
    output_file="civTechTrees.json"
)
