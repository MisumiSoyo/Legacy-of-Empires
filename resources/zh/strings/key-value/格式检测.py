def find_invalid_backslashes(file_path):
    """
    检测文件中反斜杠后非'n'的字符位置，返回行号列表
    :param file_path: 文本文件路径
    :return: 包含错误反斜杠的行号列表
    """
    invalid_lines = []
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            line_num = 0
            for line in file:
                line_num += 1
                found_in_line = False  # 避免重复记录同一行
                i = 0
                while i < len(line) - 1:  # 留出检查下一个字符的空间
                    if line[i] == '\\':
                        next_char = line[i + 1]
                        if next_char != 'n':  # 核心检测逻辑
                            if not found_in_line:
                                invalid_lines.append(line_num)
                                found_in_line = True  # 此行已有错误
                            # 输出详细位置（可选）
                            print(f"行 {line_num}，位置 {i+1}: '\\{next_char}'")
                        i += 1  # 跳过已检测的下一个字符
                    i += 1
    except FileNotFoundError:
        print(f"错误：文件 '{file_path}' 不存在")
    except UnicodeDecodeError:
        print("错误：文件编码问题，请尝试其他编码（如latin-1）")
    return invalid_lines

# 使用示例
if __name__ == "__main__":
    file_path = "key-value-modded-strings-utf8.txt"  # 替换为你的文件路径
    result = find_invalid_backslashes(file_path)
    
    if result:
        print("\n存在错误反斜杠的行号:", result)
    else:
        print("文件中未发现反斜杠后非'n'的情况")

    n=input("")
