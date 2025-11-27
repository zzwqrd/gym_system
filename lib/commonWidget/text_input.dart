import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_styles.dart';

import '../core/utils/ui_extensions/extensions_init.dart';

class AppCustomForm extends StatefulWidget {
  final String? hintText, title, helperText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String? v)? validator;
  final bool isRequired, loading, enabled, withBorder;
  final int? minLines, maxLines;
  final int? maxLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor, borderColor;
  final String? initialValue, errorText;
  final InputBorder? border;
  final FieldType? fieldType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;

  const AppCustomForm({
    super.key,
    this.hintText,
    this.title,
    this.helperText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.isRequired = true,
    this.loading = false,
    this.enabled = true,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.fillColor,
    this.initialValue,
    this.withBorder = true,
    this.border,
    this.fieldType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.autofocus = false,
    this.focusNode,
    this.borderColor,
    this.errorText,
    this.contentPadding,
  });

  AppCustomForm copyWith({
    Key? key,
    String? hintText,
    String? title,
    String? helperText,
    TextEditingController? controller,
    TextInputType? keyboardType,
    String? Function(String? v)? validator,
    bool? isRequired,
    bool? loading,
    bool? enabled,
    int? minLines,
    int? maxLines,
    int? maxLength,
    void Function(String)? onChanged,
    void Function()? onTap,
    void Function(String)? onSubmitted,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Color? fillColor,
    String? initialValue,
    bool? withBorder,
    InputBorder? border,
    FieldType? fieldType,
    TextCapitalization? textCapitalization,
    TextInputAction? textInputAction,
    bool? autofocus,
    FocusNode? focusNode,
    Color? borderColor,
    String? errorText,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return AppCustomForm(
      key: key ?? this.key,
      hintText: hintText ?? this.hintText,
      title: title ?? this.title,
      helperText: helperText ?? this.helperText,
      controller: controller ?? this.controller,
      keyboardType: keyboardType ?? this.keyboardType,
      validator: validator ?? this.validator,
      isRequired: isRequired ?? this.isRequired,
      loading: loading ?? this.loading,
      enabled: enabled ?? this.enabled,
      minLines: minLines ?? this.minLines,
      maxLines: maxLines ?? this.maxLines,
      maxLength: maxLength ?? this.maxLength,
      onChanged: onChanged ?? this.onChanged,
      onTap: onTap ?? this.onTap,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      fillColor: fillColor ?? this.fillColor,
      initialValue: initialValue ?? this.initialValue,
      withBorder: withBorder ?? this.withBorder,
      border: border ?? this.border,
      fieldType: fieldType ?? this.fieldType,
      textCapitalization: textCapitalization ?? this.textCapitalization,
      textInputAction: textInputAction ?? this.textInputAction,
      autofocus: autofocus ?? this.autofocus,
      focusNode: focusNode ?? this.focusNode,
      borderColor: borderColor ?? this.borderColor,
      errorText: errorText ?? this.errorText,
      contentPadding: contentPadding ?? this.contentPadding,
    );
  }

  @override
  State<AppCustomForm> createState() => _AppCustomFormState();
}

