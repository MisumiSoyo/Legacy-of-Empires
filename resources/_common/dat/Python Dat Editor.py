import sys
sys.dont_write_bytecode = True

from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent.parent.parent.parent))

from utils import *
from inputs import *
from paths import OFFICIAL_DATA_FILE, OUTPUT_DATA_FILE

official_data_file = str(OFFICIAL_DATA_FILE)
old_loe_file = str(OUTPUT_DATA_FILE)
save_file = str(OUTPUT_DATA_FILE)

def run():
    data = DatFile.parse(official_data_file)
    loe = DatFile.parse(old_loe_file)
    copyFromOldVersion(loe.techs, data.techs, copy_dict["tech_list"], loe.techs[1250], 3001)
    copyFromOldVersion(loe.effects, data.effects, copy_dict["effect_list"], loe.effects[0], 3001)
    copyFromOldVersion(loe.graphics, data.graphics, [], loe.graphics[0], 20001)
    source_units = loe.civs[0].units
    blank_unit = source_units[999]
    source_resources = loe.civs[1].resources
    data_civs = len(data.civs)
    loe_civs = len(loe.civs)
    for i in range(data_civs):
        civ = data.civs[i]
        if i < loe_civs:
            source_units = loe.civs[i].units
            source_resources = loe.civs[i].resources
        else:
            source_units = loe.civs[0].units
            source_resources = loe.civs[0].resources
        blank_unit = source_units[999]
        copyFromOldVersion(source_units, civ.units, copy_dict["unit_list"], blank_unit, 4001)
        copyFromOldVersion(source_resources, civ.resources, copy_dict["resource_list"], 0)
        copyFromOldVersion(source_resources, civ.resources, [], civ.resources[0], 701)

    customChanges(data)

    # 保存
    data.save(save_file)


# ==================== 各修改模块（集成搜索） ====================

def applyCivTechTreeEffects(data):
    for i in range(len(data.civs)):
        civ = data.civs[i]
        EffectID = civ.tech_tree_id
        data.effects[EffectID].effect_commands.append(
            EffectCommand(type=1, a=33, b=0, c=-1, d=10001.0)
        )


def applyEffectChanges(data, effect_change_list):
    for effect_change in effect_change_list:
        effect_ids = effect_change.get("effect_id")
        effect_ids = normalizeIdList(effect_ids)  # None 表示所有
        if effect_ids is None:
            effect_ids = range(len(data.effects))  # 遍历所有效果
        
        change_type = effect_change.get("type", "adjustment")
        search_config = effect_change.get("search")
        search_func = create_search_function(search_config)
        
        for effect_id in effect_ids:
            if effect_id >= len(data.effects):
                continue
                
            effect = data.effects[effect_id]
            
            if change_type == "add":
                commands = effect_change["commands"]
                if isinstance(commands[0], (int, float)):
                    commands = [commands]
                
                position = effect_change.get("position", None)
                effect_commands = effect.effect_commands
                
                for cmd in commands:
                    cmd_type, a, b, c, d = cmd
                    d = float(d)
                    new_cmd = EffectCommand(type=cmd_type, a=a, b=b, c=c, d=d)
                    
                    if position is None:
                        effect_commands.append(new_cmd)
                    else:
                        pos = int(position)
                        if pos < 0:
                            pos = max(0, len(effect_commands) + pos + 1)
                        pos = min(pos, len(effect_commands))
                        effect_commands.insert(pos, new_cmd)
                        position = pos + 1
                    
            elif change_type == "delete":
                match_list = effect_change.get("match", [])
                if isinstance(match_list[0], (int, float, str)):
                    match_list = [match_list]
                
                def should_delete(cmd):
                    if search_func and not search_func(cmd):
                        return False
                    return match_command(cmd, match_list)
                
                data.effects[effect_id].effect_commands = [
                    cmd for cmd in data.effects[effect_id].effect_commands 
                    if not should_delete(cmd)
                ]
                
            elif change_type == "modify":
                match_list = effect_change.get("match", [])
                if isinstance(match_list[0], (int, float, str)):
                    match_list = [match_list]
                modifications = effect_change.get("modifications", [])
                if modifications and isinstance(modifications[0], str):
                    modifications = [modifications]
                
                for cmd in data.effects[effect_id].effect_commands:
                    if search_func and not search_func(cmd):
                        continue
                    if match_command(cmd, match_list):
                        for field, op, value in modifications:
                            apply_modification(cmd, field, op, value)
                            
            else:
                function_id = effect_change["function_id"]
                data.effects[effect_id].effect_commands.append(EffectCommand(type=1, a=33, b=0, c=-1, d=function_id))


