from toolbox import *

def getIdByName(data, name: Union[int, List[int], Set[int]], key: str = "name", reverse: bool = False) -> Set[int]:
    result = set()
    name = to_set(name)

    # 检查 key 是否支持
    if key not in key_getters:
        raise ValueError(f"不支持的 key: {key} 在 name: {name}")

    getter = key_getters[key]
    for unit in data.civs[0].units:
        if unit is None:
            continue
        value = to_set(getter(unit))
        # 当reverse=False时：需要value & name不为空
        # 当reverse=True时：需要value & name为空
        if (not value & name) == reverse:
            result.add(unit.id)
    return result


def applyUnitChanges(data, changes, copy_tuple_set):
    for change in changes:
        if "ids" in change:
            unit_ids = change["ids"]
        elif "id_by_key" in change:
            unit_ids = getIdByName(data, change["id_by_key"], change.get("key_type", "name"), change.get("reverse", False))
            if "id_by_key_2" in change:
                unit_ids &= getIdByName(data, change["id_by_key_2"], change.get("key_type_2", "name"), change.get("reverse_2", False))
        else:
            print(f"[警告] 在 '{change}' 中没有指定 id，此改动被跳过")
            continue

        # 检查是否有未知字段
        for key in change:
            if key not in valid_fields:
                print(f"[警告] 在 '{unit_ids}' 中发现未知字段 '{key}'，可能是拼写错误或未启用该字段")

        unit_ids = to_set(unit_ids)
        civ_ids = to_set(change.get("civ", range(len(data.civs))))
        for civ_id in civ_ids:
            for unit_id in unit_ids:
                unit = data.civs[civ_id].units[unit_id]
                if unit is None:
                    continue
                _miscChanges(data, civ_id, unit, change, copy_tuple_set)
                _directChanges(unit, change)
                _combatChanges(unit, change)
                _costChanges(unit, change)


def applyTechChanges(data, changes):
    # Disable Techs
    for tech_id in changes["disable_techs"]:
        data.techs[tech_id].effect_id = -1

    # Modify Tech Time
    for tech_id, new_time in changes["tech_time_modifier"].items():
        data.techs[tech_id].research_time = new_time

    # Modify Tech Cost
    for tech_id, cost in changes["tech_cost_modifier"].items():
        _costModifier(data.techs[tech_id].resource_costs, parse_costs_regex(cost))

    # Tech Tree Enable
    for civ_id, techs in changes["tech_tree_enable"].items():
        tree = data.effects[data.civs[civ_id].tech_tree_id].effect_commands
        tree[:] = [t for t in tree if not (t.type == 102 and t.d in to_set(techs))]

    # Tech Tree Disable
    for civ_id, techs in changes["tech_tree_disable"].items():
        tree = data.effects[data.civs[civ_id].tech_tree_id].effect_commands
        for tech in to_set(techs):
            tree.append(EffectCommand(102, -1, -1, -1, tech))

    # Sync Unit Buff
    sync_units = changes["sync_unit_buff"]
    for effect in data.effects:
        commands = []
        for cmd in effect.effect_commands:
            commands.append(cmd)
            for unit_pair in sync_units:
                if cmd.type in sync_effect_type and cmd.a == unit_pair[0]:
                    commands.append(EffectCommand(cmd.type, unit_pair[1], cmd.b, cmd.c, cmd.d))
        effect.effect_commands = commands


def copyFromOldVersion(source_list, target_list, ids, blank_item, all_copy_start=9999):
    ids += list(range(all_copy_start, len(source_list)))
    for item_id in ids:
        if item_id >= len(target_list):
            while item_id >= len(target_list):
                target_list.append(copy(blank_item))
        target_list[item_id] = copy(source_list[item_id])


def _directChanges(unit, change):
    for key, attr_paths in field_mapping.items():
        if key in change:
            value = change[key]
            attr_paths = to_set(attr_paths)
            for attr_path in attr_paths:
                obj = unit
                parent_obj = None
                last_attr = None

                if not isinstance(attr_path, tuple):
                    attr_path = (attr_path,)

                for attr in attr_path[:-1]:
                    if isinstance(attr, int):
                        parent_obj = obj
                        last_attr = attr
                        obj = obj[attr]
                    else:
                        parent_obj = obj
                        last_attr = attr
                        obj = getattr(obj, attr, None)
                        if obj is None:
                            break

                final_attr = attr_path[-1]

                if obj is not None:
                    if isinstance(final_attr, int):
                        if isinstance(obj, list) and 0 <= final_attr < len(obj):
                            obj[final_attr] = apply_modifier(obj[final_attr], value)
                        elif isinstance(obj, tuple) and 0 <= final_attr < len(obj):
                            # 将 tuple 转为 list 修改后再转回 tuple
                            temp = list(obj)
                            temp[final_attr] = apply_modifier(temp[final_attr], value)
                            # 找到上层对象并替换该 tuple 属性
                            if parent_obj is not None and last_attr is not None:
                                setattr(parent_obj, last_attr, tuple(temp))
                            else:
                                print(f"[警告] 无法更新 tuple 属性 '{final_attr}'，缺少父对象信息")
                        else:
                            print(f"[警告] 索引越界或非列表/元组对象，无法修改：{final_attr}")
                    else:
                        try:
                            setattr(obj, final_attr, apply_modifier(getattr(obj, final_attr), value))
                        except Exception as e:
                            print(f"[警告] 设置属性失败：{e}")


