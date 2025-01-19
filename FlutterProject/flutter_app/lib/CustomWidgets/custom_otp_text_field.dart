import 'package:flutter/material.dart';
import 'package:flutter_app/Blocks/update_otp_bloc.dart';
import 'package:flutter_app/Resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomOtpTextField extends StatefulWidget {
  const CustomOtpTextField({super.key, required this.counterBloc});

  final UpdateOtpBloc counterBloc;

  @override
  CustomOtpTextFieldState createState() => CustomOtpTextFieldState();
}

class CustomOtpTextFieldState extends State<CustomOtpTextField> {
  String otp = "";
  Widget getOneCell({String? string}) {
    return SizedBox(
      width: 30,
      height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            string ?? "•",
            style: TextStyle(
                color: R.colors.whiteMainColor,
                fontFamily: R.strings.fontName,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          Container(
            width: 30,
            height: 2,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BlocBuilder(
          bloc: widget.counterBloc,
          builder: (context, List<String> str) {
            return getOneCell(string: str[0]);
          },
        ),
        BlocBuilder(
          bloc: widget.counterBloc,
          builder: (context, List<String> str) {
            return getOneCell(string: str[1]);
          },
        ),
        BlocBuilder(
          bloc: widget.counterBloc,
          builder: (context, List<String> str) {
            return getOneCell(string: str[2]);
          },
        ),
        BlocBuilder(
          bloc: widget.counterBloc,
          builder: (context, List<String> str) {
            return getOneCell(string: str[3]);
          },
        ),
        BlocBuilder(
          bloc: widget.counterBloc,
          builder: (context, List<String> str) {
            return getOneCell(string: str[4]);
          },
        ),
        BlocBuilder(
          bloc: widget.counterBloc,
          builder: (context, List<String> str) {
            return getOneCell(string: str[5]);
          },
        ),
      ],
    );
  }
}
