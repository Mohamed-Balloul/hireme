import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hireme/core/class/statusrequest.dart';
import 'package:hireme/core/functions/checkinternet.dart';
import 'package:dartz/dartz.dart';

class Crud {
  //--Post
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data,
      [Map<String, String>? headers]) async {
    try {
      if (await checkInternet()) {
        // أضفنا الهيدر ليتوافق مع طلب الباك اند
        var response = await http.post(
          Uri.parse(linkurl),
          body: jsonEncode(data),
          headers: headers ??
              {
                // إذا كانت الـ headers فارغة، استخدم الأساسية
                "Accept": "application/json",
                "Content-Type": "application/json"
              },
        );
        print(response.statusCode);

        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 422) {
          Map responsebody = jsonDecode(response.body);
          print(responsebody);

          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  //--Get

  Future<Either<StatusRequest, Map>> getData(
      String linkurl, Map<String, String>? headers) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(linkurl), headers: headers);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  //--Post
  Future<Either<StatusRequest, Map>> putData(String linkurl, Map data,
      [Map<String, String>? headers]) async {
    try {
      if (await checkInternet()) {
        // أضفنا الهيدر ليتوافق مع طلب الباك اند
        var response = await http.put(
          Uri.parse(linkurl),
          body: jsonEncode(data),
          headers: headers ??
              {
                // إذا كانت الـ headers فارغة، استخدم الأساسية
                "Accept": "application/json",
                "Content-Type": "application/json"
              },
        );
        print(response.statusCode);

        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 422) {
          Map responsebody = jsonDecode(response.body);
          print(responsebody);

          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  //--
  // 3. طلبات التحديث الجزئي (PATCH) - تستخدم لجعل الإشعار "مقروء" حسب التوثيق
  Future<Either<StatusRequest, Map>> patchData(String linkurl, Map data,
      [Map<String, String>? headers]) async {
    try {
      if (await checkInternet()) {
        var response = await http.patch(
          Uri.parse(linkurl),
          body: jsonEncode(data),
          headers: headers ??
              {
                "Accept": "application/json",
                "Content-Type": "application/json"
              },
        );
        return _handleResponse(response);
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  // 4. طلبات الحذف (DELETE) - تستخدم لحذف توكن الجهاز عند تسجيل الخروج
  Future<Either<StatusRequest, Map>> deleteData(String linkurl,
      [Map<String, String>? headers]) async {
    try {
      if (await checkInternet()) {
        var response = await http.delete(Uri.parse(linkurl), headers: headers);
        return _handleResponse(response);
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  // دالة مساعدة لمعالجة رد السيرفر وتجنب التكرار
  Either<StatusRequest, Map> _handleResponse(http.Response response) {
    print("API Status Code: ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);
      return Right(responsebody);
    } else {
      return const Left(StatusRequest.serverfailure);
    }
  }
}
