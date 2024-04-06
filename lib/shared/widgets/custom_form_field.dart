import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.hintText,
    this.onEditingComplete,
    this.label,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final Function()? onEditingComplete;
  final bool obscureText;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(label!),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            isDense: false,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          ),
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onEditingComplete: onEditingComplete,
        ),
      ],
    );
  }
}
