import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const baseUrl = "https://secret-savannah-28994.herokuapp.com/api";

class Api{
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
      prefs.setString('status',res.data['status']);
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

    static Future<bool> signIn(String name,String email, String password) async {
    bool b;

    var url = baseUrl + "/auth";
    try {
      final res = await Dio().post(url,
          data: {
            "email": email,
            "password": password,
          },
          options: Options(
            headers: {"Content-type": "application/json; charset=utf-8"},
          ));
     
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('eName', name);
      prefs.setString('token', res.data);
      print("Res ${res.data}");
      if (res.statusCode == 200 && res !=null) {
        b = true;
        print(prefs.getString('eName'));
        prefs.setBool('isLoggedin', true);
      } else {
        b = false;
      }
    } on DioError catch (ex) {
      print(ex.message);
    }on Exception catch(ex){
      print(ex);
    }
    return b;
  }
}