import 'package:flutter/material.dart';
import 'package:flutter_app/Resources/resources.dart';

class CustomNumberPad extends StatefulWidget {
  final void Function(String) onButtonClicked;

  const CustomNumberPad({super.key, required this.onButtonClicked});
  @override
  CustomNumberPadState createState() => CustomNumberPadState();
}

class CustomNumberPadState extends State<CustomNumberPad> {
  Widget getTextWidget(String text) {
    return GestureDetector(
      onTap: () {
        widget.onButtonClicked(text);
      },
      child: Container(
        width: 50,
        height: 50,
        color: Colors.white,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: R.colors.splashScreenViewPagerSelectedIndicatorColor,
                fontFamily: R.strings.fontName,
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              getTextWidget("1"),
              getTextWidget("2"),
              getTextWidget("3"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              getTextWidget("4"),
              getTextWidget("5"),
              getTextWidget("6"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              getTextWidget("7"),
              getTextWidget("8"),
              getTextWidget("9"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              getTextWidget(" "),
              getTextWidget("0"),
              getTextWidget("<"),
            ],
          )
        ],
      ),
    );
  }
}
