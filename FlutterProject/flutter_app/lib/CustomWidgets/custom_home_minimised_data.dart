import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomisedHomeMinimisedData extends StatefulWidget {
  const CustomisedHomeMinimisedData({super.key, this.title});
  final String? title;

  @override
  CustomisedHomeMinimisedDataState createState() =>
      CustomisedHomeMinimisedDataState();
}

class CustomisedHomeMinimisedDataState
    extends State<CustomisedHomeMinimisedData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
    );
  }
}
