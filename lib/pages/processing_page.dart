import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';
import '../widgets/progress_ring.dart';
import '../widgets/step_list.dart';

class ProcessingPage extends StatefulWidget {
  const ProcessingPage({super.key});

  @override
  State<ProcessingPage> createState() => _ProcessingPageState();
}

class _ProcessingPageState extends State<ProcessingPage>
    with SingleTickerProviderStateMixin {
  static const Duration _totalDuration = Duration(milliseconds: 3200);

  late final AnimationController _ctrl;
  late final Animation<int> _progressAnim;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: _totalDuration,
    );
    _progressAnim = IntTween(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.linear),
    )..addListener(() => setState(() {}));
    _ctrl.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_navigated) {
        _navigated = true;
        Future.delayed(const Duration(milliseconds: 480), () {
          if (mounted) {
            AppRoutes.goReplace(context, AppRoutes.result);
          }
        });
      }
    });
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  /// Derive step statuses from progress, matching the React logic:
  /// boundaries = round((i+1)/count * 100).
  List<ProcessingStep> _buildSteps(int progress) {
    final count = MockData.processingSteps.length;
    final boundaries = List<int>.generate(
      count,
      (i) => ((i + 1) / count * 100).round(),
    );
    return List<ProcessingStep>.generate(count, (i) {
      final boundary = boundaries[i];
      final prevBoundary = i == 0 ? 0 : boundaries[i - 1];
      StepStatus status;
      if (progress >= boundary) {
        status = StepStatus.completed;
      } else if (progress > prevBoundary) {
        status = StepStatus.active;
      } else {
        status = StepStatus.pending;
      }
      return ProcessingStep(
        id: MockData.processingSteps[i].id,
        label: MockData.processingSteps[i].label,
        status: status,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = _progressAnim.value;
    final isDone = progress >= 100;
    final steps = _buildSteps(progress);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.processing),
        child: SafeArea(
          child: Stack(
            children: [
              // Ambient radial overlays
              Positioned.fill(
                child: CustomPaint(painter: _AmbientGlowPainter()),
              ),
              // Floating particles
              const _FloatingParticles(),
              // Content
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Ring + center icon
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // outer soft glow
                            Container(
                              width: 208,
                              height: 208,
                              decoration: const BoxDecoration(
                                color: Color(0x0DFFFFFF),
                                shape: BoxShape.circle,
                              ),
                            ),
                            ProgressRing(
                              value: progress,
                              size: 160,
                              stroke: 7,
                              child: isDone
                                  ? const Icon(LucideIcons.checkCircle,
                                      size: 38, color: AppColors.goldLight)
                                  : const _PulsingSparkles(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Status text
                      Text(
                        isDone ? '处理完成！' : '$progress%',
                        style: AppTheme.display(
                          size: 26,
                          weight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isDone ? '即将跳转到结果页面…' : 'AI 正在处理您的图片，请稍等',
                        style: AppTheme.sans(
                          size: 13,
                          color: const Color(0xA6FFFFFF),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Progress bar
                      Container(
                        width: 256,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0x1FFFFFFF),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: progress / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: AppGradients.progressFill,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Step list inside glass card
                      Container(
                        width: 320,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0x14FFFFFF),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: const Color(0x1FFFFFFF)),
                        ),
                        child: StepList(steps: steps),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        '请勿关闭页面 · 处理过程约需 3–5 秒',
                        textAlign: TextAlign.center,
                        style: AppTheme.sans(
                          size: 11,
                          color: const Color(0x59FFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pulsing SparklesIcon (gentle opacity/scale pulse).
class _PulsingSparkles extends StatefulWidget {
  const _PulsingSparkles();

  @override
  State<_PulsingSparkles> createState() => _PulsingSparklesState();
}

class _PulsingSparklesState extends State<_PulsingSparkles>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.55, end: 1.0).animate(_ctrl),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.92, end: 1.05).animate(_ctrl),
        child: const Icon(LucideIcons.sparkles,
            size: 34, color: AppColors.goldLight),
      ),
    );
  }
}

/// Four floating particles with staggered ping (pulse) animations.
class _FloatingParticles extends StatefulWidget {
  const _FloatingParticles();

  @override
  State<_FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<_FloatingParticles>
    with TickerProviderStateMixin {
  late final AnimationController _ctrl;

  static const _particles = [
    _Particle(x: 0.15, y: 0.12, size: 6, delay: 0, duration: 3800, opacity: 0.22),
    _Particle(x: 0.82, y: 0.18, size: 4, delay: 600, duration: 4200, opacity: 0.16),
    _Particle(x: 0.68, y: 0.72, size: 7, delay: 1100, duration: 3500, opacity: 0.19),
    _Particle(x: 0.28, y: 0.80, size: 5, delay: 300, duration: 4800, opacity: 0.14),
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        return Stack(
          children: _particles.map((p) {
            return Positioned(
              left: c.maxWidth * p.x - p.size / 2,
              top: c.maxHeight * p.y - p.size / 2,
              child: _PingDot(
                animation: _ctrl,
                particle: p,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _Particle {
  final double x;
  final double y;
  final double size;
  final int delay;
  final int duration;
  final double opacity;
  const _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.delay,
    required this.duration,
    required this.opacity,
  });
}

class _PingDot extends StatelessWidget {
  const _PingDot({required this.animation, required this.particle});
  final Animation<double> animation;
  final _Particle particle;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        // total cycle length = max(duration+delay, 5000)
        final cycleMs = particle.duration + particle.delay;
        final t = ((animation.value * 5000).toInt() % cycleMs) /
            cycleMs.toDouble();
        // delay offset: phase 0..(delay/cycle): invisible
        final delayFrac = particle.delay / cycleMs;
        final active = (t - delayFrac) / (1 - delayFrac).clamp(1e-6, 1.0);
        if (active < 0 || active > 1) return const SizedBox.shrink();
        // ping: scale 1 → 2, opacity full → 0
        final scale = 1.0 + active;
        final op = particle.opacity * (1 - active);
        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: op.clamp(0.0, 1.0),
            child: Container(
              width: particle.size,
              height: particle.size,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AmbientGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // white glow at 50% / 25%
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.25),
      size.width * 0.6,
      Paint()
        ..shader = RadialGradient(
          colors: [const Color(0x0FFFFFFF), Colors.transparent],
        ).createShader(Rect.fromCircle(
            center: Offset(size.width * 0.5, size.height * 0.25),
            radius: size.width * 0.6)),
    );
    // gold glow at 85% / 75%
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.75),
      size.width * 0.55,
      Paint()
        ..shader = RadialGradient(
          colors: [const Color(0x2EC9A96A), Colors.transparent],
        ).createShader(Rect.fromCircle(
            center: Offset(size.width * 0.85, size.height * 0.75),
            radius: size.width * 0.55)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
