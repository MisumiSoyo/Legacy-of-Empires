import json
with open('changes.json', 'r', encoding='utf-8') as f:
    changes_json = json.load(f)

unit_change_list = [item
    for sublist in changes_json["unit_changes"].values()
    for item in sublist
]
for armor_type in changes_json["remove_armor_type"]:
    unit_change_list.append({
        "id_by_key": armor_type,
        "key_type": "attack_type",
        "attacks": { armor_type: None }
    })
    unit_change_list.append({
        "id_by_key": armor_type,
        "key_type": "armor_type",
        "armors": { armor_type: None }
    })
for create_attack_type in changes_json["create_attack_type"]:
    for atk in create_attack_type["attack_type"]:
        unit_change_list.append({
            "id_by_key": create_attack_type["class_id"],
            "key_type": "class_",
            "id_by_key_2": atk,
            "key_type_2": "attack_type",
            "reverse_2": True,
            "attacks": { atk: 0 }
        })

tech_change_dict = {
    "disable_techs": [
        id for item in changes_json["tech_changes"]["disable_techs"] 
        for id in ([item['id']] if isinstance(item['id'], int) else item['id'])
    ],
    **{
        key: {
            item["id"]: item["value"] for item in 
            changes_json.get("tech_changes", {}).get(key, [])
        }
        for key in [
            "tech_time_modifier",
            "tech_cost_modifier",
            "tech_tree_enable",
            "tech_tree_disable"
        ]
    },
    "sync_unit_buff": set(changes_json["tech_changes"]["sync_unit_buff"])
}

copy_dict = {
    "resource_list": [
        id_item["id"] for id_item in changes_json["resource_changes"]
    ],
    **{
        key: [
            id for item in changes_json.get("copy_from_old_datafile", {}).get(key, []) 
            for id in ([item['id']] if isinstance(item['id'], int) else item['id'])
        ]
        for key in [
            "unit_list",
            "tech_list",
            "effect_list"
        ]
    }
}

changes_json = None