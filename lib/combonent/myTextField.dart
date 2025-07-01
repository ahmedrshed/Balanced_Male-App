import 'package:flutter/material.dart';

Widget myTextField({
  required String hint,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  String? suffix,
}) {
  return TextFormField(
    keyboardType: TextInputType.number,
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      suffix: Text(
        suffix == null ? "" : suffix,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
