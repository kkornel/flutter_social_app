import 'dart:convert';

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

  static Future<dynamic> post(String url, Map data) async {
    var body = jsonEncode(data);

    final response = await http.post(
      BASE_API_URL + url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('StatusCode: ${response.statusCode}');
    print('Response.body: ${response.body}');

    if (response.statusCode >= 400) {
      // TODO: Think of better approach, after we'll have more POST methods done.
      // final jsonResponse2 = jsonDecode(response.body);
      // throw Exception();
      // throw ('An error occured (${response.statusCode}): ${response.body}');
    }

    // final jsonResponse = jsonDecode(response.body);
    // return jsonResponse;

    // ? hmm
    try {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (exception) {
      throw ('An error occured: ${response.body}');
    }
  }

  static Future fetchData(String url) async {
    String fullUrl = BASE_API_URL + url;

    final response = await http.post(fullUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': 'kornel@wp.pl', 'password': 'lol'}));

    print(response.statusCode);

    if (response.statusCode == 200) {
      var body = response.body;
      print(body);
      var json = jsonDecode(body);
      print(json);
      return json;
    } else {
      print(response.statusCode);
    }
  }
}
