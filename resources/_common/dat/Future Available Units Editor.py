import json
import os
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent.parent.parent))
from paths import OFFICIAL_FUTUR_AVAILABLE_UNITS_FILE, FAU_CHANGES_FILE, OUTPUT_FUTUR_AVAILABLE_UNITS_FILE

os.chdir(Path(__file__).parent)

def main():
    # Load source data
    with open(str(OFFICIAL_FUTUR_AVAILABLE_UNITS_FILE), 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    # Load changes
    with open(str(FAU_CHANGES_FILE), 'r', encoding='utf-8') as f:
        changes_data = json.load(f)
    
    changes = changes_data.get('changes', [])
    
    for change in changes:
        civs = change.get('civilizations')
        
        # 支持 civilizations 为单独的字符串
        if isinstance(civs, str):
            if civs == 'all':
                civs = list(data.keys())
            else:
                civs = [civs]  # 将单独的文明名称转换为列表
        elif isinstance(civs, list):
            if 'all' in civs:
                civs = list(data.keys())  # 替换 'all' 为所有文明列表
        else:
            print(f"Error: 'civilizations' must be a string, 'all', or a list of civilizations.")
            continue
        
        # Skip Gaia civilization
        if 'Gaia' in civs:
            civs.remove('Gaia')
        
        # Print note if provided
        note = change.get('note')
        if note:
            print(f"Note: {note}")
        
        # Determine operation type
        operation_type = change.get('type', '')
        
        # 定义需要排除的元数据字段
        meta_fields = ['civilizations', 'note', 'type', 'building_id', 'unit_id', 'tech_id', 'position', 'target_id']
        
        if operation_type == 'delete':
            if 'unit_id' in change:
                # Unit delete operation
                unit_id = change.get('unit_id')
                building_ids = change.get('building_id')
                
                for civ in civs:
                    if civ not in data:
                        print(f"Warning: Civilization '{civ}' not found.")
                        continue
                    
                    buildings = data[civ].get('Buildings', [])
                    
                    # Convert single building_id to list for consistent processing
                    target_building_ids = None
                    if building_ids is not None:
                        if not isinstance(building_ids, list):
                            target_building_ids = [building_ids]
                        else:
                            target_building_ids = building_ids
                    
                    # Convert single unit_id to list for consistent processing
                    unit_ids = unit_id if isinstance(unit_id, list) else [unit_id] if unit_id is not None else []
                    
                    for building in buildings:
                        if target_building_ids is not None and building.get('ID') not in target_building_ids:
                            continue
                        
                        units = building.get('Units', [])
                        for unit in list(units):  # Iterate over a copy to avoid issues during removal
                            if unit.get('ID') in unit_ids:
                                units.remove(unit)
                                print(f"Deleted unit ID {unit.get('ID')} from building ID {building.get('ID')} in civilization '{civ}'.")
                    
            elif 'tech_id' in change:
                # Tech delete operation
                tech_id = change.get('tech_id')
                building_ids = change.get('building_id')
                
                for civ in civs:
                    if civ not in data:
                        print(f"Warning: Civilization '{civ}' not found.")
                        continue
                    
                    buildings = data[civ].get('Buildings', [])
                    
                    # Convert single building_id to list for consistent processing
                    target_building_ids = None
                    if building_ids is not None:
                        if not isinstance(building_ids, list):
                            target_building_ids = [building_ids]
                        else:
                            target_building_ids = building_ids
                            
                    # Convert single tech_id to list for consistent processing
                    tech_ids = tech_id if isinstance(tech_id, list) else [tech_id] if tech_id is not None else []
                    
                    for building in buildings:
                        if target_building_ids is not None and building.get('ID') not in target_building_ids:
                            continue
                        techs = building.get('Techs', [])
                        for tech in list(techs):  # Iterate over a copy to avoid issues during removal
                            if tech.get('ID') in tech_ids:
                                techs.remove(tech)
                                print(f"Deleted tech ID {tech.get('ID')} from building ID {building.get('ID')} in civilization '{civ}'.")
            else:
                print("Error: Delete operation requires 'unit_id' or 'tech_id'.")
                continue
        
        elif operation_type == 'modify':
            # 新增modify操作
            if 'unit_id' in change:
                # 修改单位属性
                unit_id = change.get('unit_id')
                building_ids = change.get('building_id')
                
                # 获取需要修改的属性（排除元数据字段）
                modify_data = {k: v for k, v in change.items() if k not in meta_fields}
                
                if not modify_data:
                    print("Error: Modify operation requires at least one attribute to modify.")
                    continue
                
                found_count = 0
                for civ in civs:
                    if civ not in data:
                        print(f"Warning: Civilization '{civ}' not found.")
                        continue
                    
                    buildings = data[civ].get('Buildings', [])
                    
                    # Convert single building_id to list for consistent processing
                    target_building_ids = None
                    if building_ids is not None:
                        if not isinstance(building_ids, list):
                            target_building_ids = [building_ids]
                        else:
                            target_building_ids = building_ids
                    
                    # Search for the unit in buildings
                    for building in buildings:
                        if target_building_ids is not None and building.get('ID') not in target_building_ids:
                            continue
                        
                        units = building.get('Units', [])
                        for unit in units:
                            if unit.get('ID') == unit_id:
                                # Update existing unit with the provided modify_data
                                for key, value in modify_data.items():
                                    unit[key] = value
                                found_count += 1
                                print(f"Modified unit ID {unit_id} in building ID {building.get('ID')} of civilization '{civ}'. Changes: {list(modify_data.keys())}")
                                break
                
                if found_count == 0:
                    print(f"Warning: Unit ID {unit_id} not found in specified buildings of civilizations.")
            
            elif 'tech_id' in change:
                # 修改科技属性
                tech_id = change.get('tech_id')
                building_ids = change.get('building_id')
                
                # 获取需要修改的属性（排除元数据字段）
                modify_data = {k: v for k, v in change.items() if k not in meta_fields}
                
                if not modify_data:
                    print("Error: Modify operation requires at least one attribute to modify.")
                    continue
                
                found_count = 0
                for civ in civs:
                    if civ not in data:
                        print(f"Warning: Civilization '{civ}' not found.")
                        continue
                    
                    buildings = data[civ].get('Buildings', [])
                    
                    # Convert single building_id to list for consistent processing
                    target_building_ids = None
                    if building_ids is not None:
                        if not isinstance(building_ids, list):
                            target_building_ids = [building_ids]
                        else:
                            target_building_ids = building_ids
                    
                    # Search for the tech in buildings
                    for building in buildings:
                        if target_building_ids is not None and building.get('ID') not in target_building_ids:
                            continue
                        
                        techs = building.get('Techs', [])
                        for tech in techs:
                            if tech.get('ID') == tech_id:
                                # Update existing tech with the provided modify_data
                                for key, value in modify_data.items():
                                    tech[key] = value
                                found_count += 1
                                print(f"Modified tech ID {tech_id} in building ID {building.get('ID')} of civilization '{civ}'. Changes: {list(modify_data.keys())}")
                                break
                
                if found_count == 0:
                    print(f"Warning: Tech ID {tech_id} not found in specified buildings of civilizations.")
            
            else:
                print("Error: Modify operation requires 'unit_id' or 'tech_id'.")
                continue
        
        elif 'unit_id' in change:
            # Existing unit update/add logic (默认操作类型)
            unit_id = change.get('unit_id')
            building_ids = change.get('building_id')
            position = change.get('position', 'end')  # 新增位置参数，默认为 'end'
            target_id = change.get('target_id', None)  # 新增目标 ID 参数
            
            # Remove operation-specific fields to get the unit data
            unit_data = {k: v for k, v in change.items() if k not in ['unit_id', 'building_id', 'civilizations', 'note', 'type', 'position', 'target_id']}
            
            for civ in civs:
                if civ not in data:
                    print(f"Warning: Civilization '{civ}' not found.")
                    continue
                
                buildings = data[civ].get('Buildings', [])
                
                # Convert single building_id to list for consistent processing
                target_building_ids = None
                if building_ids is not None:
                    if not isinstance(building_ids, list):
                        target_building_ids = [building_ids]
                    else:
                        target_building_ids = building_ids
                
                # Search for the unit in buildings
                found = False
                for building in buildings:
                    if target_building_ids is not None and building.get('ID') not in target_building_ids:
                        continue
                    
                    units = building.get('Units', [])
                    for unit in units:
                        if unit.get('ID') == unit_id:
                            # Update existing unit with the provided unit_data
                            for key, value in unit_data.items():
                                unit[key] = value
                            found = True
                            break
                
                if not found:
                    # Unit not found, so we need to add it
                    if building_ids is None:
                        print(f"Warning: Unit ID {unit_id} not found in civilization '{civ}' and no 'building_id' provided to add it.")
                        continue
                    
                    # Convert single building_id to list for consistent processing
                    if not isinstance(building_ids, list):
                        building_ids = [building_ids]
                    
                    # Add the unit to all specified buildings
                    for building_id in building_ids:
                        target_building = None
                        for building in buildings:
                            if building.get('ID') == building_id:
                                target_building = building
                                break
                        if target_building is None:
                            print(f"Warning: Building ID {building_id} not found in civilization '{civ}'.")
                            continue
                        # Ensure the unit_data has the correct ID
                        unit_data['ID'] = unit_id
                        
                        if 'Units' not in target_building:
                            target_building['Units'] = []
                        
                        # Check if unit already exists in this building
                        unit_exists = False
                        for unit in target_building['Units']:
                            if unit.get('ID') == unit_id:
                                unit_exists = True
                                break
                        if not unit_exists:
                            # 根据 position 参数决定插入位置
                            if position == 'after' and target_id is not None:
                                inserted = False
                                for i, unit in enumerate(target_building['Units']):
                                    if unit.get('ID') == target_id:
                                        target_building['Units'].insert(i + 1, unit_data.copy())
                                        inserted = True
                                        print(f"Added unit ID {unit_id} after target ID {target_id} in building ID {building_id} of civilization '{civ}'.")
                                        break
                                if not inserted:
                                    target_building['Units'].append(unit_data.copy())
                                    print(f"Target ID {target_id} not found. Appended unit ID {unit_id} to building ID {building_id} of civilization '{civ}'.")
                            elif position == 'before' and target_id is not None:
                                inserted = False
                                for i, unit in enumerate(target_building['Units']):
                                    if unit.get('ID') == target_id:
                                        target_building['Units'].insert(i, unit_data.copy())
                                        inserted = True
                                        print(f"Added unit ID {unit_id} before target ID {target_id} in building ID {building_id} of civilization '{civ}'.")
                                        break
                                if not inserted:
                                    target_building['Units'].append(unit_data.copy())
                                    print(f"Target ID {target_id} not found. Appended unit ID {unit_id} to building ID {building_id} of civilization '{civ}'.")
                            elif position == 'start':
                                target_building['Units'].insert(0, unit_data.copy())
                                print(f"Added unit ID {unit_id} to the start of building ID {building_id} in civilization '{civ}'.")
                            else:
                                target_building['Units'].append(unit_data.copy())
                                print(f"Appended unit ID {unit_id} to building ID {building_id} of civilization '{civ}'.")
                        else:
                            print(f"Warning: Unit ID {unit_id} already exists in building {building_id} of civilization '{civ}'.")
        
        elif 'tech_id' in change:
            # Existing tech update/add logic (默认操作类型)
            tech_id = change.get('tech_id')
            building_ids = change.get('building_id')
            position = change.get('position', 'end')  # 新增位置参数，默认为 'end'
            target_id = change.get('target_id', None)  # 新增目标 ID 参数
            
            # Remove operation-specific fields to get the tech data
            tech_data = {k: v for k, v in change.items() if k not in ['tech_id', 'building_id', 'civilizations', 'note', 'type', 'position', 'target_id']}
            
            for civ in civs:
                if civ not in data:
                    print(f"Warning: Civilization '{civ}' not found.")
                    continue
                
                buildings = data[civ].get('Buildings', [])
                
                # Convert single building_id to list for consistent processing
                target_building_ids = None
                if building_ids is not None:
                    if not isinstance(building_ids, list):
                            target_building_ids = [building_ids]
                    else:
                        target_building_ids = building_ids
                
                # Search for the tech in buildings
                found = False
                for building in buildings:
                    if target_building_ids is not None and building.get('ID') not in target_building_ids:
                        continue
                    
                    techs = building.get('Techs', [])
                    for tech in techs:
                        if tech.get('ID') == tech_id:
                            # Update existing tech with the provided tech_data
                            for key, value in tech_data.items():
                                tech[key] = value
                            found = True
                            break
                
                if not found:
                    # Tech not found, so we need to add it
                    if building_ids is None:
                        print(f"Warning: Tech ID {tech_id} not found in civilization '{civ}' and no 'building_id' provided to add it.")
                        continue
                    
                    # Convert single building_id to list for consistent processing
                    if not isinstance(building_ids, list):
                        building_ids = [building_ids]
                    
                    # Add the tech to all specified buildings
                    for building_id in building_ids:
                        target_building = None
                        for building in buildings:
                            if building.get('ID') == building_id:
                                target_building = building
                                break
                        if target_building is None:
                            print(f"Warning: Building ID {building_id} not found in civilization '{civ}'.")
                            continue
                        # Ensure the tech_data has the correct ID
                        tech_data['ID'] = tech_id
                        if 'Techs' not in target_building:
                            target_building['Techs'] = []
                        
                        # Check if tech already exists in this building
                        tech_exists = False
                        for tech in target_building['Techs']:
                            if tech.get('ID') == tech_id:
                                tech_exists = True
                                break
                        if not tech_exists:
                            # 根据 position 参数决定插入位置
                            if position == 'after' and target_id is not None:
                                inserted = False
                                for i, tech in enumerate(target_building['Techs']):
                                    if tech.get('ID') == target_id:
                                        target_building['Techs'].insert(i + 1, tech_data.copy())
                                        inserted = True
                                        print(f"Added tech ID {tech_id} after target ID {target_id} in building ID {building_id} of civilization '{civ}'.")
                                        break
                                if not inserted:
                                    target_building['Techs'].append(tech_data.copy())
                                    print(f"Target ID {target_id} not found. Appended tech ID {tech_id} to building ID {building_id} of civilization '{civ}'.")
                            elif position == 'before' and target_id is not None:
                                inserted = False
                                for i, tech in enumerate(target_building['Techs']):
                                    if tech.get('ID') == target_id:
                                        target_building['Techs'].insert(i, tech_data.copy())
                                        inserted = True
                                        print(f"Added tech ID {tech_id} before target ID {target_id} in building ID {building_id} of civilization '{civ}'.")
                                        break
                                if not inserted:
                                    target_building['Techs'].append(tech_data.copy())
                                    print(f"Target ID {target_id} not found. Appended tech ID {tech_id} to building ID {building_id} of civilization '{civ}'.")
                            elif position == 'start':
                                target_building['Techs'].insert(0, tech_data.copy())
                                print(f"Added tech ID {tech_id} to the start of building ID {building_id} in civilization '{civ}'.")
                            else:
                                target_building['Techs'].append(tech_data.copy())
                                print(f"Appended tech ID {tech_id} to building ID {building_id} of civilization '{civ}'.")
                        else:
                            print(f"Warning: Tech ID {tech_id} already exists in building {building_id} of civilization '{civ}'.")
        
        elif 'building_id' in change and operation_type == 'add':
            # Add new building logic
            building_id = change.get('building_id')
            building_name = change.get('name')  # 获取建筑名称
            
            for civ in civs:
                if civ not in data:
                    print(f"Warning: Civilization '{civ}' not found.")
                    continue
                
                buildings = data[civ].get('Buildings', [])
                
                # Check if building already exists
                building_exists = any(building.get('ID') == building_id for building in buildings)
                if building_exists:
                    print(f"Warning: Building ID {building_id} already exists in civilization '{civ}'.")
                    continue
                
                # Create new building data
                new_building = {
                    'ID': building_id,
                    'Name': building_name,
                    'Techs': [],
                    'Units': []
                }
                
                # Add the new building to the civilization's Buildings list
                data[civ]['Buildings'].append(new_building)
                print(f"Added building ID {building_id} to civilization '{civ}'.")
        
        else:
            print("Error: Change item must contain either 'unit_id', 'tech_id', or 'building_id' with type 'add'.")

    # Save modified data
    with open(str(OUTPUT_FUTUR_AVAILABLE_UNITS_FILE), 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=4)

if __name__ == '__main__':
    main()
