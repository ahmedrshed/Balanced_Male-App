import 'package:dio/dio.dart';

class DioHelper {
  static Future<Response> confirm({required List items}) {
    return Dio().post(
      "https://uz8if7.buildship.run/placeOrder",
      data: {"items": items},
    );
  }
}
