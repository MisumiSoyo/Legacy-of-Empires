import json
import os
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent.parent.parent))
from paths import OFFICIAL_LINKED_TECHS_FILE, LT_CHANGES_FILE, OUTPUT_LINKED_TECHS_FILE

os.chdir(Path(__file__).parent)

def load_json_file(file_path):
    """加载JSON文件并返回内容"""
    with open(file_path, 'r', encoding='utf-8') as file:
        return json.load(file)

def save_json_file(data, file_path):
    """将数据保存到JSON文件"""
    with open(file_path, 'w', encoding='utf-8') as file:
        json.dump(data, file, indent=4, ensure_ascii=False)

def add_linked_techs(base_data, changes):
    """根据修改指令添加一组相关的科技"""
    # 获取当前最大的NameId
    existing_name_ids = [tech["NameId"] for tech in base_data["LinkedTechs"]]
    max_name_id = max(existing_name_ids) if existing_name_ids else 0

    for change in changes:
        if change.get("action") == "add":
            # 动态生成新的NameId
            max_name_id += 1
            new_tech_group = {
                "NameId": max_name_id,
                "Comment": change.get("Comment"),
                "Type": change.get("Type"),
                "Techs": change.get("Techs")
            }
            # 检查并移除note字段（如果存在）
            if "note" in change:
                print(f"Note: {change['note']}")
                del change["note"]
            base_data["LinkedTechs"].append(new_tech_group)
    return base_data

def main():
    # 加载原始游戏数据文件
    base_data = load_json_file(str(OFFICIAL_LINKED_TECHS_FILE))

    # 加载修改指令文件
    changes = load_json_file(str(LT_CHANGES_FILE))

    # 根据修改指令修改游戏数据
    modified_data = add_linked_techs(base_data, changes)

    # 保存修改后的数据到新文件
    save_json_file(modified_data, str(OUTPUT_LINKED_TECHS_FILE))

    print(f"修改完成，已保存到文件：{OUTPUT_LINKED_TECHS_FILE}")

if __name__ == "__main__":
    main()
