import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// A modern, clean expansion tile for accordions.
/// Used for displaying course modules with expandable lesson lists.
/// Features smooth animations and subtle styling without harsh borders.
class ModernExpansionTile extends StatefulWidget {
  const ModernExpansionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.children = const [],
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.leading,
    this.collapsedBackgroundColor,
    this.expandedBackgroundColor,
    this.tilePadding,
    this.childrenPadding,
  });

  /// Main title of the tile
  final String title;

  /// Optional subtitle below the title
  final String? subtitle;

  /// Optional trailing widget (e.g., duration, checkmark)
  final Widget? trailing;

  /// Optional leading widget (e.g., module number, icon)
  final Widget? leading;

  /// Child widgets shown when expanded
  final List<Widget> children;

  /// Whether the tile starts expanded
  final bool initiallyExpanded;

  /// Callback when expansion state changes
  final ValueChanged<bool>? onExpansionChanged;

  /// Background color when collapsed
  final Color? collapsedBackgroundColor;

  /// Background color when expanded
  final Color? expandedBackgroundColor;

  /// Padding for the tile header
  final EdgeInsetsGeometry? tilePadding;

  /// Padding around the children
  final EdgeInsetsGeometry? childrenPadding;

  @override
  State<ModernExpansionTile> createState() => _ModernExpansionTileState();
}

class _ModernExpansionTileState extends State<ModernExpansionTile>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  static const Duration _kExpandDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(duration: _kExpandDuration, vsync: this);
    _iconTurns = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      widget.onExpansionChanged?.call(_isExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          decoration: BoxDecoration(
            color: _isExpanded
                ? (widget.expandedBackgroundColor ?? AppColors.surface)
                : (widget.collapsedBackgroundColor ?? AppColors.surface),
            borderRadius: BorderRadius.circular(AppRadius.medium),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              InkWell(
                onTap: _handleTap,
                borderRadius: BorderRadius.circular(AppRadius.medium),
                child: Padding(
                  padding:
                      widget.tilePadding ?? const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      // Leading
                      if (widget.leading != null) ...[
                        widget.leading!,
                        const SizedBox(width: AppSpacing.sm),
                      ],

                      // Title & Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (widget.subtitle != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                widget.subtitle!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Trailing or Expand Icon
                      if (widget.trailing != null)
                        widget.trailing!
                      else
                        RotationTransition(
                          turns: _iconTurns,
                          child: const Icon(
                            Icons.expand_more_rounded,
                            color: AppColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Expandable Children
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _heightFactor.value,
                  child: Column(
                    children: [
                      if (widget.children.isNotEmpty)
                        const Divider(height: 1, color: AppColors.border),
                      Padding(
                        padding: widget.childrenPadding ?? EdgeInsets.zero,
                        child: Column(children: widget.children),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
