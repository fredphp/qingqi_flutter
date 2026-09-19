import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ============================================================
//  Data models (mirroring src/types.ts) + page-local models
// ============================================================

enum ToolCategory { image, pdf, office, life }

extension ToolCategoryX on ToolCategory {
  String get label {
    switch (this) {
      case ToolCategory.image:
        return '图片处理';
      case ToolCategory.pdf:
        return 'PDF工具';
      case ToolCategory.office:
        return '办公效率';
      case ToolCategory.life:
        return '生活工具';
    }
  }
}

class Tool {
  final String id;
  final String name;
  final ToolCategory category;
  final String description;
  final String usageCount;
  final String icon;
  final Color tint;
  final String route;
  const Tool({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.usageCount,
    required this.icon,
    required this.tint,
    required this.route,
  });
}

class QuickEntry {
  final String id;
  final String label;
  final String icon;
  final String route;
  const QuickEntry({required this.id, required this.label, required this.icon, required this.route});
}

class FeaturedCard {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String route;
  final String badge;
  const FeaturedCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.route,
    this.badge = '',
  });
}

class Category {
  final String id;
  final String label;
  final String value;
  final String emoji;
  const Category({required this.id, required this.label, required this.value, this.emoji = ''});
}

class FileInfo {
  final String name;
  final String size;
  final String resolution;
  final String thumbnail;
  const FileInfo({
    required this.name,
    required this.size,
    required this.resolution,
    required this.thumbnail,
  });
}

class SpecOption {
  final String id;
  final String label;
  const SpecOption({required this.id, required this.label});
}

class BgColorOption {
  final String id;
  final String label;
  final Color value;
  const BgColorOption({required this.id, required this.label, required this.value});
}

enum StepStatus { completed, active, pending }

class ProcessingStep {
  final String id;
  final String label;
  final StepStatus status;
  const ProcessingStep({required this.id, required this.label, required this.status});
}

class IdPhotoSpecInfo {
  final String label;
  final String value;
  const IdPhotoSpecInfo({required this.label, required this.value});
}

class ResultThumb {
  final String id;
  final String url;
  const ResultThumb({required this.id, required this.url});
}

class AssetStat {
  final String id;
  final String label;
  final String value;
  final String icon;
  const AssetStat({required this.id, required this.label, required this.value, required this.icon});
}

class TaskItem {
  final String id;
  final String title;
  final String reward;
  final String action;
  final String icon;
  final Color tint;
  const TaskItem({
    required this.id,
    required this.title,
    required this.reward,
    required this.action,
    required this.icon,
    required this.tint,
  });
}

class ServiceItem {
  final String id;
  final String label;
  final String icon;
  final String route;
  const ServiceItem({required this.id, required this.label, required this.icon, required this.route});
}

class VipBenefit {
  final String id;
  final String label;
  final String description;
  final String icon;
  const VipBenefit({required this.id, required this.label, required this.description, required this.icon});
}

class VipPlan {
  final String id;
  final String name;
  final String price;
  final String period;
  final String badge;
  final bool recommended;
  const VipPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.badge,
    required this.recommended,
  });
}

class ShareMethod {
  final String id;
  final String label;
  final String icon;
  const ShareMethod({required this.id, required this.label, required this.icon});
}

class NavTab {
  final String id;
  final String label;
  final String icon;
  final String route;
  const NavTab({required this.id, required this.label, required this.icon, required this.route});
}

// ---- Page-local models ----

class DiscoverTopic {
  final String id;
  final String title;
  final String desc;
  final String tag;
  final LinearGradient gradient;
  final String emoji;
  final String route;
  const DiscoverTopic({
    required this.id,
    required this.title,
    required this.desc,
    required this.tag,
    required this.gradient,
    required this.emoji,
    required this.route,
  });
}

class DiscoverFeature {
  final String title;
  final String desc;
  final String emoji;
  final Color tint;
  const DiscoverFeature({required this.title, required this.desc, required this.emoji, required this.tint});
}

class HotRankItem {
  final int rank;
  final String name;
  final String usage;
  final String emoji;
  final String route;
  const HotRankItem({
    required this.rank,
    required this.name,
    required this.usage,
    required this.emoji,
    required this.route,
  });
}

class ArticleCard {
  final String id;
  final String title;
  final String category;
  final String readTime;
  final String image;
  const ArticleCard({
    required this.id,
    required this.title,
    required this.category,
    required this.readTime,
    required this.image,
  });
}