def _combatChanges(unit, change):
    if "atk" in change:
        _setAttacksOrArmours(unit, "attacks", 4, change["atk"], create=False)
        _setAttacksOrArmours(unit, "attacks", 3, change["atk"], create=False)

    if "attacks" in change:
        for attack_type in change["attacks"]:
            value = change["attacks"][attack_type]
            if isinstance(value, int):
                _setAttacksOrArmours(unit, "attacks", int(attack_type), value)
            else:
                unit.type_50.attacks = [x for x in unit.type_50.attacks if x.class_ != int(attack_type)]

    if "ma" in change:
        _setAttacksOrArmours(unit, "armours", 4, change["ma"])

    if "pa" in change:
        _setAttacksOrArmours(unit, "armours", 3, change["pa"])

    if "armors" in change:
        for armor_type in change["armors"]:
            value = change["armors"][armor_type]
            if isinstance(value, int):
                _setAttacksOrArmours(unit, "armours", int(armor_type), value)
            else:
                unit.type_50.armours = [x for x in unit.type_50.armours if x.class_ != int(armor_type)]


def _costChanges(unit, change):
    if not hasattr(unit.creatable, 'resource_costs'):
        return

    if "remove_cost_type" in change:
        for cost in unit.creatable.resource_costs:
            if cost.type == change["remove_cost_type"]:
                cost.type = -1
                cost.amount = 0
                cost.flag = 0
                break

    if "add_cost_type" in change:
        for cost in unit.creatable.resource_costs:
            if cost.type == change["add_cost_type"]:
                break
            if cost.type == -1:
                cost.type = change["add_cost_type"]
                cost.flag = 1
                break

    if "costs" in change:
        cost_dict = parse_costs_regex(change["costs"])
        change.update(cost_dict)

    _costModifier(unit.creatable.resource_costs, change)


def _miscChanges(data, civ_id, unit, change, copy_tuple_set):
    if "copy_from_civ" in change:
        data.civs[civ_id].units[unit.id] = copy(data.civs[change["copy_from_civ"]].units[unit.id])

    if "copy_from_unit" in change:
        old_unit = change["copy_from_unit"]
        new_unit = unit.id
        data.civs[civ_id].units[unit.id] = copy(data.civs[0].units[old_unit])
        unit.id = new_unit
        copy_tuple_set.add((old_unit, new_unit))

    if "storages" in change:
        s = change["storages"]
        if len(s) != 9:
            raise ValueError("storages 必须是长度为 9 的列表")
        unit.resource_storages = [
            ResourceStorage(s[i], s[i+1], s[i+2])
            for i in [0, 3, 6]
        ]

    if "create_task" in change:
        tasks = to_list(change["create_task"])
        for task in tasks:
            if "class_id" in task:
                class_ids = to_list(task["class_id"])
                for cid in class_ids:
                    task_kwargs = task.copy()
                    task_kwargs["class_id"] = cid
                    _appendTask(task_kwargs, unit)
            elif "unit_id" in task:
                unit_ids = to_list(task["unit_id"])
                for uid in unit_ids:
                    task_kwargs = task.copy()
                    task_kwargs["unit_id"] = uid
                    _appendTask(task_kwargs, unit)
            else:
                _appendTask(task, unit)

    if "task_modify" in change:
        modifies = change["task_modify"]
        modifies = to_list(modifies)
        for modify in modifies:
            for task in unit.bird.tasks:
                if _taskMatches(task, modify):
                    for field in task_fields:
                        if field in modify:
                            setattr(task, field, modify[field])

    if "atk_anim_duration" in change:
        dur = change["atk_anim_duration"]
        graphic_id = unit.type_50.attack_graphic
        graphic = data.graphics[graphic_id]
        graphic.frame_duration =  dur / graphic.frame_count


def _setAttacksOrArmours(unit, stat_name, class_id, num, create=True):
    stats = getattr(unit.type_50, stat_name, [])
    for stat in stats:
        if getattr(stat, 'class_', -1) == class_id:
            create = False
            stat.amount = apply_modifier(stat.amount, num)
    if create:
        stats.append(AttackOrArmor(class_id, apply_modifier(0, num)))
    
    # 如果有 display 显示值映射，也同步修改
    key = (stat_name, class_id)
    if key in display_map:
        attrs = display_map[key]
        obj = getattr(unit, attrs[0], None)
        current_value = getattr(obj, attrs[1], 0)
        setattr(obj, attrs[1], apply_modifier(current_value, num))


def _costModifier(resource_costs, change):
    for cost in resource_costs:
        if cost.type in resource_mapping:
            field_name = resource_mapping[cost.type]
            if field_name in change:
                cost.amount = apply_modifier(cost.amount, change[field_name])


def _appendTask(task_kwargs, unit):
    merged_kwargs = default_task.copy()
    merged_kwargs.update(task_kwargs)
    task = Task(**merged_kwargs)
    tasks = unit.bird.tasks
    task.id = len(tasks)
    tasks.append(task)


def _taskMatches(task, modify):
    if "filter" not in modify:
        return True
    filters = modify["filter"]
    for key in task_fields:
        if key in filters and getattr(task, key, None) != filters[key]:
            return False
    return True