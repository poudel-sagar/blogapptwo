import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class NetworkHandler {

  //String baseurl = "https://faker-rest.zeferinix.com/api/v1/";
    String baseurl = "https://flaskapi-sanjeev.herokuapp.com/";

  var log = Logger();

  Future get(String url) async {
//formater takes input  as a string(url) concatenate url with base url and return it.

    url = formater(url);

//getting response from backend
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }
//sending username, email and password to blog api.

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);
      return response;
    }
    log.d(response.body);
    log.d(response.statusCode);
  }

//formater takes input  as a string(url) concatenate url with base url and return it.
  String formater(String url) {
    return baseurl + url;
  }
}
