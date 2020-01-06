import 'package:dio/dio.dart';
import 'package:pixiv/api/api.dart';
import 'package:pixiv/common/config.dart';
import 'package:pixiv/model/illust_rank_model.dart';
import 'package:pixiv/model/case_model.dart';
import 'package:pixiv/model/image_list_model.dart';

class CommonServices {
  // void getRanking(Function callback) async {
  //   Dio().get(Api.RANKING, options: _getOptions()).then((response) {
  //     callback(IllustRankModel.fromJson(response.data));
  //   });
  // }

  Future<Response> getRanking(String mode, int pageIndex) async {
    print(pageIndex);
    return await Dio().get(
        "${Api.RANKING}&mode=$mode&per_page=20&page=$pageIndex",
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

  Options _getOptions() {
    return Options(headers: Config().getHeader());
  }
}
