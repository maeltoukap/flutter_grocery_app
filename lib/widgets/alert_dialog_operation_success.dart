import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/ressources/app_colors.dart';

class AlertDialogOperationReussie extends StatelessWidget {
  // final bool? isCreated;

  // final dynamic dataPrestataire;
  final String message;
  const AlertDialogOperationReussie({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        // width: 900,
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(
          left: 8,
          right: 5,
          top: 15,
          bottom: 8,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                    color: AppColors.primary, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: 35,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 70,
                child: Text(
                  message,
                  maxLines: 6,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.dark,
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  // width: 150,
                  height: 45,
                  margin: const EdgeInsets.only(left: 40, right: 40),
                  decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(40)),
                  child: const Center(
                    child: Text(
                      "Ok",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