def applyAttributeChange(obj, attr_change):
    """
    应用单个属性修改，支持列表元素搜索修改或删除
    
    格式1: [path, value]                    -> 直接赋值
    格式2: [path, op, value]                -> 运算修改
    格式3: [list_path, "list_search", element_search, elem_attr_change]  
                                          -> 在列表中搜索元素并修改或删除
                                          
    element_search 支持:
        - 单层列表: ["field", "op", value] 或 ["field", value]  单条件
        - 两层列表: [["field1", "op1", val1], ["field2", "op2", val2]]  多条件AND
        - 字典: {"and": [...]} 或 {"or": [...]}  复杂组合
    
    elem_attr_change 支持:
        - "delete"                              删除匹配元素本身
        - [attr_path, value]                    直接赋值
        - [attr_path, op, value]                运算修改 (set/add/mul)
    """
    if len(attr_change) == 2:
        attr_path, new_value = attr_change
        setNestedAttribute(obj, attr_path, new_value)
    
    elif len(attr_change) == 3:
        attr_path, op, value = attr_change
        
        # 检查是否是列表搜索操作
        if op == "list_search":
            # attr_change = ["resource_costs", "list_search", element_search, elem_attr_change]
            # 但这里只有3个元素，说明格式不对，需要4个元素
            raise ValueError(
                "list_search 格式需要4个元素: [list_path, 'list_search', element_search_config, elem_attr_change]. "
                "例如: ['resource_costs', 'list_search', ['type', '=', 0], ['amount', 'add', 50]]"
            )
        
        current = getNestedAttribute(obj, attr_path)
        if op == "set":
            final_value = value
        elif op == "add":
            final_value = current + value
        elif op == "mul":
            final_value = current * value
        else:
            raise ValueError(f"不支持的修改操作: {op}")
        setNestedAttribute(obj, attr_path, type(current)(final_value))
    
    elif len(attr_change) == 4:
        list_path, op, element_search, elem_attr_change = attr_change
        
        if op != "list_search":
            raise ValueError(f"4元素格式只支持 list_search 操作，当前 op={op}")
        
        applyListElementChange(obj, list_path, element_search, elem_attr_change)
    
    else:
        raise ValueError(f"不支持的属性修改格式: {attr_change}")


def applyUnitChanges(data, unit_change_list):
    for change in unit_change_list:
        unit_ids = change.get("unit_id")
        unit_ids = normalizeIdList(unit_ids)  # None 表示所有
        if unit_ids is None:
            unit_ids = range(len(data.civs[0].units))  # 遍历所有单位ID
        
        civs = change.get("civs", "all")
        attributes = change.get("attributes", [])
        search_config = change.get("search")
        search_func = create_search_function(search_config)
        
        if civs == "all":
            target_civs = range(len(data.civs))
        else:
            target_civs = civs
        
        for civ_idx in target_civs:
            civ = data.civs[civ_idx]
            
            for unit_id in unit_ids:
                if unit_id >= len(civ.units):
                    continue
                    
                unit = civ.units[unit_id]
                
                if search_func and not search_func(unit):
                    continue
                
                for attr_change in attributes:
                    applyAttributeChange(unit, attr_change)


def applyResourceChanges(data, resource_change_list):
    for change in resource_change_list:
        resource_ids = change.get("resource_id")
        resource_ids = normalizeIdList(resource_ids)  # None 表示所有
        if resource_ids is None:
            resource_ids = range(len(data.civs[0].resources))  # 遍历所有资源
        
        civs = change.get("civs", "all")
        op = change.get("op", "set")
        value = change["num"]
        search_config = change.get("search")
        search_func = create_search_function(search_config)
        
        if civs == "all":
            target_civs = range(len(data.civs))
        else:
            target_civs = civs
        
        for civ_idx in target_civs:
            civ = data.civs[civ_idx]
            
            for resource_id in resource_ids:
                if resource_id >= len(civ.resources):
                    continue
                
                current = civ.resources[resource_id]
                
                if search_func:
                    resource_wrapper = type('ResourceWrapper', (), {
                        'value': current, 
                        'id': resource_id,
                        'civ_id': civ_idx
                    })()
                    if not search_func(resource_wrapper):
                        continue
                
                if op == "set":
                    new_value = value
                elif op == "add":
                    new_value = current + value
                elif op == "mul":
                    new_value = current * value
                else:
                    raise ValueError(f"不支持的资源修改操作: {op}")
                
                civ.resources[resource_id] = type(current)(new_value)


def applyTechChanges(data, tech_change_list):
    for change in tech_change_list:
        tech_ids = change.get("tech_id")
        tech_ids = normalizeIdList(tech_ids)  # None 表示所有
        if tech_ids is None:
            tech_ids = range(len(data.techs))  # 遍历所有科技
        
        attributes = change.get("attributes", [])
        search_config = change.get("search")
        search_func = create_search_function(search_config)
        
        for tech_id in tech_ids:
            if tech_id >= len(data.techs):
                continue
                
            tech = data.techs[tech_id]
            
            if search_func and not search_func(tech):
                continue
            
            for attr_change in attributes:
                applyAttributeChange(tech, attr_change)


def customChanges(data):
    applyCivTechTreeEffects(data)
    
    if 'effect_change_list' in globals():
        applyEffectChanges(data, effect_change_list)
    
    if 'unit_change_list' in globals():
        applyUnitChanges(data, unit_change_list)
    
    if 'resource_change_list' in globals():
        applyResourceChanges(data, resource_change_list)
    
    if 'tech_change_list' in globals():
        applyTechChanges(data, tech_change_list)
    
    return


if __name__ == "__main__":
    run()
