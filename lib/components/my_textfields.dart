import 'package:flutter/material.dart';

class MyTextfields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon inputIcon;
  final String? Function(String? text)? validator;

  MyTextfields({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.inputIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(
        style: const TextStyle(color: Color.fromARGB(255, 14, 13, 13)),
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: inputIcon,
            prefixIconColor: const Color.fromARGB(255, 12, 9, 9),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 10, 7, 7),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(color: Color.fromARGB(255, 7, 5, 5))),
      ),
    );
  }
}
