import sys
sys.dont_write_bytecode = True

import json
from pathlib import Path

CHANGES_FILE = Path('changes.json')
with open(CHANGES_FILE, 'r', encoding='utf-8') as f:
    changes_json = json.load(f)

# 支持通过 "includes" 引用外部 JSON 文件, 各模块的改动列表会按引用顺序追加到主文件之后
_INCLUDE_MODULES = ("effect_adjustments", "unit_changes", "tech_changes", "resource_changes")
for include_path in changes_json.get("includes", []):
    include_file = Path(include_path)
    if not include_file.is_absolute():
        include_file = CHANGES_FILE.parent / include_file
    with open(include_file, 'r', encoding='utf-8') as f:
        included_json = json.load(f)
    for module in _INCLUDE_MODULES:
        if module in included_json:
            changes_json.setdefault(module, []).extend(included_json[module])

copy_dict = {
    **{
        key: [
            id for item in changes_json.get("copy_from_old_datafile", {}).get(key, []) 
            for id in ([item['id']] if isinstance(item['id'], int) else item['id'])
        ]
        for key in [
            "unit_list",
            "tech_list",
            "effect_list",
            "resource_list"
        ]
    }
}


effect_change_list = changes_json["effect_adjustments"]
unit_change_list = changes_json["unit_changes"]
tech_change_list = changes_json["tech_changes"]
resource_change_list = changes_json["resource_changes"]

changes_json = None
