# 天机阁 · 综合算命 App

一款基于 Flutter 的综合算命应用，支持安卓和 iOS 双平台。

## 功能模块

| 模块 | 说明 |
|------|------|
| 八字命理 | 输入出生日期时辰，计算四柱八字、五行分析 |
| 紫微斗数 | 紫微星盘推算（复用八字入口） |
| 星座运势 | 十二星座详细运势（桃花/财运/事业/健康） |
| 塔罗占卜 | 22张大阿卡纳抽牌，过去/现在/未来三牌阵 |
| 生肖运程 | 十二生肖运势、五行、幸运色 |
| 每日运势 | 按星座生成每日运势详解 |
| MBTI测试 | 12题性格测试，16种人格结果 |
| 起名测名 | 姓名笔画数理打分 |

## 项目结构

```
divination_app/
├── lib/
│   ├── main.dart              # 应用入口
│   ├── utils/
│   │   ├── theme.dart         # 主题配置（神秘星空风格）
│   │   └── divination_data.dart  # 天干地支/星座/塔罗/生肖数据
│   ├── models/
│   │   └── fortune_models.dart   # 数据模型
│   ├── services/
│   │   ├── fortune_engine.dart   # 本地算命引擎
│   │   └── cloud_service.dart    # WorkBuddy 云服务客户端
│   └── pages/
│       ├── home_page.dart        # 首页导航
│       ├── bazi_page.dart        # 八字命理
│       ├── zodiac_page.dart      # 星座运势
│       ├── tarot_page.dart       # 塔罗占卜
│       ├── shengxiao_page.dart   # 生肖运程
│       ├── daily_fortune_page.dart  # 每日运势
│       ├── mbti_page.dart        # MBTI测试
│       ├── name_page.dart        # 起名测名
│       ├── history_page.dart     # 历史记录
│       └── profile_page.dart     # 个人中心
├── web_preview/
│   └── index.html              # Web 预览版（可在浏览器直接体验）
├── pubspec.yaml                # Flutter 依赖配置
└── README.md
```

## 如何编译为安卓 APK

### 1. 安装 Flutter SDK

```bash
# 下载 Flutter SDK
# Windows: https://docs.flutter.dev/get-started/install/windows
# 确保 flutter 命令在 PATH 中
flutter doctor
```

### 2. 安装依赖

```bash
cd divination_app
flutter pub get
```

### 3. 运行/调试

```bash
# 连接安卓设备或模拟器后
flutter run

# 或指定设备
flutter run -d <device_id>
```

### 4. 编译 APK

```bash
# Debug APK
flutter build apk --debug

# Release APK（推荐）
flutter build apk --release
```

生成的 APK 在 `build/app/outputs/flutter-apk/app-release.apk`

## 后端服务

应用集成了 WorkBuddy Cloud Service，支持：
- **用户登录注册**（Auth 模块）
- **算命记录存储**（Database 模块）
- **LLM 智能分析**（LLM API 模块 — AI 生成个性化命理分析）

### 开启云服务

在 WorkBuddy 中重新激活云服务即可获得 `publicConfig`（endpoint / publishableKey），
将其填入 `lib/services/cloud_service.dart` 的 `CloudService.init()` 即可。

## Web 预览

无需 Flutter SDK，直接在浏览器中体验：

```bash
cd divination_app/web_preview
python -m http.server 8765
# 浏览器打开 http://localhost:8765
```

## 技术栈

- **框架**: Flutter 3.24+
- **语言**: Dart 3.5+
- **状态管理**: Provider
- **路由**: go_router
- **字体**: Noto Serif SC（思源宋体）
- **后端**: WorkBuddy Cloud Service（Database / Auth / LLM）
- **设计风格**: 神秘星空暗色主题（紫色+金色）

## 免责声明

本应用仅供娱乐参考，命运掌握在自己手中。
