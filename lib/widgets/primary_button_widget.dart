import 'package:flutter/material.dart';
import 'package:grocery_app/ressources/app_colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String buttonLabel;
  final Function() onTap;
  const PrimaryButtonWidget({super.key, required this.buttonLabel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          color: AppColors.primary,
        ),
        child: Text(
          buttonLabel,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ), //TODO: change this style
        ),
      ),
    );
  }
}
