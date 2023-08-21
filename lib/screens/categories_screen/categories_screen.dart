import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:grocery_app/generated/assets.dart';
import 'package:grocery_app/models/category_model.dart';
import 'package:grocery_app/ressources/app_colors.dart';
import 'package:grocery_app/screens/categories_screen/components/category_card_component.dart';
import 'package:grocery_app/widgets/category_card_widget.dart';
import 'package:grocery_app/widgets/product_card_widget.dart';

class CategoriesScreen extends StatelessWidget {
  final List<CategoryModel> categoriesList;
  const CategoriesScreen({Key? key, required this.categoriesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: AppColors.dark,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 18.0),
          child: Text(
            "Categories",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: AppColors.dark),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                shrinkWrap: true,
                children: List.generate(
                  categoriesList.length,
                  (index) => CategoryCardComponent(
                      categoryImage: Assets.fruits,
                      isCategorySelected: false,
                      categoryName: categoriesList[index].name!),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
