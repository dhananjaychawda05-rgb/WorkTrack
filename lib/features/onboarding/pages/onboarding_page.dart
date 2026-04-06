import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_trace_app/core/constants/app_assets.dart';
import 'package:work_trace_app/core/utils/local_storage.dart';
import 'package:work_trace_app/core/widgets/common_image_view.dart';
import 'package:work_trace_app/injection/injection.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../routes/route_constants.dart';
import '../../../core/widgets/common_text.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),

              // ─── LOGO WITH GLOW ───────────────────────────────────────────────
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(
                          alpha: 0.15,
                        ),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: CommonImageView(imagePath: AppAssets.appLogo),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // ─── MAIN HEADLINE ──────────────────────────────────────────────
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.displayLarge.copyWith(
                    height: 1.15,
                    color: theme.textTheme.displayLarge?.color,
                  ),
                  children: [
                    const TextSpan(text: 'Track your\n'),
                    TextSpan(
                      text: 'time',
                      style: TextStyle(color: theme.colorScheme.primary),
                    ),
                    const TextSpan(text: ', master\n'),
                    const TextSpan(text: 'your '),
                    TextSpan(
                      text: 'day',
                      style: TextStyle(color: theme.colorScheme.primary),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ─── SUBTITLE ───────────────────────────────────────────────────
              CommonText(
                'Experience precise mechanical\ntime-tracking designed for the\nhigh-performance mind.',
                align: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: theme.textTheme.bodyLarge?.color?.withValues(
                    alpha: 0.7,
                  ),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              // ─── STATS CARDS ────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context: context,
                      icon: Icons.timer_outlined,
                      title: '0.01s',
                      subtitle: 'PRECISION LOG',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      context: context,
                      icon: Icons.insights_rounded,
                      title: 'Live',
                      subtitle: 'DATA STREAM',
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // ─── BUTTON ─────────────────────────────────────────────────────
              CommonButton(
                text: 'GET STARTED',
                type: CommonButtonType.primary,
                height: 60,
                customTextStyle: AppTextStyles.titleMedium.copyWith(
                  color: isDark ? theme.scaffoldBackgroundColor : Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                onPressed: () async {
                  await getIt<LocalStorage>().setHasSeenOnboarding(true);
                  if (context.mounted) {
                    context.go(RouteConstants.login);
                  }
                },
              ),

              const SizedBox(height: 32),

              // ─── FOOTER (TRUSTED BY) ────────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Overlapping Avatars
                  SizedBox(
                    width: 120,
                    height: 32,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _buildAvatar(0, AppAssets.pic01),
                        _buildAvatar(22, AppAssets.pic02),
                        _buildAvatar(44, AppAssets.pic03),
                        Positioned(
                          left: 66,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: theme.cardTheme.color,
                            child: CommonText(
                              '+12K',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Trusted By Text
                  CommonText(
                    'TRUSTED BY BUILDERS\nWORLDWIDE',
                    align: TextAlign.right,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: theme.textTheme.bodySmall?.color,
                      letterSpacing: 0.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: isDark
            ? theme.cardTheme.color?.withValues(alpha: 0.5)
            : theme.cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24),
          const SizedBox(height: 12),
          CommonText(
            title,
            style: AppTextStyles.titleMedium.copyWith(
              color: theme.textTheme.titleMedium?.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          CommonText(
            subtitle,
            style: AppTextStyles.labelSmall.copyWith(
              color: theme.textTheme.bodySmall?.color,
              fontSize: 8,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(double left, String imagePath) {
    return Positioned(
      left: left,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(radius: 16, backgroundImage: AssetImage(imagePath)),
      ),
    );
  }
}