class ChatMessage {
  final String id;
  final String text;
  final bool fromUser;
  final String time;
  final List<String>? toolChips;
  const ChatMessage({
    required this.id,
    required this.text,
    required this.fromUser,
    required this.time,
    this.toolChips,
  });
}

class MergeFile {
  final String name;
  final int pages;
  final String size;
  const MergeFile({required this.name, required this.pages, required this.size});
}

class OrderItem {
  final String id;
  final String orderNo;
  final String title;
  final String subtitle;
  final String status; // paid|processing|completed|refunded
  final String amount;
  final String date;
  final String emoji;
  const OrderItem({
    required this.id,
    required this.orderNo,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.amount,
    required this.date,
    required this.emoji,
  });
}

class FavTool {
  final String id;
  final String name;
  final String desc;
  final ToolCategory category;
  final String usage;
  final String emoji;
  final Color tint;
  final String route;
  final String savedAt;
  const FavTool({
    required this.id,
    required this.name,
    required this.desc,
    required this.category,
    required this.usage,
    required this.emoji,
    required this.tint,
    required this.route,
    required this.savedAt,
  });
}

class HistoryItem {
  final String id;
  final String toolName;
  final String emoji;
  final Color tint;
  final String action;
  final String detail;
  final String date;
  final String group;
  final String route;
  const HistoryItem({
    required this.id,
    required this.toolName,
    required this.emoji,
    required this.tint,
    required this.action,
    required this.detail,
    required this.date,
    required this.group,
    required this.route,
  });
}

class Coupon {
  final String id;
  final String title;
  final String subtitle;
  final String type;
  final String discount;
  final String condition;
  final String expiry;
  final String code;
  final String status; // available|used|expired
  final Color color;
  final Color bgColor;
  final String emoji;
  const Coupon({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.discount,
    required this.condition,
    required this.expiry,
    required this.code,
    required this.status,
    required this.color,
    required this.bgColor,
    required this.emoji,
  });
}

class DownloadItem {
  final String id;
  final String name;
  final String type; // image|pdf|other
  final String size;
  final String toolName;
  final String emoji;
  final String date;
  final String group;
  final int count;
  const DownloadItem({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.toolName,
    required this.emoji,
    required this.date,
    required this.group,
    required this.count,
  });
}

class FaqItem {
  final String id;
  final String question;
  final String answer;
  const FaqItem({required this.id, required this.question, required this.answer});
}

class SettingToggle {
  final String id;
  final String emoji;
  final String label;
  final String desc;
  final bool defaultOn;
  const SettingToggle({required this.id, required this.emoji, required this.label, required this.desc, required this.defaultOn});
}

class SettingLink {
  final String id;
  final String emoji;
  final String label;
  final String trailing;
  const SettingLink({required this.id, required this.emoji, required this.label, required this.trailing});
}

class AboutMilestone {
  final String emoji;
  final String value;
  final String label;
  const AboutMilestone({required this.emoji, required this.value, required this.label});
}

class AboutValue {
  final String emoji;
  final String title;
  final String desc;
  const AboutValue({required this.emoji, required this.title, required this.desc});
}

// Helper to build a Tool from raw string fields (mirrors mockData.ts)
Tool _tool(String id, String name, ToolCategory cat, String desc, String usage, String icon, String tintHex, String route) {
  return Tool(
    id: id,
    name: name,
    category: cat,
    description: desc,
    usageCount: usage,
    icon: icon,
    tint: AppColors.fromHex(tintHex),
    route: route,
  );
}

// ============================================================
//  Mock data (mirrors src/data/mockData.ts + page-local data)
// ============================================================

class MockData {
  MockData._();

  static const userProfile = {
    'nickname': '小轻',
    'uid': '100086',
    'avatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=300&q=80',
    'coinBalance': '1285',
  };

  static const profileNickname = '轻启用户';
  static const profileUid = 'UID · 8821943';

  static const navTabs = <NavTab>[
    NavTab(id: 'home', label: '首页', icon: 'HomeIcon', route: '/'),
    NavTab(id: 'tools', label: '工具', icon: 'LayoutGridIcon', route: '/tools'),
    NavTab(id: 'assistant', label: 'AI助手', icon: 'SparklesIcon', route: '/assistant'),
    NavTab(id: 'discover', label: '发现', icon: 'CompassIcon', route: '/discover'),
    NavTab(id: 'profile', label: '我的', icon: 'UserIcon', route: '/profile'),
  ];

