import 'package:flutter/material.dart';
import 'package:flutter_app/Resources/resources.dart';

class CustomRaisedButton extends StatefulWidget {
  const CustomRaisedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color,
      this.borderColor,
      this.textColor});
  final void Function() onPressed;
  final String text;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;

  @override
  CustomRaisedButtonState createState() => CustomRaisedButtonState();
}

class CustomRaisedButtonState extends State<CustomRaisedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed();
        },
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: widget.borderColor ?? Colors.transparent),
          )),
          textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(
            color: Colors.white,
          )),
          backgroundColor: WidgetStateProperty.all<Color>(
              (widget.color ?? R.colors.loginButtonColor)),
        ),
        child: Text(widget.text,
            style: TextStyle(
                fontSize: 16,
                fontFamily: R.strings.fontName,
                fontWeight: FontWeight.w400,
                color: (widget.textColor ?? Colors.white))),
      ),
    );
  }
}
