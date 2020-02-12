import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:provider_demo/models/visitor.dart';
import 'package:shared_preferences/shared_preferences.dart';

const baseUrl = "https://secret-savannah-28994.herokuapp.com/api";

class Api {
  static Future getVisitors() async {
    var url = baseUrl + "/visitors";
    var client = http.Client();

    return client.get(Uri.encodeFull(url)).whenComplete(client.close);
  }

  static Future<String> signUp(
      String name, String email, String password, String isAdmin) async {
    var url = baseUrl + "/users";
    String b;
    try {
      final res = await Dio().post(url,
          data: {
            "name": name,
            "email": email,
            "password": password,
            "isAdmin": isAdmin
          },
          options: Options(
            headers: {"Content-type": "application/json; charset=utf-8"},
          ));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id', res.data['_id']);
      prefs.setString('name', res.data['name']);
      prefs.setString('email', res.data['email']);
      prefs.setString('isAdmin', res.data['isAdmin']);
      prefs.setString('status', res.data['status']);
      print("Res ${res.data}");
      if (res.statusCode == 200) {
        print(res.statusCode.toString());
        b = "success";
      } else {
        b = res.data;
        // throw new Exception('Something failed');
      }
    } on DioError catch (ex) {
      print(ex);
    }

    return b;
  }

  static Future<bool> signIn(String name, String email, String password) async {
    bool b;

    var url = baseUrl + "/auth";
    try {
      final res = await Dio().post(url,
          data: {
            "email": email,
            "password": password,
          },
          options: Options(
            headers: {
              "Content-type": "application/json; charset=utf-8",
              "x-auth-token": "token"
            },
          ));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('eName', name);
      prefs.setString('token', res.headers.value('x-auth-token'));
      prefs.setString('id', res.data['_id']);
      prefs.setString('name', res.data['name']);
      prefs.setString('email', res.data['email']);
      prefs.setString('isAdmin', res.data['isAdmin']);
      prefs.setString('status', res.data['status']);
      print("Res ${res.data}");
      if (res.statusCode == 200 && res != null) {
        b = true;
        print(prefs.getString('eName'));
        var token = prefs.getString('token');
        print(token);
        prefs.setBool('isLoggedin', true);
      } else {
        b = false;
      }
    } on DioError catch (ex) {
      print(ex.message);
    } on Exception catch (ex) {
      print(ex);
    }
    return b;
  }

  static Future<bool> updateVisitorStats(
      String id, String status, String visitorName) async {
    bool b;
    var url = baseUrl + "/visitorstatus";
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = prefs.getString('token');

      final res = await Dio().post(url,
          data: {
            "visitorId": id,
            "visitorName": visitorName,
            "status": status,
          },
          options: Options(headers: {
            "x-auth-token": token,
          }));
      print(res.data);
      if (res.statusCode == 200) {
        b = true;
      } else {
        b = false;
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return b;
  }

  static Future<bool> deleteVisitor(String id) async {
    bool b;
    var url = baseUrl + "/visitors/$id";
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = prefs.getString('token');
      final res = await Dio().delete(url,
          data: {},
          options: Options(headers: {
            "x-auth-token": token,
          }));
      print(token);
      if (res.statusCode == 200) {
        b = true;
      } else {
        b = false;
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return b;
  }

  static Future<List<Visitor>> getVisitor2() async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // var who = prefs.getString('name');
      // var eWho = prefs.getString('eName');

      var url = baseUrl + "/visitors";
      var client = http.Client();
      final response =
          await client.get(Uri.encodeFull(url)).whenComplete(client.close);
      if (response.statusCode == 200) {
        List<Visitor> list = parseUsers(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Visitor> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Visitor>((json) => Visitor.fromJson(json)).toList();
  }

  static Future<bool> updateStatus(String id, String status) async {
    bool b;
    var url = baseUrl + "/userstatus";
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = prefs.getString('token');
      String userName = prefs.getString('name');
      final res = await Dio().post(url,
          data: {
            "userId": id,
            "userName": userName,
            "status": status,
          },
          options: Options(headers: {
            "x-auth-token": token,
          }));
      print(res.data);
      if (res.statusCode == 200) {
        b = true;
      } else {
        b = false;
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return b;
  }

  static Future<bool> deleteMyAcct(String id) async {
    bool b;
    var url = baseUrl + "/users/$id";
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = prefs.getString('token');
      final res = await Dio().delete(url,
          data: {},
          options: Options(headers: {
            "x-auth-token": token,
          }));
      print(res.data);
      if (res.statusCode == 200) {
        b = true;
      } else {
        b = false;
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return b;
  }



    static Future<bool> deleteUser(String id) async {
       bool b;
    var url = baseUrl + "/users/$id";
  try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
 
    String token = prefs.getString('token');
    final res = await Dio().delete(url,
        data: {},
        options: Options(headers: {
          "x-auth-token": token,
        }));
        print(res.data);
        if(res.statusCode == 200){
          b = true;
        }else{
          b = false;
        }
  }on DioError catch(e){
    print(e.message);
  }
 return b;
  }
}
