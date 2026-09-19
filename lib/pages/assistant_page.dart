import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';
import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';

/// AI chat assistant — full-screen chat (no bottom nav).
class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

// ──────────────────────────────────────────────────────────────
// Internal message model
// ──────────────────────────────────────────────────────────────
class _Tool {
  final String emoji;
  final String name;
  final String route;
  const _Tool(this.emoji, this.name, this.route);
}

class _Reply {
  final String text;
  final List<_Tool> tools;
  const _Reply(this.text, this.tools);
}

class _Msg {
  final String id;
  final String text;
  final bool fromUser;
  final String time;
  final List<_Tool> tools;
  const _Msg({
    required this.id,
    required this.text,
    required this.fromUser,
    required this.time,
    required this.tools,
  });
}

class _AssistantPageState extends State<AssistantPage> {
  final TextEditingController _inputCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  late final List<_Msg> _messages;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _messages = [
      _Msg(
        id: 'm0',
        text: MockData.assistantInitialMessage,
        fromUser: false,
        time: '现在',
        tools: const [],
      ),
    ];
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  String _now() {
    final d = DateTime.now();
    return '${d.hour.toString().padLeft(2, '0')}:'
        '${d.minute.toString().padLeft(2, '0')}';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollCtrl.hasClients) return;
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  _Reply _getReply(String text) {
    if (text.contains('压缩')) {
      return _Reply(
        '好的，图片压缩工具可以帮你减小文件体积～',
        [_Tool('🗜️', '图片压缩', AppRoutes.imageCompress)],
      );
    }
    if (text.contains('证件照')) {
      return _Reply(
        'AI证件照制作，一键生成标准证件照～',
        [_Tool('🪪', 'AI证件照', AppRoutes.idPhoto)],
      );
    }
    if (text.contains('文字')) {
      return _Reply(
        'OCR文字识别可以提取图片中的文字～',
        [_Tool('🔍', 'OCR识别', AppRoutes.ocr)],
      );
    }
    if (text.contains('PDF')) {
      return _Reply(
        'PDF工具支持转图片、合并等操作～',
        [
          _Tool('📄', 'PDF转图片', AppRoutes.pdfToImage),
          _Tool('📄', 'PDF合并', AppRoutes.pdfMerge),
        ],
      );
    }
    if (text.contains('水印')) {
      return _Reply(
        '图片加水印工具可以批量添加文字水印～',
        [_Tool('💧', '图片加水印', AppRoutes.imageWatermark)],
      );
    }
    if (text.contains('格式')) {
      return _Reply(
        '图片格式转换支持JPG/PNG/WEBP等互转～',
        [_Tool('🔄', '格式转换', AppRoutes.imageConvert)],
      );
    }
    return _Reply('我帮你找找合适的工具～ 试试上面的快捷提问吧 🌿', const []);
  }

