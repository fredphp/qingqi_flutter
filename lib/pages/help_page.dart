import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/top_bar.dart';

/// 帮助与反馈 page — route `/help`.
/// Mirrors src/pages/Help.tsx.
class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  String? _expandedId;
  int _rating = 0;
  bool _submitted = false;
  final TextEditingController _feedbackController = TextEditingController();

  static const _contactMethods = <_ContactMethod>[
    _ContactMethod(
        id: 'online',
        icon: '💬',
        label: '在线客服',
        desc: '工作日 9:00 - 18:00',
        available: true),
    _ContactMethod(
        id: 'email',
        icon: '📧',
        label: '邮件反馈',
        desc: 'support@qingqiai.com',
        available: true),
    _ContactMethod(
        id: 'phone',
        icon: '📞',
        label: '电话支持',
        desc: '仅 VIP 用户可用',
        available: false),
  ];

  static const _ratingLabels = ['', '很差', '较差', '一般', '不错', '非常好'];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_feedbackController.text.trim().isEmpty) return;
    setState(() => _submitted = true);
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _submitted = false;
        _feedbackController.clear();
        _rating = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '帮助与反馈', showBack: true, backTo: '/profile'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 32),
              children: [
                _buildBanner(),
                _buildContactSection(),
                _buildFaqSection(),
                _buildFeedbackSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Banner ──
  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppGradients.promo,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
            ),
            alignment: Alignment.center,
            child: const Text('🌿', style: TextStyle(fontSize: 28, height: 1)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '有问题找我们',
                  style: AppTheme.display(
                    size: 16,
                    weight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '平均响应时间 < 2 小时，随时为您服务',
                  style: AppTheme.sans(
                    size: 12,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Section heading ──
  Widget _buildSectionHeading(String text, {Color color = AppColors.midSage}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: AppTheme.sans(
          size: 13,
          weight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  // ── Contact section ──
  Widget _buildContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeading('联系我们'),
          Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
              boxShadow: AppShadows.soft,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (int i = 0; i < _contactMethods.length; i++) ...[
                  _buildContactRow(_contactMethods[i]),
                  if (i < _contactMethods.length - 1)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 1,
                      color: const Color(0xFFF1EDE1),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(_ContactMethod m) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F6F2),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(m.icon, style: const TextStyle(fontSize: 18, height: 1)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  m.label,
                  style: AppTheme.sans(
                    size: 13,
                    weight: FontWeight.w600,
                    color: m.available
                        ? const Color(0xFF2A3A30)
                        : AppColors.placeholderGray,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  m.desc,
                  style: AppTheme.sans(size: 11.5, color: AppColors.mutedForeground),
                ),
              ],
            ),
          ),
          if (m.available)
            const Icon(LucideIcons.chevronRight,
                size: 15, color: AppColors.placeholderGray)
          else
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F6F2),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'VIP专属',
                style: AppTheme.sans(
                  size: 10,
                  color: AppColors.midSage,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── FAQ section ──
  Widget _buildFaqSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeading('常见问题'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < MockData.faqItems.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                _buildFaqCard(MockData.faqItems[i]),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFaqCard(FaqItem item) {
    final expanded = _expandedId == item.id;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.soft,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PressableScale(
            onTap: () {
              setState(() {
                _expandedId = expanded ? null : item.id;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F6F2),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(LucideIcons.helpCircle,
                        size: 13, color: AppColors.midSage),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.question,
                      style: AppTheme.sans(
                        size: 13,
                        weight: FontWeight.w500,
                        color: AppColors.foreground,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: expanded ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(LucideIcons.chevronRight,
                        size: 14, color: AppColors.placeholderGray),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: expanded
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 1,
                          color: const Color(0xFFF1EDE1),
                          margin: const EdgeInsets.only(bottom: 12),
                        ),
                        Text(
                          item.answer,
                          style: AppTheme.sans(
                            size: 12.5,
                            color: AppColors.mutedForeground,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // ── Feedback section ──
  Widget _buildFeedbackSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeading('意见反馈'),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
              boxShadow: AppShadows.soft,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Rating
                Text(
                  '您的评分',
                  style: AppTheme.sans(
                      size: 12.5, color: AppColors.mutedForeground),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    for (int s = 1; s <= 5; s++) ...[
                      if (s > 1) const SizedBox(width: 8),
                      PressableScale(
                        scale: 0.90,
                        onTap: () => setState(() => _rating = s),
                        child: Icon(
                          s <= _rating ? Icons.star : Icons.star_border,
                          size: 26,
                          color: s <= _rating
                              ? AppColors.accent
                              : const Color(0xFFE0DDD6),
                        ),
                      ),
                    ],
                    if (_rating > 0) ...[
                      const SizedBox(width: 4),
                      Text(
                        _ratingLabels[_rating],
                        style: AppTheme.sans(
                            size: 12, color: AppColors.accent),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                // Textarea
                Text(
                  '描述您的问题或建议',
                  style: AppTheme.sans(
                      size: 12.5, color: AppColors.mutedForeground),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _feedbackController,
                  maxLines: 4,
                  minLines: 4,
                  onChanged: (v) => setState(() {}),
                  style: AppTheme.sans(
                      size: 12.5, color: const Color(0xFF2A3A30)),
                  decoration: InputDecoration(
                    hintText:
                        '请详细描述您遇到的问题或改进建议，我们将认真对待每一条反馈…',
                    hintStyle: AppTheme.sans(
                        size: 12.5, color: AppColors.placeholderGray),
                    filled: true,
                    fillColor: const Color(0xFFF8F6EF),
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Color(0x1A1F4B39), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Color(0x1A1F4B39), width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                          color: Color(0x1A1F4B39), width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Submit
                PressableScale(
                  scale: 0.98,
                  onTap: _handleSubmit,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient: _submitted
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF4A7A63),
                                AppColors.forestLight,
                              ],
                            )
                          : AppGradients.promo,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(LucideIcons.send,
                            size: 14, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          _submitted ? '反馈已提交，感谢！' : '提交反馈',
                          style: AppTheme.sans(
                            size: 13.5,
                            weight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Private models
// ─────────────────────────────────────────────────────────────────────────────

class _ContactMethod {
  const _ContactMethod({
    required this.id,
    required this.icon,
    required this.label,
    required this.desc,
    required this.available,
  });
  final String id;
  final String icon;
  final String label;
  final String desc;
  final bool available;
}
