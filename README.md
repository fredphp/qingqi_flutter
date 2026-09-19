# qingqi_flutter

> 轻启AI — 让工具更简单 · 让生活更轻松

一个 1:1 还原 [设计稿](https://dog-tree-31186095.aisite.pixso.design) 的 Flutter 移动端项目。
「一个 App，解决工作、学习、生活中的各种需求。」

## 设计还原说明

本项目按原设计稿像素级还原「轻启AI」生活助手首页界面，包含以下区块：

1. **顶部应用栏** — Logo / 标题 / 副标题 / 积分胶囊 / 头像
2. **Hero 卡片** — 深绿色渐变卡片，标题、副标题、搜索框
3. **快捷入口** — 图片处理 / PDF工具 / OCR识别 / 更多工具
4. **精选 AI 区** — 区块标题 + 查看全部
5. **功能卡片列表** — AI证件照 / AI简历 / AI购物助手
6. **底部导航栏** — 首页 / 工具 / AI助手（突出中央按钮） / 发现 / 我的

## 设计系统

| 角色 | 颜色 |
| --- | --- |
| 主色（深森林绿） | `#2D5A47` |
| 主色浅（CTA 背景） | `#E8F0EC` |
| 页面背景 | `#F7F9F8` |
| 卡片背景 | `#FFFFFF` |
| 主文本 | `#1A1A1A` |
| 次文本 | `#6B7280` |
| 金色强调（积分） | `#C6A87C` |
| 标签米色背景 | `#F3EFE0` |
| Hero 渐变 | `#3D6B54` → `#234A38` |

## 目录结构

```
lib/
  main.dart                # 入口
  app.dart                 # MaterialApp 配置
  theme/
    app_colors.dart        # 颜色常量
    app_text_styles.dart   # 文本样式
  pages/
    home_page.dart         # 首页（聚合所有区块）
  widgets/
    app_top_bar.dart       # 顶部应用栏
    hero_card.dart         # Hero 绿色渐变卡
    quick_actions.dart     # 四个快捷入口
    section_header.dart    # 区块标题
    feature_card.dart      # 精选 AI 功能卡
    bottom_nav_bar.dart    # 底部导航
assets/images/             # 设计稿中用到的图片
```

## 运行

```bash
flutter pub get
flutter run
```

## 设计稿来源

- 原设计稿：<https://dog-tree-31186095.aisite.pixso.design>
- 图片素材来自 [Unsplash](https://unsplash.com)，仅作设计还原演示用途。
