import 'dart:convert';

import 'package:flutter_social_app/utils/constants_api.dart' as API;
import 'package:http/http.dart' as http;

class NetworkUtils {
  static const BASE_API_URL = 'http://192.168.0.199:8000/api/';

  static Future<dynamic> get(String url) async {
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw ('An error occured (${response.statusCode}): ${response.body}');
    }

    return jsonDecode(response.body);
  }

  /// Returns map containing:
  ///   if success:
  ///     {response : Success}
  ///   otherwiser:
  ///     {response: error, content: ERROR_MSG}
  static Future<Map> resetUserPassword(String email) async {
    final Map data = {
      API.FIELD_EMAIL: email,
    };

    /*
    * StatusCode: 200 -> json: {detail: Password reset e-mail has been sent.}
    * StatusCode: 400 -> json: {email: [Enter a valid email address.]}
    * StatusCode: 400 -> json: {email: [This field is required.]}
    */

    var response = await post(API.PATH_PASSWORD_RESET, data);

    final jsonResponse = jsonDecode(response.body);
    final Map responseData = {};

    if (response.statusCode == 200) {
      responseData[API.FIELD_RESPONSE] = API.SUCCESS;
    } else {
      responseData[API.FIELD_RESPONSE] = API.ERROR;
      responseData[API.FIELD_CONTENT] = jsonResponse[API.FIELD_EMAIL][0];
    }

    return responseData;
  }

  /// Returns user's token if sucessful log in.
  /// Throws error otherwise.
  static Future<String> loginUser(String email, String password) async {
    final Map data = {
      API.FIELD_USERNAME: email,
      API.FIELD_PASSWORD: password,
    };

    /*
    * StatusCode: 200 -> json: {token: 7ba54eba454e640856484c6ea8bf84869650cfc8}
    * StatusCode: 400 -> json: {non_field_errors: [Unable to log in with provided credentials.]}
    */

    var response = await post(API.PATH_LOGIN, data);

    if (response.statusCode >= 400) {
      throw ('loginUser(): An error occured (${response.statusCode}): ${response.body}');
    }

    final jsonResponse = jsonDecode(response.body);

    return jsonResponse[API.FIELD_TOKEN];
  }

  /// Returns map containing:
  ///   if success:
  ///     {response : Success, email: email}
  ///   otherwiser:
  ///     {field: ERROR_MSG}
  static Future<Map> registerUser(
      String email, String username, String password, String password2) async {
    final Map data = {
      API.FIELD_EMAIL: email,
      API.FIELD_USERNAME: username,
      API.FIELD_PASSWORD: password,
      API.FIELD_PASSWORD_2: password2,
    };

    /*
    * StatusCode: 200 -> json: {response: Success, emial: kornel@wp.pl, username: kornel, token: bb0a2edc5044623b93f6653e4188d4e13f36287e} 
    * StatusCode: 200 -> json: {email:    [Enter a valid email address.]} 
    * StatusCode: 200 -> json: {email:    [my user with this email address already exists.]}
    * StatusCode: 200 -> json: {username: [my user with this username already exists.]} 
    * StatusCode: 400 -> json: {password: Password must contain at least 8 characters.}
    * StatusCode: 400 -> json: {password: Password must much} 
    */

    var response = await post(API.PATH_REGISTER, data);

    final jsonResponse = jsonDecode(response.body);
    final Map responseData = {};

    if (jsonResponse[API.FIELD_RESPONSE] == API.SUCCESS) {
      responseData[API.FIELD_RESPONSE] = API.SUCCESS;
      responseData[API.FIELD_EMAIL] = jsonResponse[API.FIELD_EMAIL];
    } else {
      jsonResponse.forEach((k, v) => {
            responseData[k] = v
                .toString()
                .replaceAll(new RegExp(r'[^\s\w]'), '')
                .replaceAll(new RegExp('my user'), 'User')
          });
    }

    return responseData;
  }

  static Future<dynamic> post(String url, Map data) async {
    var body = jsonEncode(data);

    final String fullUrl = API.PATH_BASE_API + url;

    final response = await http.post(
      fullUrl,
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('post(): StatusCode: ${response.statusCode}');
    print('post(): Response.body: ${response.body}');

    return response;

    // if (response.statusCode >= 400) {
    //   // TODO: Think of better approach, after we'll have more POST methods done.
    //   throw ('post(): An error occured (${response.statusCode}): ${response.body}');
    // }

    // final jsonResponse = jsonDecode(response.body);
    // return jsonResponse;
  }
}
