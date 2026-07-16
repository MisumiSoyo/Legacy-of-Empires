import json
import os
from pathlib import Path

os.chdir(Path(__file__).parent)

# type 到 atlas_name 的映射
TYPE_TO_ATLAS = {
    "Units": "ingameunits",
    "Techs": "ingametechs",
    "Buildings": "ingamebuildings"
}

def update_json_files(icons_path, materials_path, changes_path):
    """
    根据im_changes.json中的指令，自动分配ID并更新icons.json和materials.json
    直接覆盖原文件输出到当前目录
    """

    # 读取源文件
    with open(icons_path, 'r', encoding='utf-8') as f:
        icons_data = json.load(f)

    with open(materials_path, 'r', encoding='utf-8') as f:
        materials_data = json.load(f)

    # 读取修改指令
    with open(changes_path, 'r', encoding='utf-8') as f:
        changes = json.load(f)

    # 处理每个change
    for change in changes.get("changes", []):
        change_type = change.get("type")
        icon_name = change.get("icon_name")
        source_file = change.get("source_file")  # 必需，手动指定

        # 检查必需字段
        if not change_type or not icon_name or not source_file:
            print(f"警告: change缺少必需字段(type/icon_name/source_file)，跳过: {change}")
            continue

        # 检查type是否有效
        if change_type not in TYPE_TO_ATLAS:
            print(f"警告: 未知的type '{change_type}'，跳过")
            continue

        # 确保分类存在
        if change_type not in icons_data:
            icons_data[change_type] = {}

        # 自动分配ID
        entry_id = _get_next_id(icons_data[change_type])
        entry_id_str = str(entry_id)

        # 获取对应的atlas_name
        atlas_name = TYPE_TO_ATLAS[change_type]

        # 1. 更新icons.json
        icons_data[change_type][entry_id_str] = icon_name

        # 2. 更新materials.json中的Materials
        _update_materials_list(materials_data, icon_name, atlas_name)

        # 3. 更新materials.json中的AtlasTextures
        _update_atlas_textures(
            materials_data,
            icon_name=icon_name,
            source_file=source_file,
            atlas_name=atlas_name,
            coords=change.get("atlas_coords")
        )

        print(f"✓ 已添加: [{change_type}] ID {entry_id} -> {icon_name} ({source_file})")

    # 直接保存到当前目录，覆盖原文件名
    with open('icons.json', 'w', encoding='utf-8') as f:
        json.dump(icons_data, f, ensure_ascii=False, indent=4)

    with open('materials.json', 'w', encoding='utf-8') as f:
        json.dump(materials_data, f, ensure_ascii=False, indent=4)

    print(f"\n处理完成！文件已保存到当前目录")


def _get_next_id(type_dict):
    """获取下一个可用ID"""
    if not type_dict:
        return 1

    try:
        max_id = max(int(k) for k in type_dict.keys())
        return max_id + 1
    except ValueError:
        return 1


def _update_materials_list(materials_data, icon_name, atlas_name):
    """更新materials.json中的Materials列表"""
    materials_list = materials_data.get("Materials", [])

    new_material = {
        "MaterialDef": {
            "Name": icon_name,
            "Type": "Atlas",
            "Blend": "AlphaPlayerColor",
            "TextureRef": icon_name,
            "AtlasRef": atlas_name
        }
    }

    # 检查是否已存在
    for i, material in enumerate(materials_list):
        if material.get("MaterialDef", {}).get("Name") == icon_name:
            materials_list[i] = new_material
            return

    materials_list.append(new_material)


def _update_atlas_textures(materials_data, icon_name, source_file, atlas_name, coords=None):
    """更新AtlasTextures中的纹理条目"""

    # 默认坐标
    default_coords = {
        "imageTLX": "0.037109",
        "imageTLY": "0.740813",
        "imageBRX": "0.074002",
        "imageBRY": "0.777705"
    }

    final_coords = {
        "imageTLX": str(coords.get("imageTLX", default_coords["imageTLX"])) if coords else default_coords["imageTLX"],
        "imageTLY": str(coords.get("imageTLY", default_coords["imageTLY"])) if coords else default_coords["imageTLY"],
        "imageBRX": str(coords.get("imageBRX", default_coords["imageBRX"])) if coords else default_coords["imageBRX"],
        "imageBRY": str(coords.get("imageBRY", default_coords["imageBRY"])) if coords else default_coords["imageBRY"]
    }

    # 找到对应的Atlas
    for atlas in materials_data.get("AtlasTextures", []):
        if atlas.get("AtlasDef", {}).get("Name") == atlas_name:
            textures = atlas["AtlasDef"]["Textures"]

            # 检查是否已存在
            for texture in textures:
                if texture.get("RefName") == icon_name:
                    texture.update({
                        "RefName": icon_name,
                        "FileName": source_file,
                        **final_coords
                    })
                    return

            # 未找到，添加新条目
            textures.append({
                "RefName": icon_name,
                "FileName": source_file,
                **final_coords
            })
            return

    print(f"  警告: 未找到Atlas '{atlas_name}'")


# ==================== 使用示例 ====================

if __name__ == "__main__":
    # 输入文件路径（源文件位置）
    icons_path = r"C:\Steam\steamapps\common\AoE2DE\widgetui\icons.json"
    materials_path = r"C:\Steam\steamapps\common\AoE2DE\widgetui\materials.json"
    changes_path = r"im_changes.json"

    update_json_files(icons_path, materials_path, changes_path)
