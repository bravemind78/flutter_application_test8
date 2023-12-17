import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required IconData prefix,
  required String label,
  double radius = 10,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  Function? validate,
  Function? suffixPressed,
  bool isPassword = false,
  IconData? suffix,
  String hintText = "Enter your name",
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (value) {
        if (onSubmit != null) {
          onSubmit(value);
        }
      },
      onChanged: (value) {
        if (onChange != null) {
          onChange(value);
        }
      },
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      validator: (value) {
        return validate != null ? validate(value) : null;
        //return null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    suffixPressed!();
                  },
                  icon: Icon(suffix),
                )
              : null,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius))),
    );
