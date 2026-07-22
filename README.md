# Legacy of Empires

一个为《帝国时代2决定版》设计的大型游戏模组，旨在扩展和平衡游戏体验。

## 📋 项目概况

**Legacy of Empires**（简称 LOE）是一个非官方模组，为《帝国时代2决定版》添加了大量新内容，包括：

- **新单位和科技**：每个文明都新增独特单位和科技
- **平衡性调整**：对所有文明进行了深度强化和特化
- **自定义AI**：为新增内容专门设计的AI行为脚本

## 📁 项目结构

```
Mimiso LOE/
├── resources/
│   ├── _common/           # 核心游戏数据
│   │   ├── ai/            # AI行为脚本
│   │   ├── dat/           # 文明数据和编辑器
│   │   │   ├── CivTechTrees/  # 文明科技树配置
│   │   │   ├── changes.json       # 数据变更指令
│   │   │   ├── civ_changes.json   # 文明属性变更
│   │   │   ├── ctt_changes.json   # 科技树变更
│   │   │   ├── lt_changes.json    # 关联科技变更
│   │   │   ├── dr_changes.json    # 资源投放点变更
│   │   │   ├── fau_changes.json   # 未来可用单位变更
│   │   │   └── *.py       # Python数据编辑工具
│   │   ├── drs/           # 图形和游戏数据资源
│   │   └── xs/            # 游戏逻辑脚本
│   ├── en/                # 英文本地化
│   │   └── strings/key-value/
│   │       ├── key-value-merge.py     # 本地化合并工具
│   │       └── key-value-modded-strings-utf8.txt  # 模组字符串
│   ├── jp/                # 日文本地化（开发中）
│   └── zh/                # 中文本地化
│       └── strings/key-value/
│           ├── key-value-merge.py
│           └── key-value-modded-strings-utf8.txt
├── widgetui/              # UI图标和材质资源
│   ├── icons.json         # 图标定义
│   ├── materials.json     # 材质定义
│   └── im_changes.json    # 图标材质变更
├── build.py               # 本地测试构建工具
├── package.py             # 模组打包工具（输出zip到根目录）
├── paths.py               # 集中路径配置
├── info.json              # 模组元信息
└── Legacy of Empires.zip          # 数据模块（package.py生成）
    [Graphics] Legacy of Empires.zip  # UI模块（package.py生成）
```

## 🛠️ 开发工具

### 数据编辑工具

位于 `resources/_common/dat/` 目录下：

| 文件 | 功能 |
|------|------|
| `Python Dat Editor.py` | 通用游戏数据编辑器 |
| `Civilizations Edit.py` | 文明属性编辑器 |
| `Civ Tech Trees Edit 2.0.py` | 科技树编辑器 |
| `Linked Tech Editor.py` | 关联科技编辑器 |
| `Dropsite Editor.py` | 资源投放点编辑器 |
| `Future Available Units Editor.py` | 未来可用单位编辑器 |

### 构建工具

| 文件 | 功能 |
|------|------|
| `build.py` | 将模组文件复制到游戏本地测试目录 |
| `package.py` | 将模组打包为两个zip文件（数据+UI） |
| `paths.py` | 集中配置游戏路径和项目路径 |

## 🚀 快速开始

### 环境要求

- Python 3.8+
- 7-Zip（用于打包，默认路径：`C:\Program Files\7-Zip\7z.exe`）
- 《帝国时代2决定版》已安装

### 路径配置

首次使用前，需要配置游戏路径：

1. 打开 `paths.py`
2. 修改 `STEAM_PATH` 为你的Steam安装路径：
   ```python
   STEAM_PATH = Path("C:/Steam")  # 默认路径
   ```

所有Python编辑工具都会自动导入此配置，无需在每个文件中单独配置。

### 本地测试

运行 `build.py` 将模组文件复制到游戏本地测试目录：

```bash
python build.py
```

输出位置：`C:\Users\<用户名>\Games\Age of Empires 2 DE\<ID>\mods\local\Mimiso LOE`

### 打包发布

运行 `package.py` 将模组打包为两个zip文件：

```bash
python package.py
```

输出文件（位于项目根目录）：
- `Legacy of Empires.zip` - 数据模块（包含 `resources/_common/`）
- `[Graphics] Legacy of Empires.zip` - UI模块（包含 `resources/en/`, `resources/zh/`, `widgetui/`, `info.json`）

## 📝 数据编辑工作流

### 工作原理

本项目使用 **变更指令文件**（`*_changes.json`）来驱动数据修改：

1. 编辑工具读取官方游戏数据文件（如 `empires2_x2_p1.dat`）
2. 读取对应的变更指令文件（如 `ctt_changes.json`）
3. 根据变更指令修改数据
4. 将修改后的数据写入模组目录

### 变更文件说明

| 文件 | 作用 |
|------|------|
| `changes.json` | 通用数据变更 |
| `civ_changes.json` | 文明属性变更 |
| `ctt_changes.json` | 科技树变更 |
| `lt_changes.json` | 关联科技变更 |
| `dr_changes.json` | 资源投放点变更 |
| `fau_changes.json` | 未来可用单位变更 |
| `im_changes.json` | 图标材质变更 |

### 使用编辑工具

1. 确保 `paths.py` 中的路径配置正确
2. 运行对应的编辑器（如 `Civ Tech Trees Edit 2.0.py`）
3. 编辑器会自动读取变更文件和官方数据
4. 修改完成后，编辑器会更新变更文件和模组数据

## 🌐 本地化工作流

### 工作原理

本地化文件采用 **增量修改** 方式：

1. `key-value-modded-strings-utf8.txt` 只包含模组新增或修改的字符串
2. `key-value-merge.py` 用于将模组字符串与官方字符串合并

### 使用方法

1. 在 `key-value-modded-strings-utf8.txt` 中添加或修改字符串
2. 运行 `key-value-merge.py` 生成合并后的完整字符串文件（`key-value-merge.txt`）
3. `key-value-merge.txt` 会被 `.gitignore` 忽略，不会提交到仓库
4. 打包时会自动排除 `key-value-merge.txt` 和 `key-value-merge.py`

## 📝 更新日志

详细更新记录请查看 [Patch Notes.txt](Patch Notes.txt)

---

*Legacy of Empires - 帝国时代2决定版模组*