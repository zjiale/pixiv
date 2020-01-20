import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pixiv/api/api.dart';
import 'package:pixiv/common/config.dart';
import 'package:pixiv/model/case_model.dart';
import 'package:pixiv/model/image_list_model.dart';
import 'package:restio/restio.dart' as prefix;

class CommonServices {
  Future<Response> getRanking(
      String content, String mode, int pageIndex) async {
    return await Dio().get(
        "${Api.RANKING}&content=$content&mode=$mode&per_page=20&page=$pageIndex&date=2020-01-10",
        options: _getOptions());
  }

  void getLatest(Function callback) async {
    Dio().get(Api.LATEST, options: _getOptions()).then((response) {
      callback(ImageModel.fromJson(response.data));
    });
  }

  void getCase(Function callback) async {
    Dio().get(Api.SHOWCASE, options: _getOptions()).then((response) {
      callback(CaseModel.fromJson(response.data));
    });
  }

  Future<Response> getDetailInfo(String type, int id) async {
    return await Dio()
        .get("${Api.BASE_URL}?type=$type&id=$id", options: _getOptions());
  }

  // Future<Null> test() async {
  //   final dns = prefix.DnsOverUdp.ip("210.140.131.203");
  //   final client = prefix.Restio(
  //     dns: dns,
  //   );
  //   Map<String, dynamic> items = {
  //     "Authorization": "Bearer 1s-PTzAbMiznMuXoUukhHN2JAZZgTtEYg1knhLdwsxY",
  //     "User-Agent": "PixivAndroidApp/5.0.134 (Android 6.0.1; D6653)",
  //     "Accept-Language": "zh_CN",
  //     "X-Client-Time": "2020-01-17T10:40:20+08:00",
  //     "X-Client-Hash": "cd75e168fe4d63b228ba6b273c53eef8"
  //   };

  //   prefix.Headers headers = prefix.Headers.of(items);

  //   final request = prefix.Request.get(
  //       'https://app-api.pixiv.net/v1/spotlight/articles?filter=for_android&offset=10&category=illust',
  //       headers: headers);
  //   final call = client.newCall(request);
  //   final response = await call.execute();

  //   print(response.request);
  // }
  Future<void> test() async {
    var dio = new Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.options.headers = {
      "Authorization": "Bearer 4Z1THxDxdD78jNUYePnJng_GEz-8Nvtn1owvMOz0wHc",
      "User-Agent": "PixivAndroidApp/5.0.134 (Android 6.0.1; D6653)",
      "Accept-Language": "zh_CN",
      "X-Client-Time": "2020-01-17T10:40:20+08:00",
      "X-Client-Hash": "cd75e168fe4d63b228ba6b273c53eef8"
    };
    dio.interceptors.add(LogInterceptor(responseBody: true));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        // 默认情况下，这个cert证书是网站颁发机构的证书，并不是网站证书，开发者可以验证一下
        return true; //忽略证书校验
      };
    };
    await dio
        .get(
          "https://app-api.pixiv.net/v1/spotlight/articles?filter=for_android&offset=10&category=illust",
        )
        .then(print);
  }

  // Future<void> test1(List<String> args) async {
  //   for (var arg in args) {
  //     final client = HttpDnsClient.google();
  //     final result = await client.lookup("https://app-api.pixiv.com");
  //     print("$arg --> ${result.join(' | ')}");
  //   }
  // }

  Options _getOptions() {
    return Options(headers: Config().getHeader());
  }
}
