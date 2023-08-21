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
      request.headers.addAll(doAuthHeaders("eyJhbGciOiJQUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyMGY3OWEzZC04NmQ4LTQ3NjEtYjc5ZS1hMzEyOWU0OGIwYTUiLCJuYmYiOjE2OTI2NTU0NjN9.U80vFMfhdO2lXVQ6eGmqQSPmuaDshmbY_MvN4LUZTm_UOzJ97PL3XzNK80xy1JDc4VNAVJzS89_ME0qVh8fRu7OlxGa_SMzLrxM2wVPfb1I67YsYVDx5sgFehX6kRY-azSA_DFGZVO0CY0LnxX_2TWYKp5W58sPBMgH9C2q-vYITOT7Wk6fHIBg1zJGIzagayPS1z9Hfa6n5wUkBQMAq-efDQhLI4-5UuY-e_mlx-DgGlA7dLhIUZ9rlCEglKKouIuEdQYB3LSyoAtc138MN4PWbKNdoc-duwxBHTgy4HSzB8Av6oBDqsrijiuBk5XJd9-XCDKh2TVsI2Oxmgb2MEA"));

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
