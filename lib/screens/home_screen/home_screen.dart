import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:grocery_app/generated/assets.dart';
import 'package:grocery_app/models/api_response_model.dart';
import 'package:grocery_app/models/category_model.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/repositories/category_repository.dart';
import 'package:grocery_app/repositories/product_repository.dart';
import 'package:grocery_app/ressources/app_colors.dart';
import 'package:grocery_app/ressources/constants.dart';
import 'package:grocery_app/screens/categories_screen/categories_screen.dart';
import 'package:grocery_app/widgets/alert_dialog_operation_success_failed.dart';
import 'package:grocery_app/widgets/category_card_widget.dart';
import 'package:grocery_app/widgets/product_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productsList = [];

  bool _isLoading = false;

  Future getCategories() async {
    setState(() {
      _isLoading = true;
    });
    APIResponse categoriesResponse = await CategoryRepository.getCategories();
    APIResponse productsResponse = await ProductRepository.getProducts();

    if (!categoriesResponse.error && !productsResponse.error) {
      print(categoriesResponse.data);
      if (categoriesList.isEmpty) {
        if (categoriesResponse.error == false &&
            categoriesResponse.data != null) {
          List<CategoryModel> category =
              (categoriesResponse.data["data"] as List<dynamic>)
                  .map((i) => CategoryModel.fromJson(i as Map<String, dynamic>))
                  .toList();

          categoriesList = category;
          print(category);
        }
      }
      if (productsList.isEmpty) {
        if (productsResponse.error == false && productsResponse.data != null) {
          List<ProductModel> product =
              (productsResponse.data["data"] as List<dynamic>)
                  .map((i) => ProductModel.fromJson(i as Map<String, dynamic>))
                  .toList();

          productsList = product;
          print(product);
        }
      }

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialogOperationFailed(
              message: "Could not get categories or products",
            );
          });
    }
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(categoriesList);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Good Morning", //TODO: change this style
              style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8.0),
            Text(
              "Rafatul Islam", //TODO: change this style
              style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              FontAwesomeIcons.solidBell,
              color: AppColors.dark,
            ),
          )
        ],
      ),
      body: !_isLoading
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ), //TODO: change this style
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(Constants.createRoute(
                                route: CategoriesScreen(
                                    categoriesList: categoriesList)));
                            // Get.to(CategoriesScreen(categoriesList: categoriesList));
                          },
                          child: Icon(
                            FontAwesomeIcons.arrowRight,
                            size: 30.0,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15.0),
                    SizedBox(
                      height: 50.0,
                      child: ListView.builder(
                          itemCount: categoriesList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return CategoryCardWidget(
                              categoryName: categoriesList[index].name!,
                            );
                          }),
                    ),
                    SizedBox(height: 18.0),
                    Text(
                      "Latest Products",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          shrinkWrap: true,
                          children: List.generate(
                            productsList.length,
                            (index) => ProductCardWidget(
                              categoryImage: Assets.orangePng,
                              productModel: productsList[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              color: Colors.transparent,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
