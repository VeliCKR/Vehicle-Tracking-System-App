import 'package:flutter/material.dart';
import 'package:flutter_app/Resources/resources.dart';

class CustomisedHomeMaximisedData extends StatefulWidget {
  const CustomisedHomeMaximisedData({super.key, this.title});
  final String? title;

  @override
  CustomisedHomeMaximisedDataState createState() =>
      CustomisedHomeMaximisedDataState();
}

class CustomisedHomeMaximisedDataState
    extends State<CustomisedHomeMaximisedData> {
  @override
  Widget build(BuildContext context) {
    return getMaximisedWidget();
  }

  Widget getMaximisedWidget() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  R.strings.arrivalTime,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: R.strings.fontName,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "00:00",
                    style: TextStyle(
                        color: R.colors.homeGreenColor,
                        fontFamily: R.strings.fontName,
                        fontSize: 38,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      R.strings.date,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: R.strings.fontName,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Yarın",
                      style: TextStyle(
                          color: R.colors.homeRedColor,
                          fontFamily: R.strings.fontName,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      R.strings.truckType,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: R.strings.fontName,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Otomobil",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: R.strings.fontName,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
