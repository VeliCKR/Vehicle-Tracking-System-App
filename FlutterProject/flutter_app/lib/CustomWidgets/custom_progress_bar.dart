import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Resources/resources.dart';

class CustomProgressBar extends StatefulWidget {
  const CustomProgressBar(this.greenValue, this.redValue, {super.key});
  final double greenValue;
  final double redValue;
  @override
  CustomProgressBarState createState() => CustomProgressBarState();
}

class CustomProgressBarState extends State<CustomProgressBar> {
  @override
  Widget build(BuildContext context) {
    return getCustomProgressWidget(widget.greenValue, widget.redValue);
  }

  Widget getCustomProgressWidget(double greenValue, double redValue) {
    double maxwidth = MediaQuery.of(context).size.width - 40;
    double greenValuePercentage = 100 * (greenValue / (greenValue + redValue));
    if (kDebugMode) {
      print(greenValuePercentage);
    }
    double greenValueWidth = ((maxwidth * greenValuePercentage) / 100);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(2.5)),
                color: R.colors.homeRedColor,
              ),
              width: maxwidth,
            ),
            Container(
              height: 5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(2.5)),
                color: R.colors.homeGreenColor,
              ),
              width: greenValueWidth,
            ),
          ],
        ),
      ],
    );
  }
}
