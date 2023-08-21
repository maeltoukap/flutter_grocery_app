import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/ressources/app_colors.dart';

class CategoryCardComponent extends StatelessWidget {
  final String categoryImage;
  final bool isCategorySelected;
  final String categoryName;
  const CategoryCardComponent(
      {super.key,
      required this.categoryImage,
      required this.isCategorySelected,
      required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138.0,
      width: 138,
      // margin: EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.26),
            offset: Offset(9, 0),
            blurRadius: 19,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            categoryImage,
            color: Colors.red,
          ),
          SizedBox(height: 8.0),
          Text(
            categoryName,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
