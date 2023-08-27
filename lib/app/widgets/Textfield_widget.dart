import 'package:flutter/material.dart';

import '../constants/text_styles.dart';
import '../constants/themes.dart';
// import 'package:google_fonts/google_fonts.dart';

class Textfield_widget extends StatelessWidget {
  final String? hint;
  final String? errorText;
  final Widget? sufiixIcon;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final bool isObscure;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  void Function()? onTap;
  final TextInputAction? inputAction;
  bool? isReadonly;
  final bool? isEnabled;
  final bool? isOutlineBorder;
  final double? cursorwidth;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled ?? true,
      readOnly: isReadonly ?? false,
      controller: textController,
      validator: validator,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      autofocus: autoFocus,
      textInputAction: inputAction,
      obscureText: this.isObscure,
      onTap: onTap,
      keyboardType: this.inputType,
      style:TextStyles(context).getRegularStyle().copyWith(letterSpacing: 1.0,decorationThickness: 0),
    cursorWidth:cursorwidth ?? 2,
      decoration: InputDecoration(
        suffixIcon: sufiixIcon,
        prefixIcon: prefixIcon,
        
        enabledBorder: isOutlineBorder == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppTheme.subtittleTextColor),
              )
            : InputBorder.none,
        border: isOutlineBorder == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppTheme.subtittleTextColor),
              )
            : InputBorder.none,
        focusedBorder: isOutlineBorder == true
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppTheme.subtittleTextColor),
              )
            : InputBorder.none,
        hintText: hint ?? 'Your Location',
        hintStyle: TextStyle(
            color: Theme.of(context).disabledColor,
            fontSize: 15,
            fontWeight: FontWeight.bold),
        errorText: errorText,
        counterText: '',
    
      ),
    );
  }

  Textfield_widget(
      {Key? key,
      this.sufiixIcon,
     required this.isOutlineBorder,
     
      this.prefixIcon,
      this.errorText,
      this.textController,
      required this.validator,
      this.inputType,
      required this.hint,
      this.isObscure = false,
      this.onTap,
      this.padding = const EdgeInsets.all(0),
      this.hintColor = Colors.grey,
      this.iconColor = Colors.grey,
      this.focusNode,
      this.onFieldSubmitted,
      this.onChanged,
      this.autoFocus = false,
      this.inputAction,
      this.isEnabled,
      this.isReadonly,
      this.cursorwidth
      })
      : super(key: key);
}
