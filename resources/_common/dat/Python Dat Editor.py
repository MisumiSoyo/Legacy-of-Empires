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

    applyUnitChanges(data, unit_change_list, tech_change_dict["sync_unit_buff"])
    applyTechChanges(data, tech_change_dict)
    customChanges(data)

    # 保存
    data.save(save_file)


import math

def customChanges(data):
    for i in range(len(data.civs)):
        civ = data.civs[i]
        EffectID = civ.tech_tree_id
        data.effects[EffectID].effect_commands.append(EffectCommand(type=1, a=33, b=0, c=-1, d=10001.0))

    ANY = "any"
    # float 比较容差参数
    FLOAT_REL_TOL = 1e-5  # 相对容差
    FLOAT_ABS_TOL = 1e-6  # 绝对容差

    def match_command(cmd, match_list):
        """通用匹配函数：检查指令是否匹配任一条件
        type(uint8), a/b/c(int16) 精确匹配；d(float) 使用 math.isclose 容差匹配
        """
        for match in match_list:
            m_type, m_a, m_b, m_c, m_d = match
            
            # type, a, b, c 精确匹配
            if not (m_type == ANY or cmd.type == m_type):
                continue
            if not (m_a == ANY or cmd.a == m_a):
                continue
            if not (m_b == ANY or cmd.b == m_b):
                continue
            if not (m_c == ANY or cmd.c == m_c):
                continue
            
            # d(float) 使用 math.isclose 容差匹配
            if m_d == ANY:
                return True
            if math.isclose(cmd.d, m_d, rel_tol=FLOAT_REL_TOL, abs_tol=FLOAT_ABS_TOL):
                return True
                
        return False

    # 编辑effect
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
                
                for cmd in commands:
                    cmd_type, a, b, c, d = cmd
                    data.effects[effect_id].effect_commands.append(
                        EffectCommand(type=cmd_type, a=a, b=b, c=c, d=d)
                    )
                    
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
                
                for cmd in data.effects[effect_id].effect_commands:
                    if match_command(cmd, match_list):
                        for field, op, value in modifications:
                            apply_modification(cmd, field, op, value)
                            
            else:  # adjustment
                function_id = effect_change["function_id"]
                data.effects[effect_id].effect_commands.append(
                    EffectCommand(type=1, a=33, b=0, c=-1, d=function_id)
                )
        
    return


if __name__ == "__main__":
    run()
