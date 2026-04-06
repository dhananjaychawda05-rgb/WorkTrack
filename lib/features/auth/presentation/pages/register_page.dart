import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_trace_app/core/constants/app_assets.dart';
import 'package:work_trace_app/core/utils/validators.dart';
import 'package:work_trace_app/core/widgets/common_image_view.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../core/widgets/common_text_field.dart';
import '../../../../core/widgets/common_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
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
                        onPressed: _agreeToTerms ? () {} : null,
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
        ),
      ),
    );
  }
}
