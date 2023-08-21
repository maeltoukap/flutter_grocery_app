import 'package:flutter/material.dart';
import 'package:grocery_app/models/user_model.dart';

class Constants {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  ///[App URI]
  static const remoteBaseUri = "https://stagingapi.chipchip.social/v1";
  static const loginUri = "https://stagingapi.chipchip.social/v1/users/login";
  static const categoriesUri = "$remoteBaseUri/categories";
  static const products = "$remoteBaseUri/products";
  static const lifePolicySubscriptionUri = "$remoteBaseUri/police";
  static String healthInsurancePackagesUri(String currency) =>
      "$remoteBaseUri/police/packages?currency=$currency";

  static Route createRoute({required Widget route, int duration = 500}) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.linear;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

void fieldVerification({
  required String field,
  bool isPhone = false,
  bool isPass = false,
  String pass = "",
  required Function(bool) errorCallback,
}) {
  if (field.isEmpty) {
    errorCallback(true);
  } else {
    if (isPhone) {
      if (field.length < 9) {
        errorCallback(true);
      } else {
        errorCallback(false);
      }
    }
    if (isPass) {
      if (field.length < 6) {
        errorCallback(true);
      } else {
        errorCallback(false);
      }
    }
  }
}

bool validateEmail(String email) {
  final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$');
  return regex.hasMatch(email);
}

UserModel localUser = UserModel(
  uid: "",
  token: "",
  phone: "",
  country: "",
);
