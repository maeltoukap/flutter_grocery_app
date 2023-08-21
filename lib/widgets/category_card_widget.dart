import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/generated/assets.dart';
import 'package:grocery_app/ressources/app_colors.dart';

class CategoryCardWidget extends StatelessWidget {
  final String categoryName;
  const CategoryCardWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      margin: EdgeInsets.only(right: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 23.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
        //     spreadRadius: 5, // Étendue de l'ombre
        //     blurRadius: 7, // Flou de l'ombre
        //     offset: Offset(0, 10), // Position de l'ombre (horizontal, vertical)
        //   ),
        // ],
      ),
      child: Center(
        child: Text(
          categoryName,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
      ),
      // child: SvgPicture.asset(
      //   categoryImage,
      //   color: Colors.purple,
      // ),
    );
  }
}
