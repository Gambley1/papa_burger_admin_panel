// ignore_for_file: avoid_multiple_declarations_per_line, inference_failure_on_untyped_parameter, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:papa_burger_admin_panel/src/config/constants/padding.dart';
import 'package:papa_burger_admin_panel/src/config/constants/radius.dart';
import 'package:papa_burger_admin_panel/src/config/constants/values.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    this.hintText,
    this.textController,
    this.errorText,
    this.onTap,
    this.focusNode,
    this.onChanged,
    this.textInputAction,
    this.obscureText,
    this.autoCorrect,
    this.enabled,
    this.suffixIcon,
    this.prefixIcon,
    this.borderRadius,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.contentPaddingTop,
    this.textInputType,
    this.inputFormatters,
    this.validator,
    this.floatingLabelBehaviour,
    this.labelText,
    this.autofocus,
    this.border,
    this.contentPadding,
    this.fontSize,
    this.initialValue,
    this.decoration,
    this.helperText,
    this.textInputColor,
    this.onFieldSubmitted,
  });

  factory CustomFormField.withoutBorder({
    Key? key,
    String? hintText,
    String? labelText,
    String? errorText,
    String? initialValue,
    String? helperText,
    TextEditingController? textController,
    VoidCallback? onTap,
    FocusNode? focusNode,
    void Function(String)? onChanged,
    TextInputAction? textInputAction,
    bool? obscureText,
    bool? autoCorrect,
    bool? enabled,
    bool? autofocus,
    Widget? suffixIcon,
    Icon? prefixIcon,
    double? fontSize,
    TextInputType? textInputType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    FloatingLabelBehavior? floatingLabelBehaviour,
  }) =>
      CustomFormField(
        key: key,
        contentPadding: const EdgeInsets.only(top: 12),
        textController: textController,
        initialValue: initialValue,
        focusNode: focusNode,
        textInputType: textInputType,
        inputFormatters: inputFormatters,
        onTap: onTap,
        onChanged: onChanged,
        autoCorrect: autoCorrect ?? true,
        textInputAction: textInputAction,
        obscureText: obscureText ?? false,
        validator: validator,
        autofocus: autofocus ?? false,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: floatingLabelBehaviour,
          floatingLabelStyle: GoogleFonts.getFont(
            'Quicksand',
            textStyle: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          helperText: helperText,
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          errorMaxLines: 2,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          iconColor: Colors.grey,
          suffixIconColor: Colors.grey,
          prefixIconColor: Colors.grey,
          enabled: enabled ?? true,
          labelStyle: GoogleFonts.getFont(
            'Quicksand',
            textStyle: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: fontSize ?? 18,
            ),
          ),
          hintStyle: GoogleFonts.getFont(
            'Quicksand',
            textStyle: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          errorStyle: const TextStyle(fontSize: 14),
          contentPadding: const EdgeInsets.only(
            top: topPadding,
          ),
        ),
      );

  final String? hintText, labelText, errorText, initialValue, helperText;
  final TextEditingController? textController;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final bool? obscureText, autoCorrect, enabled, autofocus;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final double? borderRadius, contentPaddingTop, fontSize;
  final InputBorder? focusedBorder, enabledBorder, disabledBorder, border;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final FloatingLabelBehavior? floatingLabelBehaviour;
  final EdgeInsetsGeometry? contentPadding;
  final InputDecoration? decoration;
  final Color? textInputColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      initialValue: initialValue,
      focusNode: focusNode,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      style: defaultTextStyle(
        color: textInputColor ?? Colors.white,
        size: 14,
      ),
      onChanged: onChanged,
      autocorrect: autoCorrect ?? true,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      validator: validator,
      cursorColor: Colors.blue,
      autofocus: autofocus ?? false,
      decoration: decoration ??
          InputDecoration(
            alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: floatingLabelBehaviour,
            floatingLabelStyle: defaultTextStyle(
              size: 18,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
            helperText: helperText,
            labelText: labelText,
            hintText: hintText,
            errorText: errorText,
            enabledBorder: enabledBorder,
            disabledBorder: disabledBorder,
            focusedBorder: focusedBorder,
            errorMaxLines: 2,
            helperStyle: defaultTextStyle(
              color: Colors.white.withOpacity(.6),
              size: 14,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            iconColor: Colors.grey,
            suffixIconColor: Colors.grey,
            prefixIconColor: Colors.grey,
            enabled: enabled ?? true,
            labelStyle: defaultTextStyle(
              size: fontSize ?? 18,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: defaultTextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
            border: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  borderSide: const BorderSide(
                    width: 4,
                    color: Colors.white,
                  ),
                ),
            errorStyle: const TextStyle(fontSize: 14),
            contentPadding: contentPadding ??
                EdgeInsets.only(
                  right: 16,
                  left: 16,
                  top: contentPaddingTop ?? 13,
                ),
          ),
    );
  }
}
