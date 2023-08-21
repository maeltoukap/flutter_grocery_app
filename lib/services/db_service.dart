import 'dart:convert';
import 'dart:io';

import 'package:grocery_app/models/api_response_model.dart';
import 'package:grocery_app/models/user_model.dart';
import 'package:grocery_app/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class DBService {
  static Map<String, String> doHeaders() {
    return {
      'Content-Type': 'application/json',
      'x-custom-lang': 'fr',
    };
  }

  static Map<String, String> doAuthHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'x-custom-lang': 'fr',
      'Authorization': 'Bearer $token',
    };
  }

  Future<APIResponse> getDataBaseOnUData({
    required Map<String, String> data,
    required String uri,
  }) async {
    try {
      final request = http.Request('POST', Uri.parse(uri));
      request.body = json.encode(data);
      request.headers.addAll(doHeaders());

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      if (response.statusCode == 201 || response.statusCode == 200) {
        UserModel user = UserModel.fromJson(data);
        user.token = responseData["data"]["token"];
        // _userRepository.saveUserData(user);
        return APIResponse(error: false, data: responseData);
      } else {
        return APIResponse(
          error: true,
          data: responseData,
          errorMessage: responseData["error"]["message"],
          statusCode: response.statusCode,
        );
      }
    } on SocketException catch (_) {
      return APIResponse(
        error: true,
        data: {'message': 'Connexion internet instable'},
        errorMessage: 'Connexion internet instable',
      );
    } catch (e) {
      return APIResponse(
        error: true,
        data: {'message': 'Une erreur s\'est produite, veuillez réessayer'},
        errorMessage: 'Une erreur s\'est produite',
      );
    }
  }

  static Future<APIResponse> getData({
    required String uri,
    required String token,
  }) async {
    try {
      final request = http.Request('GET', Uri.parse(uri));
      request.headers.addAll(doAuthHeaders(token));

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      if (response.statusCode == 200) {
        return APIResponse(error: false, data: responseData);
      } else {
        print(responseData);
        return APIResponse(
          error: true,
          data: responseData,
          errorMessage: responseData["error"]["message"],
          statusCode: response.statusCode,
        );
      }
    } on SocketException catch (_) {
      return APIResponse(
        error: true,
        data: {'message': 'Connexion internet instable'},
        errorMessage: 'Connexion internet instable',
      );
    } catch (e) {
      return APIResponse(
        error: true,
        data: {'message': 'Connexion internet instable'},
        errorMessage: 'Une erreur s\'est produite: $e',
      );
    }
  }
}
