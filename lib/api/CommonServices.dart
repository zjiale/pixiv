import 'package:dio/dio.dart';
import 'package:pixiv/api/api.dart';
import 'package:pixiv/common/config.dart';
import 'package:pixiv/model/illust_rank_model.dart';
import 'package:pixiv/model/case_model.dart';
import 'package:pixiv/model/image_list_model.dart';

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
    print(type + '$id');
    return await Dio()
        .get("${Api.BASE_URL}?type=$type&id=$id", options: _getOptions());
  }

  Options _getOptions() {
    return Options(headers: Config().getHeader());
  }
}
