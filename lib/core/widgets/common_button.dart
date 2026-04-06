import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'common_text.dart';

enum CommonButtonType { primary, secondary, inverted, outlined }

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CommonButtonType type;
  final bool isLoading;
  final Widget? icon;
  final bool isIconTrailing;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? customBackgroundColor;
  final Color? customTextColor;
  final TextStyle? customTextStyle;
  final double elevation;

  const CommonButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = CommonButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.isIconTrailing = false,
    this.width,
    this.height = 52.0,
    this.padding,
    this.borderRadius = 100.0, // Fully rounded default like in screenshot
    this.customBackgroundColor,
    this.customTextColor,
    this.customTextStyle,
    this.elevation = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor =
        customBackgroundColor ?? _getBackgroundColor(theme, isDark);
    final contentColor = customTextColor ?? _getTextColor(theme, isDark);
    final borderColor = _getBorderColor(theme, isDark);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: (isLoading || onPressed == null) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: backgroundColor,
          foregroundColor: contentColor,
          disabledBackgroundColor: backgroundColor.withValues(alpha: 0.5),
          disabledForegroundColor: contentColor.withValues(alpha: 0.5),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: type == CommonButtonType.outlined
                ? BorderSide(color: borderColor, width: 1.5)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(contentColor),
                ),
              )
            : _buildContent(contentColor),
      ),
    );
  }

  Widget _buildContent(Color contentColor) {
    final textWidget = CommonText(
      text,
      style:
          customTextStyle ??
          AppTextStyles.labelLarge.copyWith(
            color: contentColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
      align: TextAlign.center,
    );

    if (icon == null) return textWidget;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!isIconTrailing) ...[icon!, const SizedBox(width: 8)],
        textWidget,
        if (isIconTrailing) ...[const SizedBox(width: 8), icon!],
      ],
    );
  }

  Color _getBackgroundColor(ThemeData theme, bool isDark) {
    switch (type) {
      case CommonButtonType.primary:
        return theme.colorScheme.primary;
      case CommonButtonType.secondary:
        return isDark
            ? AppColors.surfaceAlt
            : const Color(0xFFE2E8F0); // Light greyish in light mode
      case CommonButtonType.inverted:
        return isDark ? Colors.white : theme.scaffoldBackgroundColor;
      case CommonButtonType.outlined:
        return AppColors.transparent;
    }
  }

  Color _getTextColor(ThemeData theme, bool isDark) {
    switch (type) {
      case CommonButtonType.primary:
        return isDark ? AppColors.darkBackground : Colors.white;
      case CommonButtonType.secondary:
        return theme.textTheme.bodyLarge?.color ?? (isDark ? Colors.white : Colors.black);
      case CommonButtonType.inverted:
        return isDark ? AppColors.darkBackground : Colors.white;
      case CommonButtonType.outlined:
        return theme.textTheme.bodyLarge?.color ?? (isDark ? Colors.white : Colors.black);
    }
  }

  Color _getBorderColor(ThemeData theme, bool isDark) {
    if (type == CommonButtonType.outlined) {
      return isDark
          ? AppColors.borderLight
          : const Color(0xFFCBD5E1); // Light grey border
    }
    return AppColors.transparent;
  }
}
