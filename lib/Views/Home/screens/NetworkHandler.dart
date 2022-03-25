import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
class NetworkHandler{
String baseurl = "http://192.168.0.20:9030/jobportal-app/api/";
var log = Logger ();
String username = "comp_afd046de-0261-48c6-a590-f0714b288640.png";
FlutterSecureStorage storage = FlutterSecureStorage();


Future get (String url) async {
String token = await storage.read(key: "token");
  url = formater (url);
// /user/register
var response = await http.get(
  Uri.parse(url),
headers: {"Authorization": "Bearer Stoken"},
);
if (response.statusCode == 200 || response.statusCode == 201) {
  log.i(response.body);
  return json.decode(response.body);
}
log.i(response.body);
log.i(response.statusCode);
}
Future <http.Response> post(String url, Map<String, String> body) async {
  dynamic authToken = await storage.read(key: "token");
  url = formater(url);
  log.d(body);
  var response = await http.post(
    Uri.parse(url),
    headers: {
      "Content-type": "application/json",
      "Authorization": "Bearer $authToken"
    },
    body: json.encode(body),
  );
  return response;
}
Future <http.StreamedResponse> patchImage(String url, String filepath) async {
  url = formater(url);
  dynamic authToken = await storage.read(key: "token");
  var request = http.MultipartRequest('PATCH', Uri.parse(url));
  request.files.add(await http.MultipartFile.fromPath("ing", filepath));
  request.headers.addAll({
    "Content-type": "multipart/form-data",
    "Authorization": "Bearer $authToken"
  });
  var response = request.send();
  return response;
}
  String formater(String url) {
  return baseurl + url;
  }
   NetworkImage getImage (String username) {
  String url = formater("$username");
  return NetworkImage(url);
  }
  }