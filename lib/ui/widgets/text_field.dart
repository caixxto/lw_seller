import 'package:flutter/material.dart';
import 'package:lw_seller/constants.dart';

class SellerTextField extends StatelessWidget {
  final void Function(String) onChanged;
  SellerTextField({Key? key, required this.width, required this.controller, required this.onChanged}) : super(key: key);
  final double width;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _formKey,
      width: width,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        autovalidateMode: AutovalidateMode.always,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return '*';
          }
          return null;
        },
        textAlign: TextAlign.center,
        obscureText: false,
        style: WHITE_TEXT_STYLE,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.orange,
                width: 1.5
              )
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: Colors.black12,
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 8)
        ),
      ),
    );
  }
}