  static const quickEntries = <QuickEntry>[
    QuickEntry(id: 'image', label: '图片处理', icon: 'ImageIcon', route: '/image-compress'),
    QuickEntry(id: 'pdf', label: 'PDF工具', icon: 'FileTextIcon', route: '/tools'),
    QuickEntry(id: 'ocr', label: 'OCR识别', icon: 'ScanTextIcon', route: '/tools'),
    QuickEntry(id: 'more', label: '更多工具', icon: 'LayoutGridIcon', route: '/tools'),
  ];

  static const featuredCards = <FeaturedCard>[
    FeaturedCard(
      id: 'id-photo',
      title: 'AI证件照',
      subtitle: '专业规格 · 智能抠图换背景',
      image: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=600&q=80',
      route: '/id-photo',
      badge: '热门',
    ),
    FeaturedCard(
      id: 'resume',
      title: 'AI简历',
      subtitle: '一键生成 · 高分模板排版',
      image: 'https://images.unsplash.com/photo-1586281380349-632531db7ed4?auto=format&fit=crop&w=600&q=80',
      route: '/tools',
      badge: 'NEW',
    ),
  ];

  static const shoppingAssistant = {
    'title': 'AI购物助手',
    'subtitle': '比价、选品、凑单，一句话搞定',
    'tag': '新品体验',
    'image': 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?auto=format&fit=crop&w=900&q=80',
  };

  static const categories = <Category>[
    Category(id: 'all', label: '全部', value: '全部', emoji: '✦'),
    Category(id: 'image', label: '图片处理', value: '图片处理', emoji: '🖼️'),
    Category(id: 'pdf', label: 'PDF工具', value: 'PDF工具', emoji: '📄'),
    Category(id: 'office', label: '办公效率', value: '办公效率', emoji: '💼'),
    Category(id: 'life', label: '生活工具', value: '生活工具', emoji: '🌿'),
  ];

  static final List<Tool> tools = [
    _tool('compress', '图片压缩', ToolCategory.image, '缩小文件体积不失真', '12.6万人在用', 'ImageIcon', '#e4efe7', '/image-compress'),
    _tool('resize', '图片尺寸调整', ToolCategory.image, '自定义宽高与比例', '8.3万人在用', 'RulerIcon', '#eef2ec', '/image-resize'),
    _tool('convert', '图片格式转换', ToolCategory.image, '支持多种格式互转', '6.8万人在用', 'RefreshCwIcon', '#f4ecd8', '/image-convert'),
    _tool('pdf2img', 'PDF转图片', ToolCategory.pdf, '高清导出每一页', '5.1万人在用', 'FileTextIcon', '#e4efe7', '/pdf-to-image'),
    _tool('merge', 'PDF合并', ToolCategory.pdf, '多份文档合并为一份', '4.2万人在用', 'FileTextIcon', '#eef2ec', '/pdf-merge'),
    _tool('ocr', 'OCR文字识别', ToolCategory.office, '图片文字一键提取', '9.4万人在用', 'ScanTextIcon', '#f4ecd8', '/ocr'),
    _tool('id-photo-tool', '证件照制作', ToolCategory.life, 'AI智能抠图换背景', '15.7万人在用', 'CameraIcon', '#e4efe7', '/id-photo'),
    _tool('watermark', '图片加水印', ToolCategory.image, '批量添加文字水印', '3.6万人在用', 'PaletteIcon', '#eef2ec', '/image-watermark'),
  ];

  static const imageCompressFile = FileInfo(
    name: 'IMG_20240414_0428.jpg',
    size: '2.8 MB',
    resolution: '3024 × 4032',
    thumbnail: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=400&q=80',
  );

  static const specs = <SpecOption>[
    SpecOption(id: 'one-inch', label: '一寸照'),
    SpecOption(id: 'two-inch', label: '二寸照'),
    SpecOption(id: 'resume', label: '简历照'),
    SpecOption(id: 'exam', label: '考试报名'),
  ];

  static final List<BgColorOption> bgColors = [
    BgColorOption(id: 'blue', label: '蓝色', value: AppColors.fromHex('#4a6fa5')),
    BgColorOption(id: 'white', label: '白色', value: AppColors.fromHex('#f7f7f4')),
    BgColorOption(id: 'red', label: '红色', value: AppColors.fromHex('#b8534a')),
    BgColorOption(id: 'lightblue', label: '浅蓝', value: AppColors.fromHex('#9dc0dd')),
    BgColorOption(id: 'gray', label: '灰色', value: AppColors.fromHex('#b9bcb6')),
  ];

  static const idPhotoHeroImage = 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=700&q=80';
  static const processingAvatar = 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=400&q=80';

