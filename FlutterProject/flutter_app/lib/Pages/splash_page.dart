import 'package:flutter/material.dart';
import 'package:flutter_app/AppConstants/layout_controller.dart';
import 'package:flutter_app/Blocks/automated_view_pager_bloc.dart';
import 'package:flutter_app/CustomWidgets/custom_raised_button.dart';
import 'package:flutter_app/Pages/get_started_page.dart';
import 'package:flutter_app/Resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, this.title});
  final String? title;

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                      child: SizedBox(
                        height: 200,
                        child: Image(
                          image: AssetImage('assets/images/car_blue.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                      child: Text(
                        R.strings.appName,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: R.strings.fontName,
                            fontSize: 28,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    BlocBuilder(
                      bloc: _automatedViewPagerBlock,
                      builder: (context, int i) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 100.0, 0, 0),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 2000),
                            child: Text(
                              R.strings.splashScreenViewPagerHeader[i]
                                  .toString(),
                              key: Key(i.toString()),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: R.strings.fontName,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder(
                        bloc: _automatedViewPagerBlock,
                        builder: (context, int i) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(30, 25.0, 30, 0),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 2000),
                              child: Text(
                                R.strings.splashScreenViewPagerDescription[i]
                                    .toString(),
                                key: Key(i.toString()),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: R.strings.fontName,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          );
                        }),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(30, 25.0, 30, 0),
                        child: getViewPagerIndicator())
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ButtonTheme(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width - 60,
                        child: CustomRaisedButton(
                          color: R.colors
                              .splashScreenViewPagerSelectedIndicatorColor,
                          text: R.strings.getStarted,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GetStartedPage()),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18.0, 20, 80),
                      child: ButtonTheme(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width - 60,
                        child: CustomRaisedButton(
                          text: R.strings.logIn,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  Widget getViewPagerIndicator() {
    return BlocBuilder(
      bloc: _automatedViewPagerBlock,
      builder: (context, int i) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0.0, 5, 0),
              child: Container(
                width: (i == 0) ? 8 : 5,
                height: (i == 0) ? 8 : 5,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (i == 0)
                        ? R.colors.splashScreenViewPagerSelectedIndicatorColor
                        : R.colors
                            .splashScreenViewPagerUnselectedIndicatorColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0.0, 5, 0),
              child: Container(
                width: (i == 1) ? 8 : 5,
                height: (i == 1) ? 8 : 5,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (i == 1)
                        ? R.colors.splashScreenViewPagerSelectedIndicatorColor
                        : R.colors
                            .splashScreenViewPagerUnselectedIndicatorColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0.0, 5, 0),
              child: Container(
                width: (i == 2) ? 8 : 5,
                height: (i == 2) ? 8 : 5,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (i == 2)
                        ? R.colors.splashScreenViewPagerSelectedIndicatorColor
                        : R.colors
                            .splashScreenViewPagerUnselectedIndicatorColor),
              ),
            )
          ],
        );
      },
    );
  }
}
