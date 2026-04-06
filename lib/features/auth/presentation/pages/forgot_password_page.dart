import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_trace_app/core/constants/app_text_styles.dart';
import 'package:work_trace_app/core/utils/validators.dart';
import 'package:work_trace_app/core/widgets/common_button.dart';
import 'package:work_trace_app/core/widgets/common_text_field.dart';
import 'package:work_trace_app/core/widgets/common_text.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () => context.pop(),
        ),
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Work',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: theme.textTheme.headlineSmall?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Trace',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                CommonText(
                  'Reset\nPassword',
                  style: AppTextStyles.displaySmall.copyWith(
                    color: theme.textTheme.displaySmall?.color,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                CommonText(
                  "Enter your email address and we'll\nsend you a link to reset your\npassword.",
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: theme.textTheme.bodyLarge?.color?.withValues(
                      alpha: 0.7,
                    ),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                CommonTextField(
                  headingText: 'WORK EMAIL',
                  hintText: 'Enter your email address',
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: theme.inputDecorationTheme.hintStyle?.color,
                    size: 20,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 32),
                CommonButton(
                  text: 'SEND LINK',
                  type: CommonButtonType.primary,
                  onPressed: () {
                    // TODO: Implement send link logic
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
