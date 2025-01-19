import 'package:flutter/material.dart';
import 'package:flutter_app/Resources/resources.dart';
import 'package:flutter_app/CustomWidgets/custom_text_field.dart';
import 'package:flutter_app/CustomWidgets/custom_raised_button.dart';
import 'package:flutter_app/Pages/login_page.dart';
import 'package:flutter_app/Pages/database.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  GetStartedPageState createState() => GetStartedPageState();
}

class GetStartedPageState extends State<GetStartedPage> {
  String _username = '';
  String _email = '';

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: const Image(
                  image: AssetImage('assets/images/background_one.png'),
                  fit: BoxFit.fill,
                )),
          ),
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 820,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 50, 0, 0),
                    child: SizedBox(
                      height: 52,
                      child: Image(
                        image: AssetImage('assets/images/car_blue.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30.0, 0, 0),
                        child: Text(
                          R.strings.welcomeText,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: R.strings.fontName,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15.0, 50, 0),
                        child: Text(
                          R.strings.welcomDescription,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: R.strings.fontName,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    decoration: BoxDecoration(
                      color: R.colors.whiteMainColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                          child: CustomTextField(
                            hintText: R.strings.userName,
                            topHintText: R.strings.userNameTop,
                            onChanged: (text) {
                              setState(() {
                                _username = text;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                          child: CustomTextField(
                            hintText: R.strings.email,
                            topHintText: R.strings.emailTop,
                            onChanged: (text) {
                              setState(() {
                                _email = text;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 18.0, 0, 30),
                            child: ButtonTheme(
                              height: 50,
                              minWidth: MediaQuery.of(context).size.width - 40,
                              child: CustomRaisedButton(
                                text: R.strings.getStarted,
                                color: R.colors
                                    .splashScreenViewPagerSelectedIndicatorColor,
                                onPressed: () async {
                                  if (_username.isEmpty || _email.isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Hata'),
                                          content: const Text(
                                              'Lütfen tüm alanları doldurun.'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Tamam'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    await _databaseHelper.insertUser(_username, _email);
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Başarılı'),
                                          content: Text('Kayıt başarılı!'),
                                          actions: <Widget>[

                                          ],
                                        );
                                      },
                                    );

                                    // 2 saniye bekleyip, giriş sayfasına yönlendir
                                    await Future.delayed(Duration(seconds: 2));

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                R.strings.alreadyHaveAnAccount,
                                style: TextStyle(
                                  color: R.colors.textHintColor,
                                  fontFamily: R.strings.fontName,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

                                },
                                child: Text(
                                  R.strings.logIn,
                                  style: TextStyle(
                                    color: R.colors
                                        .splashScreenViewPagerSelectedIndicatorColor,
                                    fontFamily: R.strings.fontName,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
