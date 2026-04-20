import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/common_text.dart';
import '../widgets/log_item_card.dart';
import '../widgets/metric_card.dart';
import '../widgets/session_timer_section.dart';
import '../widgets/summary_card.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.darkSurface,
                    child: Icon(Icons.person, color: AppColors.textSecondary),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: CommonText(
                      'Good morning, Alex',
                      style: TextStyle(
                        fontFamily: 'Inter', // Assuming Inter based on screenshots
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Timer Section
              const Center(child: SessionTimerSection()),

              const SizedBox(height: 48),

              // Summary
              const SummaryCard(),

              const SizedBox(height: 16),

              // Metrics Grid
              const Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      title: 'SESSIONS',
                      value: '2',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: MetricCard(
                      title: 'AVG BREAK',
                      value: '45m',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      title: 'FIRST IN',
                      value: '9:00 AM',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: MetricCard(
                      title: 'LAST OUT',
                      value: 'LIVE',
                      valueColor: AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Static Activity Timeline
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CommonText(
                          'Activity Timeline',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        CommonText(
                          'May 24, 2024',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Mock Timeline Bars
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.primary, width: 2),
                            ),
                          ),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const Expanded(flex: 2, child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Today's Log Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CommonText(
                    "Today's Log",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const CommonText(
                      'VIEW DETAILS >',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Logs
              const LogItemCard(
                icon: Icons.check_circle_outline,
                timeRange: '9:00 AM -> 1:00 PM',
                label: 'Morning Deep Work',
                duration: '4h 00m',
              ),
              const LogItemCard(
                icon: Icons.sync,
                timeRange: '2:00 PM -> Current',
                label: 'Afternoon Session',
                duration: '2h 15m',
                isActive: true,
                durationColor: AppColors.primary,
              ),

              const SizedBox(height: 32), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
