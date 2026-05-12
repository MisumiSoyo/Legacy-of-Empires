import sys
sys.dont_write_bytecode = True

from utils import *
from inputs import *

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


import math

ANY = "any"
FLOAT_REL_TOL = 1e-5
FLOAT_ABS_TOL = 1e-6


def match_command(cmd, match_list):
    for match in match_list:
        m_type, m_a, m_b, m_c, m_d = match
        if not (m_type == ANY or cmd.type == m_type):
            continue
        if not (m_a == ANY or cmd.a == m_a):
            continue
        if not (m_b == ANY or cmd.b == m_b):
            continue
        if not (m_c == ANY or cmd.c == m_c):
            continue
        if m_d == ANY:
            return True
        if math.isclose(cmd.d, m_d, rel_tol=FLOAT_REL_TOL, abs_tol=FLOAT_ABS_TOL):
            return True
    return False


def apply_modification(cmd, field, op, value):
    current = getattr(cmd, field)
    if op == "set":
        new_value = value
    elif op == "add":
        new_value = current + value
    elif op == "mul":
        new_value = current * value
    else:
        raise ValueError(f"不支持的修改操作: {op}")
    setattr(cmd, field, type(current)(new_value))


def parseAttrPath(attr_path):
    import re
    return re.findall(r'[^\.\[\]]+|\[\d+\]', attr_path)


def setNestedAttribute(obj, attr_path, value):
    tokens = parseAttrPath(attr_path)
    current = obj
    for token in tokens[:-1]:
        if token.startswith('[') and token.endswith(']'):
            idx = int(token[1:-1])
            current = current[idx]
        else:
            current = getattr(current, token)
    last_token = tokens[-1]
    if last_token.startswith('[') and last_token.endswith(']'):
        idx = int(last_token[1:-1])
        current[idx] = value
    else:
        setattr(current, last_token, value)


def getNestedAttribute(obj, attr_path):
    tokens = parseAttrPath(attr_path)
    current = obj
    for token in tokens:
        if token.startswith('[') and token.endswith(']'):
            idx = int(token[1:-1])
            current = current[idx]
        else:
            current = getattr(current, token)
    return current


def normalizeIdList(ids):
    if isinstance(ids, (int, float)):
        return [int(ids)]
    return [int(x) for x in ids]


def applyCivTechTreeEffects(data):
    for i in range(len(data.civs)):
        civ = data.civs[i]
        EffectID = civ.tech_tree_id
        data.effects[EffectID].effect_commands.append(
            EffectCommand(type=1, a=33, b=0, c=-1, d=10001.0)
        )


def applyEffectChanges(data, effect_change_list):
    for effect_change in effect_change_list:
        effect_ids = effect_change["effect_id"]
        if isinstance(effect_ids, (int, float)):
            effect_ids = [effect_ids]
        
        change_type = effect_change.get("type", "adjustment")
        
        for effect_id in effect_ids:
            if change_type == "add":
                commands = effect_change["commands"]
                if isinstance(commands[0], (int, float)):
                    commands = [commands]
                
                # 获取插入位置，不指定则默认为 None（表示追加到最后）
                position = effect_change.get("position", None)
                
                effect_commands = data.effects[effect_id].effect_commands
                
                for cmd in commands:
                    cmd_type, a, b, c, d = cmd
                    # 确保 d 是 float 类型
                    d = float(d)
                    new_cmd = EffectCommand(type=cmd_type, a=a, b=b, c=c, d=d)
                    
                    if position is None:
                        # 不指定位置，默认追加到最后（原行为）
                        effect_commands.append(new_cmd)
                    else:
                        # 指定了位置，在指定索引处插入
                        pos = int(position)
                        if pos < 0:
                            pos = max(0, len(effect_commands) + pos + 1)
                        pos = min(pos, len(effect_commands))
                        effect_commands.insert(pos, new_cmd)
                        # 每插入一个命令后，后续同批次命令的位置需要顺延
                        position = pos + 1
                    
            elif change_type == "delete":
                match_list = effect_change.get("match", [])
                if isinstance(match_list[0], (int, float, str)):
                    match_list = [match_list]
                data.effects[effect_id].effect_commands = [
                    cmd for cmd in data.effects[effect_id].effect_commands 
                    if not match_command(cmd, match_list)
                ]
                
            elif change_type == "modify":
                match_list = effect_change.get("match", [])
                if isinstance(match_list[0], (int, float, str)):
                    match_list = [match_list]
                modifications = effect_change.get("modifications", [])
                if modifications and isinstance(modifications[0], str):
                    modifications = [modifications]
                for cmd in data.effects[effect_id].effect_commands:
                    if match_command(cmd, match_list):
                        for field, op, value in modifications:
                            apply_modification(cmd, field, op, value)
                            
            else:
                function_id = effect_change["function_id"]
                data.effects[effect_id].effect_commands.append(
                    EffectCommand(type=1, a=33, b=0, c=-1, d=function_id)
                )


