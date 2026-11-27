import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Base card used everywhere — produce cards, order cards, stat cards,
/// farmer listing tiles. Built once here so every feature just wraps its
/// own content in this instead of redefining padding/radius/shadow each time.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  // Optional slot for a bottom row — e.g. the quick-contact icon row on a
  // produce/farmer card. Kept separate from `child` so callers don't have
  // to manually add a Divider + spacing every time they want a footer.
  final Widget? footer;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.onTap,
    this.backgroundColor,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.6),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000), // very light shadow — keeps the UI calm
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: footer == null
          ? child
          : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          child,
          const SizedBox(height: 10),
          Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 8),
          footer!,
        ],
      ),
    );

    if (onTap == null) return card;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: card,
    );
  }
}