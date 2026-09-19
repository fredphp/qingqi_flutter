import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/tools_page.dart';
import 'pages/profile_page.dart';
import 'pages/discover_page.dart';
import 'pages/assistant_page.dart';
import 'pages/image_compress_page.dart';
import 'pages/image_resize_page.dart';
import 'pages/image_convert_page.dart';
import 'pages/image_watermark_page.dart';
import 'pages/pdf_to_image_page.dart';
import 'pages/pdf_merge_page.dart';
import 'pages/ocr_page.dart';
import 'pages/id_photo_page.dart';
import 'pages/processing_page.dart';
import 'pages/result_page.dart';
import 'pages/vip_page.dart';
import 'pages/invite_page.dart';
import 'pages/orders_page.dart';
import 'pages/favorites_page.dart';
import 'pages/history_page.dart';
import 'pages/coupons_page.dart';
import 'pages/downloads_page.dart';
import 'pages/help_page.dart';
import 'pages/settings_page.dart';
import 'pages/about_page.dart';

/// Central route table. Mirrors the React Router routes in App.tsx.
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String tools = '/tools';
  static const String imageCompress = '/image-compress';
  static const String imageResize = '/image-resize';
  static const String imageConvert = '/image-convert';
  static const String imageWatermark = '/image-watermark';
  static const String pdfToImage = '/pdf-to-image';
  static const String pdfMerge = '/pdf-merge';
  static const String ocr = '/ocr';
  static const String idPhoto = '/id-photo';
  static const String processing = '/processing';
  static const String result = '/result';
  static const String profile = '/profile';
  static const String vip = '/vip';
  static const String invite = '/invite';
  static const String discover = '/discover';
  static const String assistant = '/assistant';
  static const String orders = '/orders';
  static const String favorites = '/favorites';
  static const String history = '/history';
  static const String coupons = '/coupons';
  static const String downloads = '/downloads';
  static const String help = '/help';
  static const String settings = '/settings';
  static const String about = '/about';

  static Map<String, WidgetBuilder> get routes => {
        home: (_) => const HomePage(),
        tools: (_) => const ToolsPage(),
        imageCompress: (_) => const ImageCompressPage(),
        imageResize: (_) => const ImageResizePage(),
        imageConvert: (_) => const ImageConvertPage(),
        imageWatermark: (_) => const ImageWatermarkPage(),
        pdfToImage: (_) => const PdfToImagePage(),
        pdfMerge: (_) => const PdfMergePage(),
        ocr: (_) => const OcrPage(),
        idPhoto: (_) => const IdPhotoPage(),
        processing: (_) => const ProcessingPage(),
        result: (_) => const ResultPage(),
        profile: (_) => const ProfilePage(),
        vip: (_) => const VipPage(),
        invite: (_) => const InvitePage(),
        discover: (_) => const DiscoverPage(),
        assistant: (_) => const AssistantPage(),
        orders: (_) => const OrdersPage(),
        favorites: (_) => const FavoritesPage(),
        history: (_) => const HistoryPage(),
        coupons: (_) => const CouponsPage(),
        downloads: (_) => const DownloadsPage(),
        help: (_) => const HelpPage(),
        settings: (_) => const SettingsPage(),
        about: (_) => const AboutPage(),
      };

  /// Push a named route.
  static void go(BuildContext context, String route) {
    if (route.isEmpty) return;
    Navigator.of(context).pushNamed(route);
  }

  /// Replace current route (used for processing → result auto navigation).
  static void goReplace(BuildContext context, String route) {
    if (route.isEmpty) return;
    Navigator.of(context).pushReplacementNamed(route);
  }
}
