import re

def validate_file_format(file_path):
    """
    检测文件中多种格式错误（排除"•"字符的非ASCII检测）：
    1. 反斜杠\后紧跟非'n'的字符
    2. 不符合'n "string"'格式的行
    3. 包含非ASCII字符（排除"•"）并输出具体字符
    4. 包含多余双引号（>2个）的行
    """
    results = {
        'invalid_backslash': [],  # 反斜杠错误行号
        'invalid_format': [],      # 格式错误行号
        'non_ascii_chars': [],    # 非ASCII字符行号（不含"•"）
        'non_ascii_details': {},  # 新增：存储行号→具体字符映射
        'extra_quotes': []         # 多余双引号行号
    }
    
    # 定义例外字符（Unicode U+2022）
    EXCEPTION_CHAR = '\u2022'
    
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            for line_num, line in enumerate(file, 1):
                line = line.rstrip()  # 去除行尾换行符
                
                # 空行跳过
                if line.strip() == '':
                    continue
                
                has_backslash_error = False
                has_non_ascii = False
                has_extra_quotes = False
                
                # ===== 1. 反斜杠后非n字符检测 =====
                i = 0
                while i < len(line):
                    if line[i] == '\\':
                        if i == len(line) - 1:  # 行尾单独反斜杠
                            if not has_backslash_error:
                                results['invalid_backslash'].append(line_num)
                                has_backslash_error = True
                                print(f"行 {line_num} [反斜杠错误]：行尾单独反斜杠")
                        else:
                            next_char = line[i + 1]
                            if next_char != 'n':
                                if not has_backslash_error:
                                    results['invalid_backslash'].append(line_num)
                                    has_backslash_error = True
                                print(f"行 {line_num} [反斜杠错误]：'\\{next_char}'")
                            i += 1  # 跳过已检测字符
                    i += 1
                
                # ===== 2. 非ASCII字符检测（排除"•"）===== 
                non_ascii_chars = []
                for col, char in enumerate(line, 1):
                    # 检测条件：非ASCII字符 且 不是例外字符"•"
                    if ord(char) > 127 and char != EXCEPTION_CHAR:
                        non_ascii_chars.append((char, col))  # 存储字符及其位置
                        has_non_ascii = True
                
                if non_ascii_chars:
                    results['non_ascii_chars'].append(line_num)
                    results['non_ascii_details'][line_num] = non_ascii_chars
                    # 输出具体非ASCII字符
                    char_list = ', '.join(f"'{char}'（位置{col}）" for char, col in non_ascii_chars)
                    print(f"行 {line_num} [非ASCII字符]：{char_list}")
                
                # ===== 3. 多余双引号检测 =====
                quote_count = line.count('"')
                if quote_count > 2:
                    results['extra_quotes'].append(line_num)
                    has_extra_quotes = True
                    print(f"行 {line_num} [多余双引号]：共{quote_count}个引号")
                
                # ===== 4. 数字+"字符串"格式检测 =====
                if not re.match(r'^\d+\s+".*"$', line):
                    results['invalid_format'].append(line_num)
                    print(f"行 {line_num} [格式错误]：'{line}'")
                    
    except FileNotFoundError:
        print(f"错误：文件 '{file_path}' 不存在")
    except UnicodeDecodeError:
        print("错误：文件编码问题，请尝试使用其他编码（如latin-1）")
    
    return results

# 使用示例
if __name__ == "__main__":
    file_path = "key-value-modded-strings-utf8.txt"  # 替换为你的文件路径
    result = validate_file_format(file_path)
    
    # 结果汇总输出
    print("\n=== 检测结果汇总 ===")
    # 反斜杠错误汇总
    if result['invalid_backslash']:
        print(f"反斜杠错误行号：{sorted(set(result['invalid_backslash']))}")
    else:
        print("√ 未发现反斜杠错误")
    
    # 格式错误汇总
    if result['invalid_format']:
        print(f"格式错误行号：{sorted(set(result['invalid_format']))}")
    else:
        print("√ 所有行均符合格式要求")
    
    # 非ASCII字符汇总（含具体字符）
    if result['non_ascii_chars']:
        print(f"非ASCII字符行号：{sorted(set(result['non_ascii_chars']))}")
        print("具体非ASCII字符：")
        for line_num in sorted(result['non_ascii_details']):
            chars = result['non_ascii_details'][line_num]
            char_info = ', '.join(f"'{char}'(列{col})" for char, col in chars)
            print(f"  行 {line_num}: {char_info}")
    else:
        print("√ 未发现非ASCII字符（不含•）")
    
    # 多余双引号汇总
    if result['extra_quotes']:
        print(f"多余双引号行号：{sorted(set(result['extra_quotes']))}")
    else:
        print("√ 未发现多余双引号")
    
    # 无错误提示
    if not any(result.values()):
        print("√ 未发现任何格式错误")

    n=input()