class _AppCustomFormState extends State<AppCustomForm> {
  bool showPass = false;
  late FocusNode _focusNode;
  bool hasFocus = false;
  String? _passwordValue;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _passwordValue = widget.initialValue;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() => hasFocus = _focusNode.hasFocus);
  }

  String? Function(String?)? get _defaultValidator {
    if (widget.validator != null) return widget.validator;

    switch (widget.fieldType) {
      case FieldType.email:
        return (v) {
          if (widget.isRequired && v?.isEmpty == true) {
            return "This field is required";
          }
          return v!.isValidEmail() ? null : "Please enter a valid email";
        };

      case FieldType.password:
        return (v) {
          if (v == null || v.isEmpty) {
            return widget.isRequired ? "This field is required" : null;
          }
          if (v.length < 6) {
            return 'Password must be at least 6 characters';
          }
          _passwordValue = v;
          return null;
        };

      case FieldType.confirmPassword:
        return (v) {
          if (v == null || v.isEmpty) {
            return widget.isRequired ? "This field is required" : null;
          }
          if (v != _passwordValue) {
            return 'Passwords do not match';
          }
          return null;
        };

      case FieldType.phone:
        return (v) {
          if (widget.isRequired && v?.isEmpty == true) {
            return "This field is required";
          }
          return v!.isValidPhone() ? null : "Please enter a valid phone number";
        };

      case FieldType.name:
        return (v) {
          if (widget.isRequired && v?.isEmpty == true) {
            return "This field is required";
          }
          if (v != null && v.length < 2) {
            return 'Name must be at least 2 characters';
          }
          return null;
        };

      default:
        return (v) {
          if (widget.isRequired && v?.isEmpty == true) {
            return "This field is required";
          }
          return null;
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveValidator = _defaultValidator ?? widget.validator;
    final effectiveKeyboardType =
        widget.keyboardType ?? widget.fieldType?.keyboardType;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title?.isNotEmpty == true)
          Row(
            children: [
              Text(
                widget.title!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: hasFocus ? theme.primaryColor : theme.hintColor,
                ),
              ),
              if (widget.isRequired)
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Text(
                    '*',
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ),
            ],
          ).paddingOnly(bottom: 8.h),
        TextFormField(
          focusNode: _focusNode,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          readOnly: widget.onTap != null,
          onTap: widget.onTap,
          textCapitalization: widget.textCapitalization,
          obscureText: widget.fieldType == FieldType.password && !showPass,
          controller: widget.controller,
          keyboardType: effectiveKeyboardType,
          validator: effectiveValidator,
          // inputFormatters: [
          //   if (widget.fieldType == FieldType.phone ||
          //       widget.fieldType == FieldType.number)
          //     FilteringTextInputFormatter.digitsOnly,
          //   if (widget.fieldType == FieldType.name)
          //     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
          // ],
          style: theme.textTheme.bodyMedium?.copyWith(
            color: widget.enabled ? null : theme.disabledColor,
          ),
          textInputAction:
              widget.textInputAction ??
              (widget.maxLines == 1
                  ? TextInputAction.done
                  : TextInputAction.newline),
          decoration: InputDecorationExtension(
            InputDecoration(
              hintText: widget.hintText ?? widget.title ?? '',
              helperText: widget.helperText,
              errorText: widget.errorText,
              counterText: '',
              fillColor: widget.fillColor ?? theme.cardColor,
              filled: true,
              prefixIcon: buildPrefixIcon(context),
              suffixIcon: buildSuffixIcon(context),
              contentPadding:
                  widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              border: widget.border ?? _buildBorder(theme),
              enabledBorder: widget.border ?? _buildBorder(theme),
              focusedBorder:
                  widget.border ?? _buildBorder(theme, focused: true),
              errorBorder: widget.border ?? _buildBorder(theme, error: true),
              disabledBorder:
                  widget.border ?? _buildBorder(theme, disabled: true),
              errorMaxLines: 2,
            ),
          ).applyInputDecorationTheme(AppStyles.inputDecorationTheme),
        ),
        // if (widget.errorText != null && widget.errorText!.isNotEmpty)
        //   Padding(
        //     padding: EdgeInsets.only(top: 4.h),
        //     child: Text(
        //       widget.errorText!,
        //       style: theme.textTheme.bodySmall?.copyWith(
        //         color: theme.colorScheme.error,
        //       ),
        //     ),
        //   ).withPadding(top: 4.h),
        // if (widget.helperText != null && widget.helperText!.isNotEmpty)
        //   Padding(
        //     padding: EdgeInsets.only(top: 4.h),
        //     child: Text(
        //       widget.helperText!,
        //       style: theme.textTheme.bodySmall?.copyWith(
        //         color: theme.hintColor,
        //       ),
        //     ),
        //   ).withPadding(top: 4.h),
        // if (widget.isRequired)
        //   Padding(
        //     padding: EdgeInsets.only(top: 4.h),
        //     child: Text(
        //       '* Required',
        //       style: theme.textTheme.bodySmall?.copyWith(
        //         color: theme.colorScheme.error,
        //       ),
        //     ),
        //   ).withPadding(top: 4.h),
        // if (widget.loading)
        //   Padding(
        //     padding: EdgeInsets.only(top: 8.h),
        //     child: Center(
        //       child: CircularProgressIndicator(
        //         strokeWidth: 2,
        //         valueColor: AlwaysStoppedAnimation(theme.primaryColor),
        //       ),
        //     ),
        //   ).withPadding(top: 8.h),
        // if (widget.fieldType == FieldType.password)
        //   Padding(
        //     padding: EdgeInsets.only(top: 8.h),
        //     child: Text(
        //       'Password must be at least 6 characters',
        //       style: theme.textTheme.bodySmall?.copyWith(
        //         color: theme.hintColor,
        //       ),
        //     ),
        //   ).withPadding(top: 8.h),
      ],
    );
  }

  InputBorder _buildBorder(
    ThemeData theme, {
    bool focused = false,
    bool error = false,
    bool disabled = false,
  }) {
    final color = error
        ? theme.colorScheme.error
        : focused
        ? theme.primaryColor
        : disabled
        ? theme.disabledColor
        : widget.borderColor ?? theme.dividerColor;

    if (!widget.withBorder) return InputBorder.none;

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 1.0),
      gapPadding: 0,
    );
  }

  Widget? buildSuffixIcon(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.suffixIcon != null) {
      return widget.suffixIcon!;
    } else if (widget.loading) {
      return Padding(
        padding: EdgeInsets.all(12.w),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(theme.primaryColor),
        ),
      );
    } else if (widget.onTap != null) {
      return Icon(
        Icons.keyboard_arrow_down,
        size: 24,
        color: hasFocus ? theme.primaryColor : theme.hintColor,
      );
    } else if (widget.fieldType == FieldType.password) {
      return IconButton(
        icon: Icon(
          showPass ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
          size: 20,
          color: hasFocus ? theme.primaryColor : theme.hintColor,
        ),
        onPressed: () => setState(() => showPass = !showPass),
      );
    }
    return null;
  }

  Widget? buildPrefixIcon(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = hasFocus ? theme.primaryColor : theme.hintColor;

    if (widget.prefixIcon != null) {
      return Padding(
        padding: EdgeInsets.only(left: 16.w, right: 8.w),
        child: IconTheme(
          data: IconThemeData(color: iconColor),
          child: widget.prefixIcon!,
        ),
      );
    }

    switch (widget.fieldType) {
      case FieldType.email:
        return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 8.w),
          child: Icon(Icons.email_outlined, color: iconColor),
        );
      case FieldType.password:
        return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 8.w),
          child: Icon(Icons.lock_outline, color: iconColor),
        );
      case FieldType.phone:
        return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 8.w),
          child: Icon(Icons.phone, color: iconColor),
        );
      case FieldType.name:
        return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 8.w),
          child: Icon(Icons.person_outline, color: iconColor),
        );
      default:
        return null;
    }
  }
}

enum FieldType {
  email(TextInputType.emailAddress),
  password(TextInputType.visiblePassword),
  confirmPassword(TextInputType.visiblePassword),
  phone(TextInputType.phone),
  number(TextInputType.number),
  name(TextInputType.name),
  text(TextInputType.text);

  final TextInputType keyboardType;
  const FieldType(this.keyboardType);
}

extension StringValidators on String? {
  bool isValidEmail() {
    if (this == null) return false;
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this!);
  }

  bool isValidPhone() {
    if (this == null) return false;
    return RegExp(r'^[0-9]{8,15}$').hasMatch(this!);
  }
}
