import 'package:grocery_app/models/api_response_model.dart';
import 'package:grocery_app/ressources/constants.dart';
import 'package:grocery_app/services/db_service.dart';

class ProductRepository {
  static Future<APIResponse> getProducts() async {
    APIResponse response = await DBService.getData(
      token: localUser.token!,
      uri: Constants.products,
    );
    return response;
  }
}
