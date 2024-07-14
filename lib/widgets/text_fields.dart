import 'package:flutter/services.dart';

import '../utils/colors.dart';
import 'package:flutter/material.dart';

TextField textField({
  required TextEditingController controller,
  required String placeholder,
  bool isObscure = false,
  bool numOnly = false,
  bool isSearch = false,
  Widget? prefixIcon,
  Widget? suffixIcon,
  Function? onSubmitted,
}) {
  return TextField(
    obscureText: isObscure,
    controller: controller,
    keyboardType: numOnly ? TextInputType.number : TextInputType.text,
    textInputAction: isSearch ? TextInputAction.search : TextInputAction.done,
    onSubmitted: (value) {
      if (isSearch) {
        onSubmitted!(value);
      }
    },
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: placeholder,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: lightGreyColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: lightGreyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: lightGreyColor, width: 1.5),
      ),
    ),
  );
}

TextField textFieldWithLabel(
    {required TextEditingController controller,
    required String placeholder,
    bool isObscure = false,
    bool numOnly = false,
    bool readOnly = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Function? onTap}) {
  return TextField(
    obscureText: isObscure,
    controller: controller,
    onTap: onTap == null
        ? null
        : () {
            onTap();
          },
    keyboardType: numOnly ? TextInputType.number : TextInputType.text,
    inputFormatters: placeholder == 'Phone Number'
        ? [FilteringTextInputFormatter.allow(RegExp(r'\d{1,15}'))]
        : null,
    readOnly: readOnly,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      label: Text(placeholder),
      filled: true,
      fillColor: whiteColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: lightGreyColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: lightGreyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: lightGreyColor, width: 1.5),
      ),
    ),
  );
}
