import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:grocery_app/generated/assets.dart';
import 'package:grocery_app/models/user_model.dart';
import 'package:grocery_app/repositories/user_repository.dart';
import 'package:grocery_app/ressources/app_colors.dart';
import 'package:grocery_app/ressources/constants.dart';
import 'package:grocery_app/screens/home_screen/home_screen.dart';
import 'package:grocery_app/widgets/alert_dialog_operation_success_failed.dart';
import 'package:grocery_app/widgets/input_field_widget.dart';
import 'package:grocery_app/widgets/primary_button_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserRepository _userRepository = UserRepository();
  bool _isErrorOnPhone = false;
  bool _isErrorOnPassword = false;

  bool _isObscurePassword = true;

  String _phone = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                Assets.loginImagePng,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Constants.screenHeight(context) / 2.5,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 40.0),
                      InputField(
                        labelText: "Telephone",
                        icon: Icons.email,
                        keyboardType: TextInputType.phone,
                        value: _phone,
                        iconColor: AppColors.primary,
                        hasBorder: true,
                        isElevated: false,
                        hasErrorOnField: _isErrorOnPhone,
                        hasIcon: false,
                        hasShadow: false,
                        onChanged: (String? value) {
                          _phone = value!;
                        },
                      ),
                      _isErrorOnPhone
                          ? Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                              child: Text(
                                _phone.isEmpty
                                    ? "The phone field could'nt be empty"
                                    : "The phone must be at least 9 caracters",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12.0),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 16.0),
                      InputField(
                        labelText: "Mot de passe",
                        icon: Icons.email,
                        keyboardType: TextInputType.visiblePassword,
                        value: _password,
                        iconColor: AppColors.primary,
                        hasBorder: true,
                        isElevated: false,
                        obscureText: _isObscurePassword,
                        hasErrorOnField: _isErrorOnPassword,
                        hasIcon: false,
                        hasShadow: false,
                        maxLine: 1,
                        hasMaxLine: false,
                        hasSuffix: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscurePassword
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            size: 18.0,
                            color: AppColors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscurePassword = !_isObscurePassword;
                            });
                          },
                        ),
                        onChanged: (String? value) {
                          _password = value!;
                        },
                      ),
                      _isErrorOnPassword
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 16.0),
                              child: Text(
                                _password.isEmpty
                                    ? "The password field could'nt be empty"
                                    : "The password must be at least 6 caracters",
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 12.0),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 40.0),
                      PrimaryButtonWidget(
                        buttonLabel: "SIGN IN",
                        onTap: () async {
                          fieldVerification(
                              field: _phone,
                              isPhone: true,
                              errorCallback: (bool? value) {
                                setState(() {
                                  _isErrorOnPhone = value!;
                                });
                              });
                          fieldVerification(
                              field: _password,
                              isPass: true,
                              errorCallback: (bool? value) {
                                setState(() {
                                  _isErrorOnPassword = value!;
                                });
                              });
                          if (!_isErrorOnPhone && !_isErrorOnPassword) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return Container(
                                  color: Colors.transparent,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            );
                            await _userRepository
                                .loginUser(
                              UserModel(
                                phone: _phone,
                                password: _password.toString(),
                                country: "ETH",
                              ),
                            )
                                .then((response) {
                              print(response.error);
                              if (!response.error) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return Container(
                                      color: Colors.transparent,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                );

                                UserModel user = UserModel(phone: _phone);
                                user.token = response.data["data"]["token"];
                                _userRepository.saveUserData(user);
                                Get.off(() => const HomeScreen());
                              } else {
                                Navigator.of(context).pop();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialogOperationFailed(
                                        message: response.errorMessage!,
                                      );
                                    });
                              }
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AlertDialogOperationFailed(
                                    message: "Check all fields",
                                  );
                                });
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