  void _send(String text) {
    final t = text.trim();
    if (t.isEmpty || _loading) return;
    setState(() {
      _messages.add(_Msg(
        id: 'u_${DateTime.now().millisecondsSinceEpoch}',
        text: t,
        fromUser: true,
        time: _now(),
        tools: const [],
      ));
      _loading = true;
    });
    _inputCtrl.clear();
    setState(() {});
    _scrollToBottom();
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      final reply = _getReply(t);
      setState(() {
        _messages.add(_Msg(
          id: 'a_${DateTime.now().millisecondsSinceEpoch}',
          text: reply.text,
          fromUser: false,
          time: _now(),
          tools: reply.tools,
        ));
        _loading = false;
      });
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildTopBar(context),
          Expanded(child: _buildMessages()),
          _buildQuickPrompts(),
          _buildInputBar(context),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Top bar
  // ────────────────────────────────────────────────────────────
  Widget _buildTopBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF0F6F2), Color(0xF2F0F6F2)],
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                gradient: AppGradients.assistantBubble,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              alignment: Alignment.center,
              child: const Icon(LucideIcons.sparkles, size: 17, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'AI 助手',
                    style: AppTheme.display(
                      size: 16,
                      weight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '在线 · 随时帮你',
                        style: AppTheme.sans(size: 11, color: AppColors.mutedForeground),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  AppRoutes.go(context, AppRoutes.home);
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFEEF2EC),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(LucideIcons.x, size: 15, color: AppColors.midSage),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Messages list
  // ────────────────────────────────────────────────────────────
  Widget _buildMessages() {
    final itemCount = _messages.length + (_loading ? 1 : 0);
    return ListView.builder(
      controller: _scrollCtrl,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      itemCount: itemCount,
      itemBuilder: (context, i) {
        if (i == _messages.length) {
          return const Padding(
            padding: EdgeInsets.only(top: 16),
            child: _LoadingBubble(),
          );
        }
        final msg = _messages[i];
        return Padding(
          padding: EdgeInsets.only(top: i == 0 ? 0 : 16),
          child: _MessageBubble(
            msg: msg,
            onToolTap: (r) => AppRoutes.go(context, r),
          ),
        );
      },
    );
  }

  // ────────────────────────────────────────────────────────────
  // Quick prompts
  // ────────────────────────────────────────────────────────────
  Widget _buildQuickPrompts() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: SizedBox(
        height: 32,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: MockData.assistantQuickPrompts.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final p = MockData.assistantQuickPrompts[i];
            return GestureDetector(
              onTap: () => _send(p),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEFCF6),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0x331F4B39)),
                ),
                alignment: Alignment.center,
                child: Text(
                  p,
                  style: AppTheme.sans(
                    size: 11.5,
                    weight: FontWeight.w500,
                    color: AppColors.midSage,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // Input bar
  // ────────────────────────────────────────────────────────────
  Widget _buildInputBar(BuildContext context) {
    final hasInput = _inputCtrl.text.trim().isNotEmpty;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        decoration: const BoxDecoration(
          color: Color(0xFFFDFBF7),
          border: Border(top: BorderSide(color: Color(0xFFF0EDE4), width: 1)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0x2E1F4B39), width: 1.5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x141F4B39),
                blurRadius: 12,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: _inputCtrl,
                  maxLines: 3,
                  minLines: 1,
                  style: AppTheme.sans(size: 14, color: const Color(0xFF2A3A30)),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                    border: InputBorder.none,
                    hintText: '说说你想做什么…',
                    hintStyle: AppTheme.sans(
                      size: 14,
                      color: AppColors.placeholderGray,
                    ),
                  ),
                  textInputAction: TextInputAction.send,
                  onSubmitted: (v) => _send(v),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEF2EC),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(LucideIcons.mic, size: 15, color: AppColors.midSage),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => _send(_inputCtrl.text),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: hasInput ? AppGradients.assistantBubble : null,
                        color: hasInput ? null : const Color(0xFFE8E2D5),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        LucideIcons.arrowUp,
                        size: 15,
                        color: hasInput ? Colors.white : AppColors.placeholderGray,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// Message bubble
// ──────────────────────────────────────────────────────────────
class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.msg, required this.onToolTap});
  final _Msg msg;
  final void Function(String route) onToolTap;

  @override
  Widget build(BuildContext context) {
    final isUser = msg.fromUser;
    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser) ...[
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              gradient: AppGradients.assistantBubble,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            alignment: Alignment.center,
            child: const Icon(LucideIcons.sparkles, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 10),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: isUser ? AppGradients.assistantBubble : null,
                  color: isUser ? null : Colors.white,
                  border: isUser ? null : Border.all(color: const Color(0xFFEDE8DE)),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(24),
                    topRight: const Radius.circular(24),
                    bottomLeft: isUser ? const Radius.circular(24) : const Radius.circular(8),
                    bottomRight: isUser ? const Radius.circular(8) : const Radius.circular(24),
                  ),
                ),
                child: Text(
                  msg.text,
                  style: AppTheme.sans(
                    size: 13.5,
                    color: isUser ? Colors.white : const Color(0xFF2A3A30),
                    height: 1.5,
                  ),
                ),
              ),
              if (msg.tools.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: msg.tools
                      .map((t) => _ToolChip(tool: t, onTap: () => onToolTap(t.route)))
                      .toList(),
                ),
              ],
              const SizedBox(height: 4),
              Text(
                msg.time,
                style: AppTheme.sans(size: 10, color: AppColors.placeholderGray),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToolChip extends StatelessWidget {
  const _ToolChip({required this.tool, required this.onTap});
  final _Tool tool;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: const BoxDecoration(
          gradient: AppGradients.assistantBubble,
          borderRadius: BorderRadius.all(Radius.circular(999)),
          boxShadow: [
            BoxShadow(
              color: Color(0x471F4B39),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(tool.emoji, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
            Text(
              tool.name,
              style: AppTheme.sans(
                size: 12,
                weight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(LucideIcons.chevronRight, size: 11, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// Loading bubble (3 bouncing dots)
// ──────────────────────────────────────────────────────────────
class _LoadingBubble extends StatefulWidget {
  const _LoadingBubble();

  @override
  State<_LoadingBubble> createState() => _LoadingBubbleState();
}

class _LoadingBubbleState extends State<_LoadingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            gradient: AppGradients.assistantBubble,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          alignment: Alignment.center,
          child: const Icon(LucideIcons.sparkles, size: 16, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFEDE8DE)),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 3; i++) ...[
                if (i > 0) const SizedBox(width: 4),
                _BouncingDot(animation: _ctrl, delay: i * 0.2),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _BouncingDot extends StatelessWidget {
  const _BouncingDot({required this.animation, required this.delay});
  final Animation<double> animation;
  final double delay;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        // Stagger delay then loop a sine bounce: 0..0.5 rise (-4px), 0.5..1 fall.
        final t = (animation.value + delay) % 1.0;
        final double dy;
        final double op;
        if (t < 0.5) {
          dy = -4.0 * (t * 2);
          op = 0.5 + 0.5 * (t * 2);
        } else {
          dy = -4.0 * (1 - (t - 0.5) * 2);
          op = 1.0 - 0.5 * ((t - 0.5) * 2);
        }
        return Transform.translate(
          offset: Offset(0, dy),
          child: Opacity(
            opacity: op,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.midSage,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}
