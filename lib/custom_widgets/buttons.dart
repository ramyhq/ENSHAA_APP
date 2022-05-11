import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final Color bgColor;

  const Button1(
      {Key? key,required this.text,
        required this.onPressed,
        required this.textColor,
        required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: bgColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
          ), ),
        onPressed:onPressed,
        child: Text(text, style: TextStyle(
            color:textColor,
            fontSize: 24
        ),
        ),
      ),
    );
  }
}
