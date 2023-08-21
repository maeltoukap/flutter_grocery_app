import 'package:get/route_manager.dart';
import 'package:grocery_app/models/api_response_model.dart';
import 'package:grocery_app/models/user_model.dart';
import 'package:grocery_app/ressources/constants.dart';
import 'package:grocery_app/screens/home_screen/home_screen.dart';
import 'package:grocery_app/services/db_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  DBService _dbService = DBService();
  Future<APIResponse> loginUser(UserModel userModel) async {
    print(userModel.toJson());
    APIResponse response = await _dbService.getDataBaseOnUData(
      data: userModel.toJson(),
      uri: Constants.loginUri,
    );
    return response;
  }

  Future<void> saveUserData(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (userModel.uid != null && userModel.uid!.isNotEmpty) {
      preferences.setString("uid", userModel.uid.toString());
    }
    if (userModel.token != null && userModel.token!.isNotEmpty) {
      preferences.setString("token", userModel.token.toString());
    }
    if (userModel.phone != null && userModel.phone!.isNotEmpty) {
      preferences.setString("phone", userModel.phone.toString());
    }
    if (userModel.country != null && userModel.country!.isNotEmpty) {
      preferences.setString("country", userModel.country.toString());
    }

    preferences.setBool("isLogin", true);
    getUserInfosFromCache();
  }

  Future<void> getUserInfosFromCache({isLogin = false}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    localUser.uid = preferences.getString("uid") ?? "0";
    localUser.token = preferences.getString("token") ?? "abdc";
    localUser.phone = preferences.getString("phone") ?? "email@email.com";
    localUser.country = preferences.getString("country") ?? "customer";
  }

  Future logout() async {
    Get.off(() => const HomeScreen());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    preferences.setBool("isLogin", false);
    localUser = UserModel(
      uid: "",
      token: "",
      phone: "",
      country: "",
      password: "",
    );
  }
}
