import 'package:flutter/material.dart';

import '../../common/constants/app_styles.dart';

class SuffixIcon {
  final Widget icon;
  final Color? iconColor;
  final BoxConstraints? iconConstraints;

  SuffixIcon({
    required this.icon,
    this.iconColor,
    this.iconConstraints,
  });
}

class CommonTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final bool? enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final AutovalidateMode autovalidateMode;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onFieldSubmitted;
  final int minLines;
  final int maxLines;
  final bool autofocus;
  final SuffixIcon? suffixIcon;

  const CommonTextFormField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.enabled,
    this.readOnly = false,
    this.keyboardType,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.obscureText = false,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.onTap,
    this.onTapOutside,
    this.onFieldSubmitted,
    this.minLines = 1,
    this.maxLines = 1,
    this.autofocus = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      readOnly: readOnly,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      minLines: minLines,
      maxLines: maxLines,
      autofocus: autofocus,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppStyles.mainBorderRadius,
          ),
        ),
        suffixIcon: suffixIcon?.icon,
        suffixIconColor: suffixIcon?.iconColor,
        suffixIconConstraints: suffixIcon?.iconConstraints,
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onFieldSubmitted: onFieldSubmitted,
      autovalidateMode: autovalidateMode,
      validator: validator,
    );
  }
}
