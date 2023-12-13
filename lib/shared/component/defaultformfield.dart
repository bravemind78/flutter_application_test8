import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required IconData prefix,
  required String label,
  String hintText = "Enter your Email",
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  Function? validate,
  Function? suffixPressed,
  bool isPassword = false,
  IconData? suffix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
      validator: (value) {
        return validate!(value);
      },
      onTap: () {
        onTap!();
      },
      decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(
            onPressed: () {
              suffixPressed!();
            },
            icon: Icon(suffix),
          ),
          border: OutlineInputBorder()),
    );