def applyAttributeChange(obj, attr_change):
    """
    应用单个属性修改
    格式1: [path, value]          -> 直接赋值
    格式2: [path, op, value]      -> 运算修改
    """
    if len(attr_change) == 2:
        attr_path, new_value = attr_change
        setNestedAttribute(obj, attr_path, new_value)
    elif len(attr_change) == 3:
        attr_path, op, value = attr_change
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
    else:
        raise ValueError(f"不支持的属性修改格式: {attr_change}")


def applyUnitChanges(data, unit_change_list):
    for change in unit_change_list:
        unit_ids = normalizeIdList(change["unit_id"])
        civs = change.get("civs", "all")
        attributes = change.get("attributes", [])
        
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
                
                for attr_change in attributes:
                    applyAttributeChange(unit, attr_change)


def applyResourceChanges(data, resource_change_list):
    """
    应用文明资源修改
    resources 是 civ 下的简单数值列表: civ.resources[resource_id] = value
    配置格式：
    {
        "resource_id": <int> or [<int>, ...],  # 资源ID（列表索引）
        "civs": "all" or [<int>, ...],         # 目标文明，默认全文明
        "value": <number>,                      # 直接赋值
        # 或
        "op": "set"/"add"/"mul",                # 运算类型
        "value": <number>,                      # 运算值
    }
    """
    for change in resource_change_list:
        resource_ids = normalizeIdList(change["resource_id"])
        civs = change.get("civs", "all")
        op = change.get("op", "set")
        value = change["num"]
        
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
    """
    应用科技(Tech)修改
    Tech 直接属于 data/loe 下的子对象，支持嵌套属性修改
    配置格式：
    {
        "tech_id": <int> or [<int>, ...],      # 科技ID
        "attributes": [                         # 属性修改列表
            ["name", "新科技名称"],              # 直接赋值
            ["research_time", 50],              # 研究时间设为50
            ["research_time", "mul", 0.8],      # 运算修改
            ["required_techs[0]", 101],         # 数组元素修改
            ["tech_effects[0].type", 1],        # 嵌套对象属性
        ]
    }
    """
    for change in tech_change_list:
        tech_ids = normalizeIdList(change["tech_id"])
        attributes = change.get("attributes", [])
        
        for tech_id in tech_ids:
            if tech_id >= len(data.techs):
                continue
                
            tech = data.techs[tech_id]
            
            for attr_change in attributes:
                applyAttributeChange(tech, attr_change)


def customChanges(data):
    applyCivTechTreeEffects(data)
    
    if 'effect_change_list' in globals():
        applyEffectChanges(data, effect_change_list)
    
    if 'unit_change_list' in globals():
        applyUnitChanges(data, unit_change_list)
    
    # 新增：文明资源修改
    if 'resource_change_list' in globals():
        applyResourceChanges(data, resource_change_list)
    
    # 新增：科技修改
    if 'tech_change_list' in globals():
        applyTechChanges(data, tech_change_list)
    
    return


if __name__ == "__main__":
    run()
