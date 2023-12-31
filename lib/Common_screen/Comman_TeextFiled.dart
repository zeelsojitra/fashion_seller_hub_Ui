import 'package:flutter/material.dart';

class Comman_TexxtFiled extends StatelessWidget {
  const Comman_TexxtFiled({
    Key? key,
    this.ontap,
    this.onChanged,
    this.maxLength,
    this.border,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.hinttext,
    this.labletext,
    this.counter,
    this.fillcolor,
    this.prefixicon,
    this.sufficicon,
    this.filled,
    this.validator,
  }) : super(key: key);
  final void Function()? ontap;
  final void Function(String)? onChanged;
  final maxLength;
  final InputBorder? border;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final hinttext;
  final labletext;
  final counter;
  final fillcolor;
  final prefixicon;
  final sufficicon;
  final bool? filled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onTap: ontap,
      keyboardType: keyboardType,
      controller: controller,
      maxLength: maxLength,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        border: border,
        hintText: hinttext,
        labelText: labletext,
        counter: counter,
        filled: filled,
        suffixIcon: sufficicon,
        prefixIcon: prefixicon,
        fillColor: fillcolor,
        counterText: "",
      ),
    );
  }
}
