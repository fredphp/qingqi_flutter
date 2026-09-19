import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';

/// Maps React lucide-react PascalCase icon names (e.g. "ImageIcon", "ChevronLeftIcon")
/// to Flutter IconData. This is the single source of truth for icon parity with the
/// original React app. Any icon name from mockData / components resolves here.
class AppIcons {
  AppIcons._();

  static const Map<String, IconData> _map = {
    // navigation / chrome
    'HomeIcon': LucideIcons.home,
    'LayoutGridIcon': LucideIcons.layoutGrid,
    'SparklesIcon': LucideIcons.sparkles,
    'CompassIcon': LucideIcons.compass,
    'UserIcon': LucideIcons.user,
    'ChevronLeftIcon': LucideIcons.chevronLeft,
    'ChevronRightIcon': LucideIcons.chevronRight,
    'ChevronUpIcon': LucideIcons.chevronUp,
    'ChevronDownIcon': LucideIcons.chevronDown,
    'MoreHorizontalIcon': LucideIcons.moreHorizontal,
    'ArrowRightIcon': LucideIcons.arrowRight,
    'ArrowLeftIcon': LucideIcons.arrowLeft,
    'ArrowUpIcon': LucideIcons.arrowUp,
    'ArrowDownIcon': LucideIcons.arrowDown,
    'XIcon': LucideIcons.x,
    'PlusIcon': LucideIcons.plus,
    'MinusIcon': LucideIcons.minus,
    'SearchIcon': LucideIcons.search,
    'BellIcon': LucideIcons.bell,
    'MenuIcon': LucideIcons.menu,
    'ExternalLinkIcon': LucideIcons.externalLink,
    // tool icons
    'ImageIcon': LucideIcons.image,
    'ImagePlusIcon': LucideIcons.imagePlus,
    'FileTextIcon': LucideIcons.fileText,
    'FileIcon': LucideIcons.file,
    'FileImageIcon': LucideIcons.fileImage,
    'ScanTextIcon': LucideIcons.scanLine,
    'ScanIcon': LucideIcons.scan,
    'RulerIcon': LucideIcons.ruler,
    'RefreshCwIcon': LucideIcons.refreshCw,
    'RotateCwIcon': LucideIcons.rotateCw,
    'RotateCcwIcon': LucideIcons.rotateCcw,
    'CameraIcon': LucideIcons.camera,
    'PaletteIcon': LucideIcons.palette,
    'TypeIcon': LucideIcons.type,
    'MoveIcon': LucideIcons.move,
    'AlignLeftIcon': LucideIcons.alignLeft,
    'LanguagesIcon': LucideIcons.languages,
    'GalleryHorizontalEndIcon': LucideIcons.galleryHorizontalEnd,
    'FilesIcon': LucideIcons.files,
    'Maximize2Icon': LucideIcons.maximize2,
    // status / feedback
    'CheckIcon': LucideIcons.check,
    'CheckCircleIcon': LucideIcons.checkCircle,
    'CheckCircle2Icon': LucideIcons.checkCircle2,
    'CircleCheckIcon': LucideIcons.checkCircle,
    'CircleCheckBigIcon': LucideIcons.checkCircle2,
    'CircleDashedIcon': LucideIcons.circleDashed,
    'LoaderIcon': LucideIcons.loader2,
    'LoaderCircleIcon': LucideIcons.loader2,
    'AlertCircleIcon': LucideIcons.alertCircle,
    'InfoIcon': LucideIcons.info,
    'HelpCircleIcon': LucideIcons.helpCircle,
    'BanIcon': LucideIcons.ban,
    'ShieldCheckIcon': LucideIcons.shieldCheck,
    'ShieldIcon': LucideIcons.shield,
    // finance / assets
    'CoinsIcon': LucideIcons.coins,
    'TicketIcon': LucideIcons.ticket,
    'PackageIcon': LucideIcons.package,
    'ShoppingBagIcon': LucideIcons.shoppingBag,
    'WalletIcon': LucideIcons.wallet,
    'CreditCardIcon': LucideIcons.creditCard,
    'TagIcon': LucideIcons.tag,
    'PercentIcon': LucideIcons.percent,
    'ReceiptIcon': LucideIcons.receipt,
    'TrophyIcon': LucideIcons.trophy,
    'GiftIcon': LucideIcons.gift,
    // user / social
    'UserPlusIcon': LucideIcons.userPlus,
    'UsersIcon': LucideIcons.users,
    'UserCheckIcon': LucideIcons.userCheck,
    'MessageCircleIcon': LucideIcons.messageCircle,
    'Share2Icon': LucideIcons.share2,
    'ShareIcon': LucideIcons.share,
    'LinkIcon': LucideIcons.link,
    'CopyIcon': LucideIcons.copy,
    'CopyCheckIcon': LucideIcons.copyCheck,
    'SendIcon': LucideIcons.send,
    'HeartIcon': LucideIcons.heart,
    'StarIcon': LucideIcons.star,
    'BookmarkIcon': LucideIcons.bookmark,
    'CrownIcon': LucideIcons.crown,
    'PencilIcon': LucideIcons.pencil,
    'BellOffIcon': LucideIcons.bellOff,
    // time / activity
    'ClockIcon': LucideIcons.clock,
    'CalendarCheckIcon': LucideIcons.calendarCheck,
    'CalendarIcon': LucideIcons.calendar,
    'HistoryIcon': LucideIcons.history,
    'ZapIcon': LucideIcons.zap,
    'TrendingUpIcon': LucideIcons.trendingUp,
    'FlameIcon': LucideIcons.flame,
    'BookOpenIcon': LucideIcons.bookOpen,
    'LeafIcon': LucideIcons.leaf,
    'SproutIcon': LucideIcons.sprout,
    'TreesIcon': LucideIcons.trees,
    // file ops
    'DownloadIcon': LucideIcons.download,
    'DownloadCloudIcon': LucideIcons.downloadCloud,
    'UploadIcon': LucideIcons.upload,
    'Trash2Icon': LucideIcons.trash2,
    'TrashIcon': LucideIcons.trash2,
    'FolderOpenIcon': LucideIcons.folderOpen,
    'FolderIcon': LucideIcons.folder,
    'PrinterIcon': LucideIcons.printer,
    'FilterIcon': LucideIcons.filter,
    // settings
    'SettingsIcon': LucideIcons.settings,
    'LogOutIcon': LucideIcons.logOut,
    'LockIcon': LucideIcons.lock,
    'UnlockIcon': LucideIcons.unlock,
    'ToggleLeftIcon': LucideIcons.toggleLeft,
    'ToggleRightIcon': LucideIcons.toggleRight,
    'MoonIcon': LucideIcons.moon,
    'SunIcon': LucideIcons.sun,
    'GlobeIcon': LucideIcons.globe,
    'SmartphoneIcon': LucideIcons.smartphone,
    'MonitorIcon': LucideIcons.monitor,
    'EyeIcon': LucideIcons.eye,
    'EyeOffIcon': LucideIcons.eyeOff,
    'MicIcon': LucideIcons.mic,
    'MapPinIcon': LucideIcons.mapPin,
    'MailIcon': LucideIcons.mail,
    'PhoneIcon': LucideIcons.phone,
    'QrCodeIcon': LucideIcons.qrCode,
    'LayoutDashboardIcon': LucideIcons.layoutDashboard,
  };

  /// Resolve an icon name (e.g. "ImageIcon" or "Image") to IconData.
  /// Falls back to a leaf icon if not found.
  static IconData resolve(String? name) {
    if (name == null || name.isEmpty) return LucideIcons.leaf;
    final direct = _map[name];
    if (direct != null) return direct;
    // try with "Icon" suffix
    final suffixed = _map['${name}Icon'];
    if (suffixed != null) return suffixed;
    // try lowercase camelCase (e.g. "image" -> not in map, skip)
    return LucideIcons.leaf;
  }
}
