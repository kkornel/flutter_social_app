import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter_social_app/models/comment.dart';
import 'package:flutter_social_app/models/like.dart';
import 'package:flutter_social_app/models/post.dart';
import 'package:flutter_social_app/utils/constants_api.dart' as API;
import 'package:http/http.dart' as http;
import 'package:flutter_social_app/utils/user_account.dart';

class NetworkUtils {
  static Future<dynamic> get(String url) async {
    final String fullUrl = API.PATH_BASE_API + url;

    final Map<String, String> headers = {};

    if (UserAccount.TOKEN != '') {
      headers['Authorization'] = 'Token ' + UserAccount.TOKEN;
    }

    final response = await http.get(fullUrl, headers: headers);

    dev.log('StatusCode: ${response.statusCode}', name: 'get()');
    dev.log('Body: ${response.body}', name: 'get()');

    return response;
  }

  static Future<dynamic> post(String url, Map data) async {
    final body = jsonEncode(data);

    final String fullUrl = API.PATH_BASE_API + url;

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    if (UserAccount.TOKEN != '') {
      headers['Authorization'] = 'Token ' + UserAccount.TOKEN;
    }

    final response = await http.post(
      fullUrl,
      body: body,
      headers: headers,
    );

    dev.log('StatusCode: ${response.statusCode}', name: 'post()');
    dev.log('Body: ${response.body}', name: 'post()');

    return response;

    // if (response.statusCode >= 400) {
    //   // TODO: Think of better approach, after we'll have more POST methods done.
    //   throw ('post(): An error occured (${response.statusCode}): ${response.body}');
    // }

    // final jsonResponse = jsonDecode(response.body);
    // return jsonResponse;
  }

  /// Returns user's profile if sucessful.
  static Future<dynamic> getUserProfile() async {
    /*
    * StatusCode: 200 -> json: {bio: xqcL, city: Toronto, CA, website: www.wpp.pl, image: /media/default.jpg, username: kornel, email: kornel@wp.pl}
    */

    var response = await get(API.PATH_GET_USER_PROFILE);

    final jsonResponse = jsonDecode(response.body);

    UserAccount.PROFILE.printProfile();
    UserAccount.PROFILE.loadFromJson(jsonResponse);
    UserAccount.PROFILE.printProfile();

    return jsonResponse;
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

  static Future<List<Post>> getAllPosts() async {
    /*
    * StatusCode: 200 -> json: {bio: xqcL, city: Toronto, CA, website: www.wpp.pl, image: /media/default.jpg, username: kornel, email: kornel@wp.pl}
    */

    var response = await get('api/posts/');

    final jsonResponse = jsonDecode(response.body);

    print(jsonResponse);

    List<Post> posts = new List();

    for (var e in jsonResponse) {
      posts.add(Post(e));
    }

    for (Post post in posts) {
      print(post);
    }

    // return jsonResponse;
    return posts;
  }

  static Future<List> getAllComments() async {
    /*
    * StatusCode: 200 -> json: {bio: xqcL, city: Toronto, CA, website: www.wpp.pl, image: /media/default.jpg, username: kornel, email: kornel@wp.pl}
    */

    var response = await get('api/comments/');

    final jsonResponse = jsonDecode(response.body);

    print(jsonResponse);

    List<Comment> comments = new List();

    for (var e in jsonResponse) {
      comments.add(Comment(e));
    }

    for (Comment comment in comments) {
      print(comment);
    }

    return jsonResponse;
  }

  static Future<List> getAllLikes() async {
    /*
    * StatusCode: 200 -> json: {bio: xqcL, city: Toronto, CA, website: www.wpp.pl, image: /media/default.jpg, username: kornel, email: kornel@wp.pl}
    */

    var response = await get('api/likes/');

    final jsonResponse = jsonDecode(response.body);

    print(jsonResponse);

    List<Like> likes = new List();

    for (var e in jsonResponse) {
      likes.add(Like(e));
    }

    for (Like like in likes) {
      print(like);
    }

    return jsonResponse;
  }
}
