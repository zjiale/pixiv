import 'package:loading_more_list/loading_more_list.dart';
import 'package:pixiv/api/CommonServices.dart';
import 'package:pixiv/model/illust_rank_model.dart';

class RankListRepository extends LoadingMoreBase<Works> {
  int pageindex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;
  @override
  bool get hasMore => _hasMore || forceRefresh;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = true;
    pageindex = 1;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    forceRefresh = !clearBeforeRequest;
    var result = await super.refresh(clearBeforeRequest);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    int pIndex = pageindex;
    var source;

    bool isSuccess = false;
    try {
      //to show loading more clearly, in your app,remove this
      await Future.delayed(Duration(milliseconds: 500));

      await CommonServices().getRanking('daily', pIndex).then((res) {
        if (res.statusCode == 200) {
          IllustRankModel _bean = IllustRankModel.fromJson(res.data);
          if (_bean.status == "success") {
            source = _bean.response.first.works;
          }
        }
      });

      if (pageindex == 1) {
        this.clear();
      }

      for (var item in source) {
        if (!this.contains(item) && hasMore) this.add(item);
      }

      _hasMore = source.length != 0;
      pageindex++;
//      this.clear();
//      _hasMore=false;
      isSuccess = true;
    } catch (exception, stack) {
      isSuccess = false;
      print(exception);
      print(stack);
    }
    return isSuccess;
  }
}
