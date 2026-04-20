import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/common_text.dart';

class SessionTimerSection extends StatelessWidget {
  const SessionTimerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Glowing button
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [
                Color(0xFF2EEDA8), 
                AppColors.primary, 
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer,
                color: AppColors.darkSurface,
                size: 48,
              ),
              SizedBox(height: 8),
              CommonText(
                'CLOCK OUT',
                style: TextStyle(
                  color: AppColors.darkSurface,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        // Session texts
        const CommonText(
          'CURRENT SESSION',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        const CommonText(
          '04:22:15',
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w600,
            color: AppColors.darkTextPrimary,
            letterSpacing: -2.0,
          ),
        ),
      ],
    );
  }
}
