import sys
sys.dont_write_bytecode = True

import json
with open('changes.json', 'r', encoding='utf-8') as f:
    changes_json = json.load(f)

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
