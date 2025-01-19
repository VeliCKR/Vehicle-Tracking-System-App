import 'package:flutter/material.dart';
import 'package:flutter_app/AppConstants/layout_controller.dart';
import 'package:flutter_app/CustomWidgets/custom_raised_button.dart';
import 'package:flutter_app/CustomWidgets/custom_text_field.dart';
import 'package:flutter_app/Resources/resources.dart';
import 'package:flutter_app/Pages/get_started_page.dart';  // GetStartedPage import edilmelidir

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  ProfileTabPageState createState() => ProfileTabPageState();
}

class ProfileTabPageState extends State<ProfileTabPage> {
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
                    image: AssetImage('assets/images/marcus.jpg'),
                    fit: BoxFit.cover,
                  )),
            ),
            SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: LayoutController.getHeight(
                    (MediaQuery.of(context).size.height - 60),
                    minHeight: 740),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      decoration: BoxDecoration(
                          color: R.colors.whiteMainColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  R.strings.personalInformation,
                                  style: TextStyle(
                                      color: R.colors.homeTextColor,
                                      fontFamily: R.strings.fontName,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          // TextField widget'larına initialValue ekliyoruz
                          Container(
                              margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                              child: CustomTextField(
                                initialValue: 'Ali Yilmaz',  // Varsayılan değer
                                hintText: R.strings.userName,
                                topHintText: R.strings.userNameTop,
                              )),
                          Container(
                              margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                              child: CustomTextField(
                                initialValue: 'aliyilmaz@gmail.com',  // Varsayılan değer
                                hintText: R.strings.email,
                                topHintText: R.strings.emailTop,
                              )),

                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 18.0, 0, 30),
                              child: ButtonTheme(
                                height: 50,
                                minWidth: MediaQuery.of(context).size.width - 40,
                                child: CustomRaisedButton(
                                  text: R.strings.logOut,
                                  color: R.colors
                                      .splashScreenViewPagerSelectedIndicatorColor,
                                  onPressed: () {
                                    // Çıkış yap butonuna tıklandığında GetStartedPage sayfasına yönlendirme
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const GetStartedPage()),
                                    );
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
        ));
  }
}

