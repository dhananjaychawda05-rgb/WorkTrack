import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:work_trace_app/core/constants/app_assets.dart';
import 'package:work_trace_app/core/constants/app_colors.dart';
import 'package:work_trace_app/core/utils/logger.dart';
import 'package:work_trace_app/core/utils/validators.dart';
import 'package:work_trace_app/core/widgets/common_image_view.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../core/widgets/common_text_field.dart';
import '../../../../injection/injection.dart';
import '../../../../routes/route_constants.dart';
import '../../../../core/widgets/common_text.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              context.go(RouteConstants.home);
            } else if (state.status == LoginStatus.failure &&
                state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CommonText(state.errorMessage!),
                  backgroundColor: theme.colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ─── LOGO WITH GLOW ───────────────────────────────────────
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
                    const SizedBox(height: 24),

                    // ─── APP TITLE ───────────────────────────────────────────
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Work',
                            style: AppTextStyles.displayMedium.copyWith(
                              color: theme.textTheme.displayLarge?.color,
                            ),
                          ),
                          TextSpan(
                            text: 'Trace',
                            style: AppTextStyles.displayMedium.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    // ─── LOGIN CARD ──────────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CommonTextField(
                            hintText: 'Email Address',
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color:
                                  theme.inputDecorationTheme.hintStyle?.color,
                              size: 20,
                            ),
                            validator: Validators.validateEmail,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onChanged: (val) => context.read<LoginBloc>().add(
                              LoginEmailChanged(val),
                            ),
                          ),
                          const SizedBox(height: 16),
                          CommonTextField(
                            hintText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color:
                                  theme.inputDecorationTheme.hintStyle?.color,
                              size: 20,
                            ),
                            isPassword: true,
                            onChanged: (val) => context.read<LoginBloc>().add(
                              LoginPasswordChanged(val),
                            ),
                            validator: Validators.validatePassword,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: 16),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                AppLogger.info('Forgot Password');
                                context.push(RouteConstants.forgotPassword);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: CommonText(
                                'FORGOT PASSWORD?',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Sign In Button
                          CommonButton(
                            text: 'SIGN IN',
                            type: CommonButtonType.primary,
                            isLoading: state.status == LoginStatus.loading,
                            onPressed: () {
                              context.read<LoginBloc>().add(
                                const LoginSubmitted(),
                              );
                            },
                          ),
                          const SizedBox(height: 32),

                          // OR CONTINUE WITH divider
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: theme.dividerColor,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: CommonText(
                                  'OR CONTINUE WITH',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: theme.textTheme.bodySmall?.color,
                                    letterSpacing: 0.5,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: theme.dividerColor,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Social Buttons Row
                          Row(
                            children: [
                              Expanded(
                                child: _buildSocialButton(
                                  context: context,
                                  text: 'GOOGLE',
                                  svgAsset: AppAssets.googleIcon,
                                  onPressed: () {
                                    context.read<LoginBloc>().add(
                                      const LoginGoogleSubmitted(),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildSocialButton(
                                  context: context,
                                  text: 'APPLE',
                                  svgAsset: AppAssets.appleLogo,
                                  onPressed: () {
                                    context.read<LoginBloc>().add(
                                      const LoginAppleSubmitted(),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),

                    // ─── FOOTER ──────────────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                          "Don't have an account? ",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.push(RouteConstants.signup);
                          },
                          child: CommonText(
                            'SIGN UP',
                            style: AppTextStyles.labelLarge.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required String text,
    required String svgAsset,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark
            ? AppColors.borderLight
            : theme.scaffoldBackgroundColor,
        foregroundColor: theme.textTheme.bodyLarge?.color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonImageView(imagePath: svgAsset, width: 18, height: 18),
          const SizedBox(width: 8),
          CommonText(
            text,
            style: AppTextStyles.labelLarge.copyWith(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
