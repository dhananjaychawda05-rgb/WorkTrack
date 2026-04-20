import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/common_text.dart';

class LogItemCard extends StatelessWidget {
  final IconData icon;
  final String timeRange;
  final String label;
  final String duration;
  final bool isActive;
  final Color? durationColor;

  const LogItemCard({
    super.key,
    required this.icon,
    required this.timeRange,
    required this.label,
    required this.duration,
    this.isActive = false,
    this.durationColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary.withOpacity(0.15) : AppColors.background,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: timeRange.split(' -> ')[0] + ' ',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const TextSpan(
                        text: '→ ',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textHint,
                        ),
                      ),
                      TextSpan(
                        text: timeRange.split(' -> ').length > 1 ? timeRange.split(' -> ')[1] : '',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isActive ? AppColors.primary : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                CommonText(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          // Duration
          CommonText(
            duration,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: durationColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
