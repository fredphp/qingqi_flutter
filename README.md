# 轻启AI · Qingqi Flutter

A **1:1 Flutter port** of the React + TypeScript + Tailwind + shadcn/ui mobile
tools app originally at [`fredphp/demohtml`](https://github.com/fredphp/demohtml).

The original is a mobile-app-style image / document processing tools app with a
botanical / nature theme (forest green · sage · gold · cream). This project
reproduces every page, every component, every color, and every interaction in
Flutter (Dart), keeping the same 420px mobile canvas and the same navigation
structure.

---

## ✨ What's inside

- **25 pages** — ported 1:1 from the React routes
- **35 shared widgets** — matching the original React components
- **Complete mock data layer** — `lib/data/mock_data.dart` mirrors
  `src/data/mockData.ts` plus all page-local data
- **Botanical theme system** — `lib/theme/` (colors, gradients, shadows,
  typography with Sora + Inter via `google_fonts`, Lucide icon mapping)

### Pages

| Route | Page | Description |
|---|---|---|
| `/` | Home | 首页 — hero, quick tools, featured cards, AI promo |
| `/tools` | Tools | 工具 — searchable categorized grid |
| `/profile` | Profile | 我的 — header, VIP, assets, tasks, services |
| `/discover` | Discover | 发现 — topics, features, hot ranking, articles |
| `/assistant` | Assistant | AI助手 — chat with keyword-driven replies |
| `/image-compress` | Image Compress | 图片智能压缩 |
| `/image-resize` | Image Resize | 图片尺寸调整 |
| `/image-convert` | Image Convert | 图片格式转换 |
| `/image-watermark` | Image Watermark | 图片加水印 |
| `/pdf-to-image` | PDF to Image | PDF 转图片 |
| `/pdf-merge` | PDF Merge | PDF 合并 |
| `/ocr` | OCR | OCR 文字识别 |
| `/id-photo` | ID Photo | AI 证件照制作 |
| `/processing` | Processing | 处理中 — animated progress overlay |
| `/result` | Result | 处理结果 — preview, stats, download |
| `/vip` | VIP | 轻启 Pro 会员 |
| `/invite` | Invite | 邀请好友 |
| `/orders` | Orders | 我的订单 |
| `/favorites` | Favorites | 收藏工具 |
| `/history` | History | 历史记录 |
| `/coupons` | Coupons | 我的优惠 |
| `/downloads` | Downloads | 下载记录 |
| `/help` | Help | 帮助与反馈 |
| `/settings` | Settings | 设置 |
| `/about` | About | 关于我们 |

---

## 🎨 Design system

| Token | Hex | Usage |
|---|---|---|
| background | `#FAF7F1` | body (cream/ivory) |
| foreground | `#1B2B22` | text (dark forest) |
| card | `#FEFCF6` | card surface |
| primary | `#1F4B39` | forest green — buttons, accents |
| secondary | `#A6C0AB` | sage |
| accent | `#C9A96A` | gold — VIP, coins, highlights |
| destructive | `#C4573F` | terracotta-red |
| success | `#4CAF7D` | success green |

- **Display font**: `Sora` (headings, numbers, brand, button labels)
- **Body font**: `Inter` (all body text)
- **Radius**: 24px cards · 16px inner boxes · 12px chips · full pills
- **Body background**: layered radial gradients (sage top-left, gold top-right)
- **Container**: max-width 420px centered (mobile canvas)

---

## 🚀 Getting started

```bash
# 1. Install Flutter 3.27+ (stable channel)
#    https://docs.flutter.dev/get-started/install

# 2. Clone
git clone https://github.com/fredphp/qingqi_flutter.git
cd qingqi_flutter

# 3. Fetch dependencies
flutter pub get

# 4. Run (web / macOS / Chrome recommended for desktop preview)
flutter run -d chrome
# or pick a device
flutter devices
flutter run
```

### Build

```bash
# Web (outputs to build/web/)
flutter build web --release

# Android APK
flutter build apk --release

# macOS app
flutter build macos --release
```

---

## 📁 Project structure

```
lib/
├── main.dart                  # entry → QingqiApp
├── app.dart                   # MaterialApp + route table + text-scale lock
├── router.dart                # AppRoutes (25 named routes)
├── theme/
│   ├── app_colors.dart        # AppColors — full hex palette
│   ├── app_gradients.dart     # AppGradients — all gradient + body overlay
│   ├── app_shadows.dart       # AppShadows — soft / custom / card helper
│   ├── app_theme.dart         # AppTheme.light() + display/sans builders
│   └── app_icons.dart         # AppIcons.resolve() — lucide name → IconData
├── data/
│   └── mock_data.dart         # MockData — all models + mock content
├── widgets/                   # 35 shared widgets (TopBar, BottomNav, ...)
└── pages/                     # 25 page widgets
```

---

## 🛠 Tech stack

- **Flutter 3.27** (stable) · **Dart 3.6**
- `google_fonts` — Sora + Inter
- `cached_network_image` — Unsplash imagery
- `lucide_icons` — 1:1 icon parity with the React `lucide-react`

---

## 📝 Notes

- All Chinese UI strings are reproduced verbatim from the original.
- All mock data (tools, plans, orders, coupons, history, downloads, FAQs, …)
  is reproduced verbatim — the app is fully navigable with realistic content.
- The Processing page uses a 3200ms progress animation that auto-navigates to
  the Result page, matching the original.
- The Assistant chat replies are keyword-driven (压缩 / 证件照 / 文字 / PDF /
  水印 / 格式) with tappable tool chips, matching the original.

---

## 📄 License

This is a UI reproduction of a private demo project. All design credit goes to
the original `fredphp/demohtml` authors.
