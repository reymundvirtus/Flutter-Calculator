import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Buttons extends StatelessWidget {
  final color;
  final onTapColor;
  final textColor;
  final String buttonText;
  final font = GoogleFonts.inter();
  final buttonTapped;

  Buttons({
    Key? key,
    this.color,
    this.onTapColor,
    this.textColor,
    required this.buttonText,
    this.buttonTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
                child: Text(buttonText,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      fontFamily: font.fontFamily,
                    ))),
          ),
        ),
      ),
    );
  }
}