  static const processingSteps = <ProcessingStep>[
    ProcessingStep(id: 'face', label: '检测人脸与姿态', status: StepStatus.completed),
    ProcessingStep(id: 'matting', label: '智能抠图', status: StepStatus.completed),
    ProcessingStep(id: 'bg', label: '背景优化', status: StepStatus.active),
    ProcessingStep(id: 'size', label: '尺寸适配', status: StepStatus.pending),
    ProcessingStep(id: 'compress', label: '文件压缩', status: StepStatus.pending),
  ];

  static const idPhotoResultImage = 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=700&q=80';
  static const idPhotoOriginalImage = 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=700&q=80';

  static const idPhotoSpecInfo = <IdPhotoSpecInfo>[
    IdPhotoSpecInfo(label: '规格', value: '一寸照'),
    IdPhotoSpecInfo(label: '物理尺寸', value: '25 × 35mm'),
    IdPhotoSpecInfo(label: '像素尺寸', value: '295 × 413px'),
    IdPhotoSpecInfo(label: '分辨率', value: '300 DPI'),
    IdPhotoSpecInfo(label: '背景色', value: '绿色 / 白色'),
    IdPhotoSpecInfo(label: '文件格式', value: 'JPG · 高清'),
  ];

  static const resultThumbs = <ResultThumb>[
    ResultThumb(id: 't1', url: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80'),
    ResultThumb(id: 't2', url: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=80'),
    ResultThumb(id: 't3', url: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?auto=format&fit=crop&w=200&q=80'),
    ResultThumb(id: 't4', url: 'https://images.unsplash.com/photo-1520813792240-56fc4a3765a7?auto=format&fit=crop&w=200&q=80'),
  ];

  static const assetStats = <AssetStat>[
    AssetStat(id: 'coin', label: '金币', value: '1285', icon: 'CoinsIcon'),
    AssetStat(id: 'coupon', label: '优惠券', value: '3', icon: 'TicketIcon'),
    AssetStat(id: 'rights', label: '已购权益', value: '8', icon: 'PackageIcon'),
    AssetStat(id: 'orders', label: '我的订单', value: '12', icon: 'ShoppingBagIcon'),
  ];

  static final List<TaskItem> dailyTasks = [
    TaskItem(id: 'checkin', title: '每日签到', reward: '+10', action: '去签到', icon: 'CalendarCheckIcon', tint: AppColors.tintMint),
    TaskItem(id: 'invite', title: '邀请好友', reward: '+100', action: '立即邀请', icon: 'UserPlusIcon', tint: AppColors.tintGold),
  ];

  static const services = <ServiceItem>[
    ServiceItem(id: 'orders', label: '我的订单', icon: 'ShoppingBagIcon', route: '/orders'),
    ServiceItem(id: 'downloads', label: '下载记录', icon: 'DownloadIcon', route: '/downloads'),
    ServiceItem(id: 'history', label: 'AI历史', icon: 'ClockIcon', route: '/history'),
    ServiceItem(id: 'favorites', label: '我的收藏', icon: 'StarIcon', route: '/favorites'),
    ServiceItem(id: 'redeem', label: '卡券兑换', icon: 'TicketIcon', route: '/coupons'),
    ServiceItem(id: 'help', label: '帮助反馈', icon: 'HelpCircleIcon', route: '/help'),
    ServiceItem(id: 'settings', label: '设置', icon: 'SettingsIcon', route: '/settings'),
    ServiceItem(id: 'about', label: '关于我们', icon: 'InfoIcon', route: '/about'),
  ];

  static const vipBenefits = <VipBenefit>[
    VipBenefit(id: 'noads', label: '去广告', description: '纯净无干扰体验', icon: 'BanIcon'),
    VipBenefit(id: 'hd', label: '高清下载', description: '原图无损导出', icon: 'DownloadIcon'),
    VipBenefit(id: 'quota', label: 'AI专属额度', description: '每月额外算力', icon: 'SparklesIcon'),
    VipBenefit(id: 'exclusive', label: '专属功能', description: '会员限定工具', icon: 'StarIcon'),
  ];

  static const vipPlans = <VipPlan>[
    VipPlan(id: 'monthly', name: '月度会员', price: '¥9.9', period: '每月', badge: '', recommended: false),
    VipPlan(id: 'yearly', name: '年度会员', price: '¥59', period: '每年', badge: '最受欢迎', recommended: true),
    VipPlan(id: 'lifetime', name: '永久会员', price: '¥199', period: '一次买断', badge: '超值', recommended: false),
  ];

  static const shareMethods = <ShareMethod>[
    ShareMethod(id: 'wechat', label: '微信邀请', icon: 'MessageCircleIcon'),
    ShareMethod(id: 'link', label: '复制链接', icon: 'LinkIcon'),
    ShareMethod(id: 'poster', label: '分享海报', icon: 'Share2Icon'),
  ];

  static const inviteCode = 'AI2024';
  static const inviteCodePage = 'QINGQI2025';
  static const inviteStats = {'invitedFriends': '12', 'earnedCoins': '1280'};

  // ---- Discover page-local ----
  static const discoverTabs = ['推荐', '工具专题', '使用技巧', 'AI资讯'];

  static final List<DiscoverTopic> discoverTopics = [
    DiscoverTopic(
      id: 't1',
      title: 'AI 图片处理全攻略',
      desc: '压缩、修图、加水印，一站式搞定',
      tag: '图片专题',
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.primary, AppColors.forestLight]),
      emoji: '🖼️',
      route: '/tools',
    ),
    DiscoverTopic(
      id: 't2',
      title: '证件照 AI 制作',
      desc: '几秒钟生成标准证件照',
      tag: '生活工具',
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF24627E), Color(0xFF1A3D52)]),
      emoji: '📷',
      route: '/id-photo',
    ),
    DiscoverTopic(
      id: 't3',
      title: 'PDF 办公神器',
      desc: '合并、转图片，效率翻倍',
      tag: '办公效率',
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF2A4060), Color(0xFF3D5C85)]),
      emoji: '📄',
      route: '/pdf-merge',
    ),
  ];

  static final List<DiscoverFeature> discoverFeatures = [
    DiscoverFeature(title: '智能抠图', desc: '一键去背景，精准识别', emoji: '✂️', tint: AppColors.tintMint),
    DiscoverFeature(title: '文字识别', desc: '多语言OCR，高精度', emoji: '📝', tint: AppColors.tintGold),
    DiscoverFeature(title: '格式转换', desc: '多格式互转，无损质量', emoji: '🔁', tint: AppColors.tintSage),
    DiscoverFeature(title: '批量处理', desc: '一次处理多个文件', emoji: '📦', tint: AppColors.tintMint),
  ];

  static const hotRankItems = <HotRankItem>[
    HotRankItem(rank: 1, name: '图片压缩', usage: '12.6万人在用', emoji: '🗜️', route: '/image-compress'),
    HotRankItem(rank: 2, name: 'OCR文字识别', usage: '9.4万人在用', emoji: '🔍', route: '/ocr'),
    HotRankItem(rank: 3, name: '证件照制作', usage: '15.7万人在用', emoji: '🪪', route: '/id-photo'),
    HotRankItem(rank: 4, name: '图片尺寸调整', usage: '8.3万人在用', emoji: '📐', route: '/image-resize'),
    HotRankItem(rank: 5, name: '图片格式转换', usage: '6.8万人在用', emoji: '🔄', route: '/image-convert'),
    HotRankItem(rank: 6, name: 'PDF转图片', usage: '5.1万人在用', emoji: '📋', route: '/pdf-to-image'),
  ];

  static const articleCards = <ArticleCard>[
    ArticleCard(id: 'a1', title: '5个AI工具让你的工作效率提升3倍', category: '效率技巧', readTime: '3分钟', image: 'https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&w=200&q=80'),
    ArticleCard(id: 'a2', title: '手机证件照拍摄技巧：光线与背景的选择', category: '拍摄技巧', readTime: '5分钟', image: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=200&q=80'),
    ArticleCard(id: 'a3', title: 'PDF办公技巧：让文档管理更高效', category: '办公技巧', readTime: '4分钟', image: 'https://images.unsplash.com/photo-1586281380349-632531db7ed4?auto=format&fit=crop&w=200&q=80'),
    ArticleCard(id: 'a4', title: 'AI图像处理新技术：2024年度总结', category: 'AI资讯', readTime: '6分钟', image: 'https://images.unsplash.com/photo-1620712943543-ec5d90a4a1e2?auto=format&fit=crop&w=200&q=80'),
  ];

  // ---- Assistant ----
  static const assistantInitialMessage = '你好！我是轻启AI助手 🌿\n我可以帮你找到最合适的工具，或者直接处理你的任务。\n说说你需要做什么？';
  static const assistantQuickPrompts = [
    '帮我压缩这张图片',
    '制作证件照',
    '识别图片文字',
    '转换PDF格式',
    '图片去水印',
  ];

  // ---- PdfMerge ----
  static final List<MergeFile> initialMergeFiles = [
    MergeFile(name: '合同_正文.pdf', pages: 8, size: '1.2 MB'),
    MergeFile(name: '附件_说明书.pdf', pages: 4, size: '0.6 MB'),
    MergeFile(name: '封面设计稿.pdf', pages: 1, size: '0.8 MB'),
  ];

  // ---- OCR ----
  static const ocrMockResult = '''会议纪要

时间：2024年4月14日 14:30
地点：A栋503会议室
主持人：张总

议题一：Q2产品规划
本季度将重点推进移动端体验优化，新增AI辅助功能模块，预计5月底完成开发测试。

议题二：市场推广策略
拓展社交媒体渠道，与头部KOL合作完成品牌宣传，预算调整至50万元。

下次会议：4月28日 10:00''';

  // ---- Orders ----
  static const orders = <OrderItem>[
    OrderItem(id: 'o1', orderNo: 'QQ20240618001', title: '轻启VIP月度会员', subtitle: 'AI工具无限使用权益', status: 'completed', amount: '¥19.9', date: '2024-06-18 14:32', emoji: '👑'),
    OrderItem(id: 'o2', orderNo: 'QQ20240612003', title: '轻启VIP月度会员', subtitle: 'AI工具无限使用权益', status: 'completed', amount: '¥19.9', date: '2024-06-12 09:15', emoji: '👑'),
    OrderItem(id: 'o3', orderNo: 'QQ20240605007', title: '硬币充值 · 100枚', subtitle: '平台硬币，用于高级工具', status: 'paid', amount: '¥9.9', date: '2024-06-05 16:48', emoji: '🪙'),
    OrderItem(id: 'o4', orderNo: 'QQ20240520011', title: '轻启VIP季度会员', subtitle: 'AI工具无限使用权益', status: 'refunded', amount: '¥49.9', date: '2024-05-20 11:20', emoji: '👑'),
  ];

  // ---- Favorites ----
  static final List<FavTool> favTools = [
    FavTool(id: 'f1', name: '图片压缩', desc: '无损压缩，减小体积', category: ToolCategory.image, usage: '已用 12 次', emoji: '🗜️', tint: AppColors.tintMint, route: '/image-compress', savedAt: '3天前收藏'),
    FavTool(id: 'f2', name: 'AI证件照', desc: '智能抠图，一键制作', category: ToolCategory.life, usage: '已用 5 次', emoji: '🪪', tint: AppColors.tintBlue, route: '/id-photo', savedAt: '1周前收藏'),
    FavTool(id: 'f3', name: 'OCR文字识别', desc: '多语言精准识别', category: ToolCategory.image, usage: '已用 8 次', emoji: '🔍', tint: AppColors.tintOcrFav, route: '/ocr', savedAt: '2周前收藏'),
    FavTool(id: 'f4', name: 'PDF合并', desc: '多文件合并一步完成', category: ToolCategory.pdf, usage: '已用 3 次', emoji: '📄', tint: AppColors.tintPdfFav, route: '/pdf-merge', savedAt: '1个月前收藏'),
    FavTool(id: 'f5', name: '图片格式转换', desc: '多格式互转无损输出', category: ToolCategory.image, usage: '已用 6 次', emoji: '🔄', tint: AppColors.tintPurple, route: '/image-convert', savedAt: '1个月前收藏'),
  ];

  // ---- History ----
  static final List<HistoryItem> historyItems = [
    HistoryItem(id: 'h1', toolName: '图片压缩', emoji: '🗜️', tint: AppColors.tintMint, action: '压缩了 1 张图片', detail: 'photo_001.jpg → 234KB（节省62%）', date: '今天 14:32', group: '今天', route: '/image-compress'),
    HistoryItem(id: 'h2', toolName: 'AI证件照', emoji: '🪪', tint: AppColors.tintBlue, action: '制作了证件照', detail: '规格：一寸 · 白色背景', date: '今天 11:08', group: '今天', route: '/id-photo'),
    HistoryItem(id: 'h3', toolName: 'OCR识别', emoji: '🔍', tint: AppColors.tintOcrFav, action: '识别了 1 张图片', detail: '共提取 238 字', date: '昨天 18:44', group: '昨天', route: '/ocr'),
    HistoryItem(id: 'h4', toolName: '图片格式转换', emoji: '🔄', tint: AppColors.tintPurple, action: '转换了 2 张图片', detail: 'PNG → WEBP', date: '昨天 15:20', group: '昨天', route: '/image-convert'),
    HistoryItem(id: 'h5', toolName: 'PDF合并', emoji: '📄', tint: AppColors.tintPdfFav, action: '合并了 3 个PDF', detail: '输出文件：merged_20240617.pdf', date: '06-17 09:11', group: '本周', route: '/pdf-merge'),
    HistoryItem(id: 'h6', toolName: '图片尺寸调整', emoji: '📐', tint: AppColors.tintResizeFav, action: '调整了图片尺寸', detail: '1920×1080 → 800×450', date: '06-16 20:30', group: '本周', route: '/image-resize'),
    HistoryItem(id: 'h7', toolName: '图片加水印', emoji: '💧', tint: AppColors.tintWatermarkFav, action: '添加了水印', detail: '文字水印 · 右下角 · 30%透明度', date: '06-14 13:55', group: '更早', route: '/image-watermark'),
    HistoryItem(id: 'h8', toolName: 'PDF转图片', emoji: '📋', tint: AppColors.tintMint, action: '转换了 1 个PDF', detail: '共 5 页 → 5 张图片', date: '06-10 10:00', group: '更早', route: '/pdf-to-image'),
  ];

  // ---- Coupons ----
  static final List<Coupon> coupons = [
    Coupon(id: 'c1', title: 'VIP会员折扣券', subtitle: '购买VIP月卡立减', type: 'vip_discount', discount: '立减 ¥5', condition: '购VIP月卡满¥19.9可用', expiry: '2024-07-31 到期', code: 'VIP2407A', status: 'available', color: AppColors.accent, bgColor: AppColors.tintOcrFav, emoji: '👑'),
    Coupon(id: 'c2', title: '工具免费使用券', subtitle: '任意付费工具免费用一次', type: 'tool_free', discount: '免费使用 ×1', condition: '任意付费工具可用', expiry: '2024-07-20 到期', code: 'FREE071', status: 'available', color: AppColors.midSage, bgColor: AppColors.tintMint, emoji: '🎁'),
    Coupon(id: 'c3', title: '硬币充值加赠', subtitle: '充值100硬币额外赠30', type: 'coin_bonus', discount: '+30 硬币', condition: '充值100硬币时可用', expiry: '2024-08-15 到期', code: 'COIN30X', status: 'available', color: AppColors.paidBlue, bgColor: AppColors.tintBlue, emoji: '🪙'),
    Coupon(id: 'c4', title: '新用户专属折扣', subtitle: '首次购买享8折', type: 'full_discount', discount: '8折优惠', condition: '任意商品首次购买', expiry: '2024-06-10 到期', code: 'NEW80PX', status: 'expired', color: AppColors.placeholderGray, bgColor: AppColors.tintBeige, emoji: '🌟'),
    Coupon(id: 'c5', title: '季度会员折扣', subtitle: '购买VIP季卡享优惠', type: 'vip_discount', discount: '立减 ¥10', condition: '购VIP季卡满¥49.9可用', expiry: '2024-05-31 到期', code: 'VIPQ05X', status: 'used', color: AppColors.placeholderGray, bgColor: AppColors.tintBeige, emoji: '👑'),
  ];

  // ---- Downloads ----
  static final List<DownloadItem> downloads = [
    DownloadItem(id: 'd1', name: 'compressed_photo_001.jpg', type: 'image', size: '234 KB', toolName: '图片压缩', emoji: '🗜️', date: '今天 14:32', group: '今天', count: 2),
    DownloadItem(id: 'd2', name: 'id_photo_white_1inch.jpg', type: 'image', size: '98 KB', toolName: 'AI证件照', emoji: '🪪', date: '今天 11:08', group: '今天', count: 1),
    DownloadItem(id: 'd3', name: 'ocr_result_20240618.txt', type: 'other', size: '4 KB', toolName: 'OCR识别', emoji: '🔍', date: '昨天 18:44', group: '昨天', count: 1),
    DownloadItem(id: 'd4', name: 'converted_image_webp.webp', type: 'image', size: '156 KB', toolName: '格式转换', emoji: '🔄', date: '昨天 15:20', group: '昨天', count: 1),
    DownloadItem(id: 'd5', name: 'merged_documents.pdf', type: 'pdf', size: '2.4 MB', toolName: 'PDF合并', emoji: '📄', date: '06-17 09:11', group: '本周', count: 3),
    DownloadItem(id: 'd6', name: 'resized_800x450.jpg', type: 'image', size: '312 KB', toolName: '尺寸调整', emoji: '📐', date: '06-16 20:30', group: '本周', count: 1),
    DownloadItem(id: 'd7', name: 'watermarked_photo.png', type: 'image', size: '1.2 MB', toolName: '图片加水印', emoji: '💧', date: '06-14 13:55', group: '更早', count: 1),
    DownloadItem(id: 'd8', name: 'pdf_to_images_page1.jpg', type: 'image', size: '456 KB', toolName: 'PDF转图片', emoji: '📋', date: '06-10 10:00', group: '更早', count: 2),
  ];

  // ---- Help ----
  static const faqItems = <FaqItem>[
    FaqItem(id: 'q1', question: '如何使用硬币兑换服务？', answer: '硬币是轻启AI平台内的虚拟货币，可通过每日签到、邀请好友等任务获取。在工具处理页面如需消耗硬币，系统会自动扣减；你也可以在"我的-卡券兑换"中使用硬币兑换优惠券或会员时长。'),
    FaqItem(id: 'q2', question: '处理后的图片保留多久？', answer: '为保障您的隐私，处理后的图片在服务器仅保留 24 小时，逾期自动永久删除。但您的下载记录会一直保留，方便随时回溯处理历史。建议处理完成后及时下载保存。'),
    FaqItem(id: 'q3', question: 'VIP和普通用户有什么区别？', answer: 'VIP会员可无限次使用所有工具、享受优先处理队列、更高清的导出画质、专属客服支持，以及每月额外的 AI 算力额度与硬币奖励。普通用户每日有免费处理次数限制。'),
    FaqItem(id: 'q4', question: '证件照规格不满意怎么办？', answer: '在 AI 证件照工具中，除了预设的一寸、二寸、简历照、考试报名等规格外，还支持自定义尺寸。您可以手动输入像素或毫米尺寸，系统会按比例智能裁剪并保留人脸居中。'),
    FaqItem(id: 'q5', question: '上传图片是否安全？', answer: '我们采用端到端加密传输，处理完成后自动删除原始文件，绝不存储或用于训练。所有 AI 处理均在加密环境下进行，您的数据只属于您。'),
  ];

  // ---- Settings ----
  static const settingToggles = <SettingToggle>[
    SettingToggle(id: 'push', emoji: '🔔', label: '推送通知', desc: '工具完成、优惠活动提醒', defaultOn: true),
    SettingToggle(id: 'dark', emoji: '🌙', label: '深色模式', desc: '跟随系统或手动切换', defaultOn: false),
    SettingToggle(id: 'biometric', emoji: '🔐', label: '生物识别登录', desc: 'Face ID / 指纹快速登录', defaultOn: true),
    SettingToggle(id: 'autosave', emoji: '💾', label: '自动保存结果', desc: '处理完成后自动保存到下载记录', defaultOn: true),
    SettingToggle(id: 'analytics', emoji: '📊', label: '使用数据分析', desc: '帮助改善产品体验（匿名）', defaultOn: false),
  ];

  static const settingLinks = <SettingLink>[
    SettingLink(id: 'lang', emoji: '🌏', label: '语言设置', trailing: '简体中文'),
    SettingLink(id: 'cache', emoji: '🗑️', label: '缓存清理', trailing: '当前缓存 28.4 MB'),
    SettingLink(id: 'privacy', emoji: '📃', label: '隐私政策', trailing: '查看数据处理说明'),
    SettingLink(id: 'terms', emoji: '📜', label: '用户协议', trailing: '了解服务条款'),
    SettingLink(id: 'security', emoji: '🔑', label: '账号与安全', trailing: '修改密码、绑定手机'),
  ];

  // ---- About ----
  static const aboutMilestones = <AboutMilestone>[
    AboutMilestone(emoji: '🌱', value: '2023', label: '成立年份'),
    AboutMilestone(emoji: '👥', value: '50W+', label: '注册用户'),
    AboutMilestone(emoji: '⚡', value: '200W+', label: '月处理次数'),
    AboutMilestone(emoji: '🌍', value: '120+', label: '服务地区'),
  ];

  static const aboutValues = <AboutValue>[
    AboutValue(emoji: '🌿', title: '自然美学', desc: '以自然为灵感，设计温暖而有质感的体验'),
    AboutValue(emoji: '⚡', title: '效率优先', desc: 'AI 赋能每个工具，让复杂任务变得简单'),
    AboutValue(emoji: '🔒', title: '数据安全', desc: '端到端加密，您的数据只属于您'),
    AboutValue(emoji: '💚', title: '持续迭代', desc: '倾听用户声音，每周更新优化'),
  ];

  static const aboutInfoLinks = [
    {'emoji': '📜', 'label': '用户协议'},
    {'emoji': '🛡️', 'label': '隐私政策'},
    {'emoji': '💻', 'label': '开源声明'},
    {'emoji': '🤝', 'label': '媒体合作'},
  ];
}
