import 'package:flutter/material.dart';

class CustomFormText extends StatelessWidget {
  final TextEditingController? controller;
  final double? height;
  final double? fontSize;
  final double? radius;
  final EdgeInsetsGeometry? margin;
  final String? hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Function(String)? onChanged;

  const CustomFormText({
    Key? key,
    this.controller,
    this.hintText,
    this.textInputAction,
    this.keyboardType,
    this.obscureText = false,
    this.height,
    this.fontSize,
    this.radius = 14,
    this.margin,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              blurRadius: 3,
              offset: const Offset(1.0, 1.0),
            )
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: TextFormField(
                  onChanged: onChanged,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: textInputAction,
                  keyboardType: keyboardType,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: fontSize,
                    color: const Color(0xFF090909),
                    fontWeight: FontWeight.w400,
                  ),
                  controller: controller,
                  decoration: InputDecoration.collapsed(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      color: Color(0xFF504F5E),
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const Icon(Icons.search_rounded)
          ],
        ),
      ),
    );
  }
}
