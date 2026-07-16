import json
import os
from typing import List, Union, Dict, Any

def read_json_file(file_path: str) -> Dict[str, Any]:
    """读取 JSON 文件内容"""
    with open(file_path, 'r', encoding='utf-8') as file:
        return json.load(file)

def write_json_file(file_path: str, data: Dict[str, Any]) -> None:
    """将数据写入 JSON 文件"""
    with open(file_path, 'w', encoding='utf-8') as file:
        json.dump(data, file, ensure_ascii=False, indent=4)

def format_icon(icon: int) -> str:
    """将 icon 数字格式化为 {icon}_50730，不足 3 位补零"""
    return f"{str(icon).zfill(3)}_50730"

def update_civilizations(
    official_civilizations: List[Dict[str, Any]],
    changes: List[Dict[str, Any]]
) -> List[Dict[str, Any]]:
    """基于 civ_changes.json 的规则更新 civilizations.json"""
    updated_civilizations = official_civilizations.copy()

    for rule in changes:
        civilizations_to_update = rule["civilizations"]
        icon = rule["icon"]
        name = rule["name"]
        note = rule.get("note", "")

        # 如果 description 存在于规则中，使用它；否则，默认为 name + 21000
        description = rule.get("description", name + 21000)

        # 将 icon 转换为格式化的字符串
        formatted_icon = format_icon(icon)

        # 如果 civilizations 是单个值，转换为列表
        if isinstance(civilizations_to_update, str):
            civilizations_to_update = [civilizations_to_update]

        for civilization_name in civilizations_to_update:
            # 查找对应文明
            target_civilization = next(
                (civ for civ in updated_civilizations if civ["internal_name"] == civilization_name),
                None
            )

            if target_civilization:
                # 更新 unique_unit_image_paths
                if "unique_unit_image_paths" not in target_civilization:
                    target_civilization["unique_unit_image_paths"] = []
                target_civilization["unique_unit_image_paths"].append(f"/resources/uniticons/{formatted_icon}.png")

                # 更新 unique_unit_string_ids
                if "unique_unit_string_ids" not in target_civilization:
                    target_civilization["unique_unit_string_ids"] = []
                target_civilization["unique_unit_string_ids"].append({
                    "name": name,
                    "description": description
                })

    return updated_civilizations

if __name__ == "__main__":
    # 文件路径配置
    official_civilizations_path = r"C:/Steam/steamapps/common/AoE2DE/resources/_common/dat/civilizations.json"
    changes_json_path = "civ_changes.json"
    output_civilizations_path = "civilizations.json"

    # 读取官方 civilizations.json
    official_data = read_json_file(official_civilizations_path)
    official_civilizations = official_data["civilization_list"]

    # 读取 civ_changes.json
    changes_data = read_json_file(changes_json_path)
    changes = changes_data.get("changes", [])

    # 应用修改规则
    custom_civilizations = update_civilizations(official_civilizations, changes)

    # 将结果写入输出文件
    output_data = {"civilization_list": custom_civilizations}
    write_json_file(output_civilizations_path, output_data)

    print(f"自定义 civilizations.json 文件已生成，保存至 {os.path.abspath(output_civilizations_path)}")
