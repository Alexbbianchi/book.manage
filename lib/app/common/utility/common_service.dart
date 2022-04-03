import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CommonService {
  static messageError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: Colors.red,
    ));
  }

  static messageSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: Constants.myGrey,
    ));
  }

  static String formattedDate(DateTime? date) {
    if (date == null) {
      return '';
    }

    return DateFormat('dd/MM/yyyy').format(date);
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Future<bool> validationConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
