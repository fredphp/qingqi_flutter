import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../theme/app_theme.dart';

/// Vertical timeline of processing steps with status icons + connectors.
/// Mirrors src/components/StepList.tsx.
class StepList extends StatelessWidget {
  const StepList({super.key, required this.steps});

  final List<ProcessingStep> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < steps.length; i++) _StepRow(step: steps[i], isLast: i == steps.length - 1),
      ],
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.step, required this.isLast});
  final ProcessingStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final status = step.status;
    // Left column (icon + connector)
    final Widget left = Column(
      children: [
        _StatusIcon(status: status),
        if (!isLast)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4), // my-1
            width: 1,
            constraints: const BoxConstraints(minHeight: 20),
            decoration: BoxDecoration(
              color: status == StepStatus.completed
                  ? AppColors.fromHex('#a6c0ab')
                  : AppColors.fromHex('#e8e2d5'),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
      ],
    );

    final String statusText;
    switch (status) {
      case StepStatus.completed:
        statusText = '已完成';
        break;
      case StepStatus.active:
        statusText = '进行中';
        break;
      case StepStatus.pending:
        statusText = '等待处理';
        break;
    }

    final bool isPending = status == StepStatus.pending;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 24, child: left),
          const SizedBox(width: 14), // gap-3.5
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    step.label,
                    style: AppTheme.sans(
                      size: 13.5,
                      weight: isPending ? FontWeight.w500 : FontWeight.w600,
                      color: isPending
                          ? AppColors.fromHex('#a8b3ab')
                          : AppColors.fromHex('#1b2b22'),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    statusText,
                    style: AppTheme.sans(
                      size: 11,
                      color: AppColors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.status});
  final StepStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StepStatus.completed:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.fromHex('#e4efe7'),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            AppIcons.resolve('CheckCircle2Icon'),
            size: 16,
            color: AppColors.fromHex('#1f4b39'),
          ),
        );
      case StepStatus.active:
        return const _ActiveLoader();
      case StepStatus.pending:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.fromHex('#f1ede1'),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            AppIcons.resolve('CircleDashedIcon'),
            size: 15,
            color: AppColors.fromHex('#a8b3ab'),
          ),
        );
    }
  }
}

/// Slowly rotating loader for active steps.
class _ActiveLoader extends StatefulWidget {
  const _ActiveLoader();

  @override
  State<_ActiveLoader> createState() => _ActiveLoaderState();
}

class _ActiveLoaderState extends State<_ActiveLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.fromHex('#d5e7da'),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: RotationTransition(
        turns: _ctrl,
        child: Icon(
          AppIcons.resolve('LoaderIcon'),
          size: 14,
          color: AppColors.fromHex('#1f4b39'),
        ),
      ),
    );
  }
}
