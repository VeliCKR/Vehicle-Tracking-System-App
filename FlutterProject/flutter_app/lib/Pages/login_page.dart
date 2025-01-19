import 'package:flutter/material.dart';
import 'package:flutter_app/Resources/resources.dart';
import 'package:flutter_app/CustomWidgets/custom_raised_button.dart';
import 'package:flutter_app/CustomWidgets/custom_text_field.dart';
import 'package:flutter_app/Pages/verification_success_page.dart';
import 'package:flutter_app/Pages/database.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.title});
  final String? title;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30.0, 0, 0),
                    child: Text(
                      R.strings.welcomeTextLogin,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: R.strings.fontName,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15.0, 0, 0),
                    child: Text(
                      R.strings.welcomeDescriptionLogin,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: R.strings.fontName,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
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
                                text: R.strings.logIn,
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
                                              'Lütfen kullanıcı adı ve e-posta girin.'),
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
                                    bool isValidUser =
                                    await _databaseHelper.validateUser(
                                        _username, _email);

                                    if (isValidUser) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const VerificationSuccessPage(),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Hata'),
                                            content: const Text(
                                                'Geçersiz kullanıcı adı veya e-posta!'),
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
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
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
