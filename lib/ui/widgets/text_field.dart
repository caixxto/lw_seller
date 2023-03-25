import 'package:flutter/material.dart';
import 'package:lw_seller/constants.dart';

class SellerTextField extends StatelessWidget {
  const SellerTextField({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFormField(
        textAlign: TextAlign.center,
        obscureText: false,
        style: WHITE_TEXT_STYLE,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.orange,
                width: 1.5
              )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: Colors.black12,
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(vertical: 8)
        ),
      ),
    );
  }
}
