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


def customChanges(data):
    for i in range(len(data.civs)):
        civ = data.civs[i]
        #为每个科技树效果后面增加一个XS调用
        EffectID = civ.tech_tree_id
        data.effects[EffectID].effect_commands.append(EffectCommand(type = 1, a = 33, b = 0, c = -1, d = 10001.0))

    #编辑effect
    for effect_change in effect_change_list:
        # 支持单个effect_id或列表
        effect_ids = effect_change["effect_id"]
        if isinstance(effect_ids, (int, float)):
            effect_ids = [effect_ids]
        
        change_type = effect_change.get("type", "adjustment")
        
        # 遍历所有指定的effect_id
        for effect_id in effect_ids:
            if change_type == "add":
                # 获取指令列表，支持单个列表或列表的列表
                commands = effect_change["commands"]
                # 如果是单个指令（第一个元素是数字），包装成列表
                if isinstance(commands[0], (int, float)):
                    commands = [commands]
                
                # 批量添加指令
                for cmd in commands:
                    cmd_type, a, b, c, d = cmd  # 直接解包 [type, a, b, c, d]
                    data.effects[effect_id].effect_commands.append(
                        EffectCommand(type=cmd_type, a=a, b=b, c=c, d=d)
                    )
            else:  # adjustment
                function_id = effect_change["function_id"]
                data.effects[effect_id].effect_commands.append(
                    EffectCommand(type=1, a=33, b=0, c=-1, d=function_id)
                )
        
    return

if __name__ == "__main__":
    run()
