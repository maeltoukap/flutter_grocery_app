import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/ressources/app_colors.dart';

class ProductCardWidget extends StatelessWidget {
  final String categoryImage;
  final ProductModel productModel;
  // final
  const ProductCardWidget(
      {super.key, required this.categoryImage, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      // margin: EdgeInsets.only(right: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            categoryImage,
            // color: Colors.red,
          ),
          Text(
            productModel.name!,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ ${productModel.singleDeal!.originalPrice!}",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.0),
              Text(
                "Add to card",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700),
              )
            ],
          )
        ],
      ),
    );
  }
}
