import 'dart:convert';

class AmountModel {
  String? monthText;
  String? transactionTypeText;
  String? amount;
  AmountType? amountType;

  AmountModel(
      {String? jsonResponse,
      required String this.monthText,
      required String this.transactionTypeText,
      required String this.amount,
      required AmountType this.amountType}) {
    if (jsonResponse != null && jsonResponse.trim() != "") {
      _setData(jsonResponse, this);
      return;
    }
  }

  static AmountModel _setData(String string, AmountModel amountModel) {
    try {
      List<dynamic> list = json.decode(string);
      Map<String, dynamic> data = list[0];
      amountModel.monthText = data["monthText"];
      amountModel.transactionTypeText = data["transactionTypeText"];
      amountModel.amount = data["amount"];
      if (data["amountType"] == "red") {
        amountModel.amountType = AmountType.red;
      } else {
        amountModel.amountType = AmountType.green;
      }
    } catch (_) {}
    return amountModel;
  }
}

enum AmountType { red, green }
