import 'package:flutter/material.dart';
import 'package:flutter_app/AppConstants/layout_controller.dart';
import 'package:flutter_app/CustomWidgets/custom_cell.dart';
import 'package:flutter_app/Models/amount_model.dart';
import 'package:flutter_app/Resources/resources.dart';

class HistoryTabPage extends StatefulWidget {
  const HistoryTabPage({super.key, this.title});
  final String? title;

  @override
  HistoryTabPageState createState() => HistoryTabPageState();
}

class HistoryTabPageState extends State<HistoryTabPage> {
  static final List<AmountModel> amountModel = [
    AmountModel(
        amount: "+ \$ 200. 00",
        transactionTypeText: "Bekleyen Tutar",
        amountType: AmountType.green,
        monthText: "Bu Ay"),
    AmountModel(
        amount: "+ \$ 120. 00",
        transactionTypeText: "Vadesi Geçmiş Tutar",
        amountType: AmountType.green,
        monthText: "Geçen ay"),
    AmountModel(
        amount: "+ \$ 120. 00",
        transactionTypeText: "İşlemi Al",
        amountType: AmountType.green,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                          child: Text(
                            R.strings.myHistory,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: R.strings.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 19),
                          )),
                    ],
                  ),
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
                              R.strings.transactionHistory,
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
                            ? MediaQuery.of(context).size.height - 260
                            : 540,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: amountModel.length,
                          itemBuilder: (context, index) {
                            return CustomCell(amountModel[index]);
                          },
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
