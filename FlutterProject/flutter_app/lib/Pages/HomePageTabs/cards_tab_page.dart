import 'package:flutter/material.dart';
import 'package:flutter_app/AppConstants/layout_controller.dart';
import 'package:flutter_app/CustomWidgets/custom_cell.dart';
import 'package:flutter_app/CustomWidgets/custom_progress_bar.dart';
import 'package:flutter_app/CustomWidgets/custom_raised_button.dart';
import 'package:flutter_app/Models/amount_model.dart';
import 'package:flutter_app/Resources/resources.dart';

class CardsTabPage extends StatefulWidget {
  const CardsTabPage({super.key, this.title});
  final String? title;

  @override
  CardsTabPageState createState() => CardsTabPageState();
}

class CardsTabPageState extends State<CardsTabPage> {
  static final List<AmountModel> amountModel = [
    AmountModel(
        amount: "+ \$ 200. 00",
        transactionTypeText: "Bekleyen Tutar",
        amountType: AmountType.green,
        monthText: "Bu Ay"),
    AmountModel(
        amount: "+ \$ 120. 00",
        transactionTypeText: "Vadesi Geçmiş Tutar",
        amountType: AmountType.red,
        monthText: "Geçen ay"),
    AmountModel(
        amount: "+ \$ 120. 00",
        transactionTypeText: "İşlemi Al",
        amountType: AmountType.red,
        monthText: "Şubat 2020"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                  R.colors.startingGradientColor,
                  R.colors.endGradientColor
                ])),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: LayoutController.getHeight(
                (MediaQuery.of(context).size.height - 60),
                minHeight: 740),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                        child: Text(
                          "17-02-2020 - 18-05-2024",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: R.strings.fontName,
                              fontSize: 18),
                        )),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                R.strings.amount,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: R.strings.fontName,
                                    fontSize: 18),
                              ),
                              Text(
                                "\$ 200. 00",
                                style: TextStyle(
                                    color: R.colors.homeGreenColor,
                                    fontFamily: R.strings.fontName,
                                    fontSize: 18),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                R.strings.fine,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: R.strings.fontName,
                                    fontSize: 18),
                              ),
                              Text(
                                "\$ 450. 00",
                                style: TextStyle(
                                    color: R.colors.homeRedColor,
                                    fontFamily: R.strings.fontName,
                                    fontSize: 18),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: const CustomProgressBar(200, 450)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                              R.strings.pendingAmount,
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
                      Container(
                        margin: const EdgeInsets.fromLTRB(25, 20, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "2020 - 2024",
                              style: TextStyle(
                                  color: R.colors.textHintColor,
                                  fontFamily: R.strings.fontName,
                                  fontSize: 18),
                            ),
                            Text(
                              "- \$ 992. 50",
                              style: TextStyle(
                                  color: R.colors.textHintColor,
                                  fontFamily: R.strings.fontName,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height >= 740
                            ? MediaQuery.of(context).size.height - 480
                            : 310,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: amountModel.length,
                          itemBuilder: (context, index) {
                            return CustomCell(amountModel[index]);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 18.0, 0, 30),
                          child: ButtonTheme(
                            height: 50,
                            minWidth: MediaQuery.of(context).size.width - 40,
                            child: CustomRaisedButton(
                              text: R.strings.payNow,
                              color: R.colors
                                  .splashScreenViewPagerSelectedIndicatorColor,
                              onPressed: () {},
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
