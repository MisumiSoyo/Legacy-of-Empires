import sys
sys.dont_write_bytecode = True

import os
import subprocess
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent

MODS_LOCAL_PATH = Path(r"C:\Users\20725\Games\Age of Empires 2 DE\76561199076107470\mods\local")
TARGET_PATH = MODS_LOCAL_PATH / "Mimiso LOE"

EXCLUDE_DIRS = [
    ".git",
    "__pycache__",
]

EXCLUDE_FILE_PATTERNS = [
    "*.py",
    "*.md",
    "Patch Notes.txt",
    ".gitignore",
    "*.code-workspace",
    "changes.json",
    "civ_changes.json",
    "ctt_changes.json",
    "lt_changes.json",
    "dr_changes.json",
    "fau_changes.json",
    "im_changes.json",
    "*.doc",
    "*.docx",
    "*.xlsx",
]

def build_robocopy_command():
    cmd = [
        "robocopy",
        str(PROJECT_ROOT),
        str(TARGET_PATH),
        "/E",
        "/PURGE",
        "/MT:16",
        "/NFL",
        "/NDL",
        "/NJH",
        "/NJS",
    ]
    
    for dir_name in EXCLUDE_DIRS:
        cmd.append("/XD")
        cmd.append(dir_name)
    
    for pattern in EXCLUDE_FILE_PATTERNS:
        cmd.append("/XF")
        cmd.append(pattern)
    
    return cmd

def main():
    print(f"项目根目录: {PROJECT_ROOT}")
    print(f"目标模组目录: {TARGET_PATH}")
    print("=" * 60)
    
    if not PROJECT_ROOT.exists():
        print(f"错误: 项目根目录不存在: {PROJECT_ROOT}")
        sys.exit(1)
    
    if not MODS_LOCAL_PATH.exists():
        print(f"错误: 模组目录不存在: {MODS_LOCAL_PATH}")
        sys.exit(1)
    
    cmd = build_robocopy_command()
    print(f"执行命令: {' '.join(cmd)}")
    print()
    
    result = subprocess.run(cmd, capture_output=True, text=True, encoding='utf-8', errors='ignore')
    
    if result.returncode == 0:
        print("构建完成！")
    elif result.returncode <= 7:
        print("构建完成（有文件被复制或跳过）")
    else:
        print(f"构建失败！错误码: {result.returncode}")
        if result.stderr:
            print("错误输出:")
            print(result.stderr)
    
    input("按回车键退出...")

if __name__ == "__main__":
    main()