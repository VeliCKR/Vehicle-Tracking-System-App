import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/AppConstants/layout_controller.dart';
import 'package:flutter_app/Blocks/automated_view_pager_bloc.dart';
import 'package:flutter_app/Pages/main_home_tab_page.dart';
import 'package:flutter_app/Resources/resources.dart';
import 'package:image_fade/image_fade.dart';

class VerificationSuccessPage extends StatefulWidget {
  const VerificationSuccessPage({super.key, this.title});
  final String? title;

  @override
  VerificationSuccessPageState createState() => VerificationSuccessPageState();
}

class VerificationSuccessPageState extends State<VerificationSuccessPage> {
  final _automatedViewPagerBlock = AutomatedViewPagerBloc();

  @override
  Widget build(BuildContext context) {
    _automatedViewPagerBlock.add(AutomatedViewPagerBlocEvent.start);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Image(
              image: AssetImage('assets/images/background_one.png'),
              fit: BoxFit.fill,
            )),
        SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height:
                LayoutController.getHeight(MediaQuery.of(context).size.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: SizedBox(
                        height: 200,
                        child: ImageFade(
                          image: AssetImage(
                              'assets/images/verification_success.png'),
                          duration: Duration(milliseconds: 2000),
                          curve: Curves.easeInBack,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40.0, 0, 100),
                      child: Text(
                        R.strings.verificationSuccess.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: R.strings.fontName,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }

  void startHomeTab() async {
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainHomeTabPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    startHomeTab();
  }
}
