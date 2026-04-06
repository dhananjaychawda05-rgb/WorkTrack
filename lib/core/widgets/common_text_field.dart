import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'common_text.dart';

class CommonTextField extends StatefulWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final String? headingText;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final double borderRadius;
  final bool disablePaste;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final FloatingLabelBehavior? floatingLabelBehavior;

  const CommonTextField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.headingText,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.validator,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.borderRadius = 100.0,
    this.disablePaste = false,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.inputFormatters,
    this.fillColor,
    this.floatingLabelBehavior,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late TextEditingController _controller;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscureText = widget.isPassword;
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.headingText != null) ...[
          CommonText(
            widget.headingText!.toUpperCase(),
            style: AppTextStyles.labelLarge.copyWith(
              color: theme.textTheme.labelLarge?.color,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
        ],
        TextFormField(
          controller: _controller,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          obscureText: _obscureText,
          obscuringCharacter: '*',
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          minLines: widget.minLines,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: [
            ...?widget.inputFormatters,
            if (widget.disablePaste)
              TextInputFormatter.withFunction((oldValue, newValue) {
                // Prevent paste by ignoring differences larger than 1 character
                if ((newValue.text.length - oldValue.text.length) > 1) {
                  return oldValue;
                }
                return newValue;
              }),
          ],
          style: AppTextStyles.bodyLarge.copyWith(
            color: theme.textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            // Uses inputDecorationTheme from AppTheme
            fillColor: widget.fillColor,
            floatingLabelBehavior:
                widget.floatingLabelBehavior ?? FloatingLabelBehavior.never,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),

            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, right: 12),
                    child: widget.prefixIcon,
                  )
                : null,
            prefixIconConstraints: widget.prefixIcon != null
                ? const BoxConstraints(minWidth: 0, minHeight: 0)
                : null,

            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: theme.inputDecorationTheme.hintStyle?.color,
                      size: 20,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  )
                : widget.suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: widget.suffixIcon,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
