import 'dart:convert';
import 'dart:io';
import 'package:flutter_taxi_user/utility/network/ResponseModel.dart';
import 'package:flutter_taxi_user/utility/network/Constants.dart' as Constants;
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as httpClient;

class ApiHelper {

  //
  static Future<ResponseModel> postRequest(
      String url, Map<String, dynamic> data) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
    };

    return await httpClient
        .post(Constants.BASE_URL + url, body: jsonEncode(data), headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      print("RESPONSE_MODEL");
      print(value);
      ResponseModel model = ResponseModel.fromJson(json.decode(value.body));
      print(model.message.toString());
      return model;
    }).catchError((err) {
      print('Response Error:' + err.toString());
      throw err;
    });
  }

  static Future<ResponseModel> getRequest(String url) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };

    return await httpClient
        .get(url, headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      return ResponseModel.fromJson(jsonDecode(value.body));
    }).catchError((err) {
      throw err;
    });
  }
//
  static Future<ResponseModel1> putRequest(
      String url, Map<String, dynamic> data) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };
    return await httpClient
        .put(Constants.BASE_URL + url, body: jsonEncode(data), headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      return ResponseModel1.fromJson(jsonDecode(value.body));
    }).catchError((err) {
      throw err;
    });
  }
  //
  static Future<ResponseModel1> postRequest1(
      String url, Map<String, dynamic> data) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };
    return await httpClient
        .post(Constants.BASE_URL + url, body: jsonEncode(data), headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      return ResponseModel1.fromJson(jsonDecode(value.body));
    }).catchError((err) {
      throw err;
    });
  }

  //
  static Future<ResponseModel1> getRequest1(String url) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };
    return await httpClient
        .get(url, headers: head)
        .timeout(Duration(seconds: 10))
        .then((value) {
      return ResponseModel1.fromJson(jsonDecode(value.body));
    }).catchError((err) {
      throw err;
    });
  }

  //
  static Future<httpClient.StreamedResponse> uploadDocument(
      String url, File image) async {
    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };

    var filePath = Uri.parse(image.path);
    var request = httpClient.MultipartRequest(
        "POST", Uri.parse(Constants.BASE_URL + url));
    request.files.add(
      httpClient.MultipartFile.fromBytes(
          'file', await File.fromUri(filePath).readAsBytes(),
          filename: path.basename(image.path)),
    );
    request.headers.addAll(head);

    return await request.send();
  }

  static Future<httpClient.StreamedResponse> uploadMultipleDocument(
      Map<String, dynamic> data, List<File> images) async {
    String url = "";

    Map<String, String> head = {
      "Content-Type": "application/json",
      "accept": "application/json"
    };

    var request = httpClient.MultipartRequest("POST", Uri.parse(url));

    for (var i = 0; i < images.length; i++) {
      var filePath = Uri.parse(images[i].path);
      request.files.add(
        httpClient.MultipartFile.fromBytes(
            'file', await File.fromUri(filePath).readAsBytes(),
            filename: path.basename(images[i].path)),
      );
    }

    request.headers.addAll(head);

    request.fields["data"] = jsonEncode(data);

    return await request.send();
  }
}
