import re
import json
import os
import sys
from typing import Dict, List, Set, Tuple

class AIGenerator:
    def __init__(self, config_path: str):
        self.config = self.load_config(config_path)
        self.generated_rules = set()
        
    def load_config(self, config_path: str) -> Dict:
        """加载JSON配置文件"""
        if not os.path.exists(config_path):
            print(f"错误: 配置文件 {config_path} 不存在")
            sys.exit(1)
            
        with open(config_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    
    def get_per_files_from_directory(self, directory: str) -> List[str]:
        """从目录中获取所有.per文件，跳过忽略的文件"""
        per_files = []
        
        if not os.path.exists(directory):
            print(f"错误: 目录 {directory} 不存在")
            return per_files
            
        ignore_files = self.config.get('ignore_files', [])
        
        for file in os.listdir(directory):
            if file.endswith('.per'):
                file_path = os.path.join(directory, file)
                
                # 检查是否在忽略列表中
                if file in ignore_files:
                    print(f"跳过忽略文件: {file}")
                    continue
                    
                per_files.append(file_path)
        
        print(f"从目录 {directory} 找到 {len(per_files)} 个.per文件")
        return per_files
    
    def has_action_commands_with_entity(self, rule: str, entity: str) -> bool:
        """检查规则是否包含针对特定实体的训练、建造、研究等行为命令"""
        # 精确匹配模式，确保只匹配真正的行为命令
        action_patterns = [
            r'\(train\s+' + re.escape(entity) + r'\)',
            r'\(can-train\s+' + re.escape(entity) + r'\)',
            r'\(research\s+' + re.escape(entity) + r'\)',
            r'\(can-research\s+' + re.escape(entity) + r'\)',
            r'\(build\s+' + re.escape(entity) + r'\)',
            r'\(can-build\s+' + re.escape(entity) + r'\)'
        ]
        
        for pattern in action_patterns:
            if re.search(pattern, rule):
                return True
        return False
    
    def parse_per_file(self, file_path: str) -> List[Tuple[str, str]]:
        """解析.per文件，提取规则并忽略预处理指令"""
        rules_with_comments = []
        current_rule = []
        current_comments = []
        in_rule = False
        bracket_count = 0
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                for line in f:
                    # 保存注释行
                    line_stripped = line.strip()
                    if line_stripped.startswith(';'):
                        current_comments.append(line)
                        continue
                    
                    # 跳过预处理指令
                    if line_stripped.startswith('#'):
                        continue
                    
                    # 检查是否开始新的规则
                    if '(defrule' in line and not in_rule:
                        in_rule = True
                        current_rule = [line]
                        bracket_count = line.count('(') - line.count(')')
                    elif in_rule:
                        current_rule.append(line)
                        bracket_count += line.count('(') - line.count(')')
                        
                        # 如果括号匹配完成，规则结束
                        if bracket_count == 0:
                            rule_content = ''.join(current_rule)
                            # 保存规则和注释
                            comment_block = ''.join(current_comments[-3:])  # 最多保留最近3条注释
                            rules_with_comments.append((rule_content, comment_block))
                            in_rule = False
                            current_rule = []
                            current_comments = []  # 清空注释，准备下一个规则
                    else:
                        # 不在规则中的行，可能是注释或空行
                        if line_stripped and not line_stripped.startswith(';'):
                            # 重置注释，因为遇到了非注释内容
                            current_comments = []
        
        except FileNotFoundError:
            print(f"警告: 文件 {file_path} 未找到，跳过")
            
        return rules_with_comments
    
    def extract_entities_from_actions(self, rule: str) -> Set[str]:
        """从动作部分（=> 之后）提取单位、建筑、科技"""
        entities = set()
        
        # 分割规则的条件部分和动作部分
        parts = rule.split('=>')
        if len(parts) < 2:
            return entities
            
        action_part = parts[1]
        
        # 匹配训练相关的命令（只在动作部分）
        patterns = [
            r'\(train\s+([a-zA-Z0-9-]+)\)',
            r'\(research\s+([a-zA-Z0-9-]+)\)',
            r'\(build\s+([a-zA-Z0-9-]+)\)'
        ]
        
        for pattern in patterns:
            matches = re.findall(pattern, action_part)
            entities.update(matches)
        
        return entities
    
    def extract_entities_from_conditions(self, rule: str) -> Set[str]:
        """从条件部分提取单位、建筑、科技（用于can-train等检查）"""
        entities = set()
        
        # 分割规则的条件部分和动作部分
        parts = rule.split('=>')
        if len(parts) < 2:
            return entities
            
        condition_part = parts[0]
        
        # 匹配条件中的相关命令
        patterns = [
            r'\(can-train\s+([a-zA-Z0-9-]+)\)',
            r'\(can-research\s+([a-zA-Z0-9-]+)\)',
            r'\(can-build\s+([a-zA-Z0-9-]+)\)',
            r'\(unit-available\s+([a-zA-Z0-9-]+)\)',
            r'\(building-available\s+([a-zA-Z0-9-]+)\)',
            r'\(research-available\s+([a-zA-Z0-9-]+)\)'
        ]
        
        for pattern in patterns:
            matches = re.findall(pattern, condition_part)
            entities.update(matches)
        
        return entities
    
    def replace_entities_in_rule(self, rule: str, original: str, new: str) -> str:
        """在规则中精确替换单位/建筑/科技名称"""
        # 使用单词边界确保精确匹配，避免替换部分匹配的内容
        pattern = r'\b' + re.escape(original) + r'\b'
        return re.sub(pattern, new, rule)
    
    def should_generate_rule(self, rule: str, mapping: Dict) -> bool:
        """检查规则是否应该被生成（包含目标实体且有相关行为）"""
        original = mapping['original']
        
        # 检查动作部分是否包含针对该实体的训练/建造/研究命令
        action_entities = self.extract_entities_from_actions(rule)
        if original in action_entities:
            return True
            
        # 检查条件部分是否包含针对该实体的可用性检查
        condition_entities = self.extract_entities_from_conditions(rule)
        if original in condition_entities:
            # 只有当条件部分有可用性检查，且动作部分有对应的训练/建造/研究命令时才生成
            action_part = rule.split('=>')[1] if '=>' in rule else ""
            has_any_action = any(
                re.search(pattern, action_part) 
                for pattern in [r'\(train\s+', r'\(research\s+', r'\(build\s+']
            )
            if has_any_action:
                return True
        
        return False
    
    def generate_new_rules(self) -> List[Tuple[str, str, str]]:
        """生成新的AI规则"""
        all_new_rules = []  # 每个元素是 (新规则内容, 注释, 映射描述)
        
        # 获取源文件目录中的所有.per文件
        source_directory = self.config['source_directory']
        per_files = self.get_per_files_from_directory(source_directory)
        
        if not per_files:
            print(f"错误: 在目录 {source_directory} 中未找到任何.per文件")
            return all_new_rules
            
        # 处理每个源文件
        for file_path in per_files:
            rules_with_comments = self.parse_per_file(file_path)
            print(f"从 {os.path.basename(file_path)} 解析出 {len(rules_with_comments)} 条规则")
            
            valid_rules_count = 0
            
            for rule_content, comments in rules_with_comments:
                # 为每个映射生成新规则
                for mapping in self.config['mappings']:
                    if self.should_generate_rule(rule_content, mapping):
                        original = mapping['original']
                        new = mapping['new']
                        
                        # 替换规则中的实体
                        new_rule = self.replace_entities_in_rule(rule_content, original, new)
                        
                        # 避免重复规则
                        rule_hash = hash(new_rule)
                        if rule_hash not in self.generated_rules:
                            # 创建映射描述
                            mapping_desc = f"; 映射: {original} -> {new} (来自 {os.path.basename(file_path)})"
                            all_new_rules.append((new_rule, comments + mapping_desc, mapping_desc))
                            self.generated_rules.add(rule_hash)
                            valid_rules_count += 1
            
            print(f"  其中 {valid_rules_count} 条规则符合生成条件")
        
        return all_new_rules
    
    def generate_ai_file(self):
        """生成最终的AI文件"""
        new_rules = self.generate_new_rules()
        
        if not new_rules:
            print("错误: 未生成任何新规则，请检查配置和源文件")
            sys.exit(1)
        
        # 写入文件头
        ignore_files_list = self.config.get('ignore_files', [])
        ignore_files_str = ', '.join(ignore_files_list) if ignore_files_list else '无'
        
        output_content = f"; ===============================================\n"
        output_content += f"; 自动生成的AI文件\n"
        output_content += f"; 源文件目录: {self.config['source_directory']}\n"
        output_content += f"; 忽略文件: {ignore_files_str}\n"
        output_content += f"; 生成时间: {os.popen('date').read().strip() if os.name != 'nt' else 'Windows系统'}\n"
        output_content += f"; 注意: 此文件仅包含针对新单位的训练/建造/研究规则\n"
        output_content += f"; ===============================================\n\n"
        
        # 按映射项分组规则
        rules_by_mapping = {}
        
        for rule, comments, mapping_desc in new_rules:
            # 提取映射键（新单位名称）
            mapping_match = re.search(r'映射:\s+[^\s]+\s+->\s+([^\s]+)', mapping_desc)
            if mapping_match:
                mapping_key = mapping_match.group(1)
                if mapping_key not in rules_by_mapping:
                    rules_by_mapping[mapping_key] = []
                rules_by_mapping[mapping_key].append((rule, comments, mapping_desc))
        
        # 写入分组规则
        for mapping_key, rules in rules_by_mapping.items():
            if rules:
                output_content += f"; ===================== {mapping_key} =====================\n\n"
                
                for i, (rule, comments, mapping_desc) in enumerate(rules, 1):
                    if comments.strip():
                        output_content += comments + '\n'
                    output_content += rule
                    output_content += "\n\n"
        
        # 写入文件
        output_file = self.config['output_file']
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(output_content)
        
        print(f"成功生成AI文件: {output_file}")
        print(f"共生成 {len(new_rules)} 条新规则")
        
        # 显示详细统计信息
        self.print_detailed_statistics(new_rules)
    
    def print_detailed_statistics(self, new_rules: List[Tuple[str, str, str]]):
        """打印详细的生成统计信息"""
        mapping_stats = {}
        file_stats = {}
        
        for rule, comments, mapping_desc in new_rules:
            # 统计具体映射
            mapping_match = re.search(r'映射:\s+([^\s]+)\s+->\s+([^\s]+)', mapping_desc)
            if mapping_match:
                mapping_key = f"{mapping_match.group(1)}->{mapping_match.group(2)}"
                mapping_stats[mapping_key] = mapping_stats.get(mapping_key, 0) + 1
            
            # 统计来源文件
            file_match = re.search(r'来自\s+([^)]+)', mapping_desc)
            if file_match:
                file_name = file_match.group(1)
                file_stats[file_name] = file_stats.get(file_name, 0) + 1
        
        print("\n=== 映射统计 ===")
        for mapping, count in mapping_stats.items():
            print(f"  {mapping}: {count} 条规则")
        
        print("\n=== 文件来源统计 ===")
        for file_name, count in file_stats.items():
            print(f"  {file_name}: {count} 条规则")

def main():
    # 固定配置文件路径
    config_file = "custom_ai.json"
    
    # 检查配置文件是否存在
    if not os.path.exists(config_file):
        print(f"错误: 配置文件 {config_file} 不存在")
        print("请创建一个名为 custom_ai.json 的配置文件，格式如下:")
        print("""
{
  "mappings": [
    {"original": "archer", "new": "hoplite"},
    {"original": "knight", "new": "companion"}
  ],
  "source_directory": "./ai_source_files",
  "ignore_files": ["template.per", "backup.per"],
  "output_file": "paphos_new_units.ai"
}
        """)
        sys.exit(1)
    
    # 生成AI文件
    print("开始生成AI文件...")
    generator = AIGenerator(config_file)
    generator.generate_ai_file()

if __name__ == "__main__":
    main()
