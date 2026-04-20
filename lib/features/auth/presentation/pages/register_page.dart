import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:work_trace_app/core/constants/app_assets.dart';
import 'package:work_trace_app/core/utils/validators.dart';
import 'package:work_trace_app/core/widgets/common_image_view.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../core/widgets/common_text_field.dart';
import '../../../../core/widgets/common_text.dart';
import '../../../../injection/injection.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterBloc>(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.status == RegisterStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CommonText(state.successMessage ?? 'Signup successful'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.pop(); // Go back to login
            } else if (state.status == RegisterStatus.failure &&
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
                    const SizedBox(height: 12),

                    // ─── SUBTITLE ────────────────────────────────────────────
                    CommonText(
                      'CREATE YOUR ACCOUNT AND\nSTART YOUR JOURNEY',
                      align: TextAlign.center,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                        letterSpacing: 1.5,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ─── REGISTER CARD ────────────────────────────────────────
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
                            headingText: 'FULL NAME',
                            hintText: 'Enter your full name',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: theme.inputDecorationTheme.hintStyle?.color,
                              size: 20,
                            ),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            validator: Validators.validateFullName,
                            onChanged: (val) => context.read<RegisterBloc>().add(
                                  RegisterFullNameChanged(val),
                                ),
                          ),
                          const SizedBox(height: 24),
                          CommonTextField(
                            headingText: 'EMAIL ADDRESS',
                            hintText: 'Enter your email address',
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color: theme.inputDecorationTheme.hintStyle?.color,
                              size: 20,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: Validators.validateEmail,
                            onChanged: (val) => context.read<RegisterBloc>().add(
                                  RegisterEmailChanged(val),
                                ),
                          ),
                          const SizedBox(height: 24),
                          CommonTextField(
                            headingText: 'CREATE PASSWORD',
                            hintText: 'Enter your password',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: theme.inputDecorationTheme.hintStyle?.color,
                              size: 20,
                            ),
                            isPassword: true,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            validator: Validators.validatePassword,
                            onChanged: (val) => context.read<RegisterBloc>().add(
                                  RegisterPasswordChanged(val),
                                ),
                          ),
                          const SizedBox(height: 24),

                          // Terms and Conditions View
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _agreeToTerms = !_agreeToTerms;
                                  });
                                },
                                child: Icon(
                                  _agreeToTerms
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: _agreeToTerms
                                      ? theme.colorScheme.primary
                                      : theme.inputDecorationTheme.hintStyle?.color,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      color: theme.textTheme.bodyMedium?.color,
                                    ),
                                    children: [
                                      const TextSpan(text: 'I agree to the '),
                                      TextSpan(
                                        text: 'Terms of Service',
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          color: theme.colorScheme.primary,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      const TextSpan(text: ' and\n'),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          color: theme.colorScheme.primary,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      const TextSpan(text: '.'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Sign Up Button
                          CommonButton(
                            text: 'CREATE ACCOUNT',
                            type: CommonButtonType.primary,
                            isLoading: state.status == RegisterStatus.loading,
                            onPressed: _agreeToTerms
                                ? () {
                                    context.read<RegisterBloc>().add(
                                          const RegisterSubmitted(),
                                        );
                                  }
                                : null,
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
                          "Already have an account? ",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: CommonText(
                            'SIGN IN',
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
}
