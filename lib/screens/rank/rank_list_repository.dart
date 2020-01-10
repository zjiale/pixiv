import 'dart:convert' as convert;

import 'package:loading_more_list/loading_more_list.dart';
import 'package:pixiv/api/CommonServices.dart';
import 'package:pixiv/model/illust_rank_model.dart';

class RankListRepository extends LoadingMoreBase<Works> {
  int pageindex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;

  final String content;
  final String rankType;
  final List firstData;
  bool isInit;
  RankListRepository(this.content, this.rankType, this.firstData, this.isInit);

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

      if (!this.isInit) {
        await CommonServices()
            .getRanking(this.content, this.rankType, pIndex)
            .then((res) {
          if (res.statusCode == 200) {
            IllustRankModel _bean = IllustRankModel.fromJson(res.data);
            if (_bean.status == "success") {
              source = _bean.response.first.works;
            }
          }
        });
      } else {
        // 浅拷贝会影响前面的数据所以需要深拷贝
        List _firstData = List<Works>.from(this.firstData);
        _firstData.removeRange(0, 3);
        source = _firstData;
      }

      if (pageindex == 1) {
        this.clear();
        this.isInit = false;
      }

      for (var item in source) {
        if (!this.contains(item) && hasMore) this.add(item);
      }

      _hasMore = source.length != 0;
      pageindex++;

      isSuccess = true;
    } catch (exception, stack) {
      isSuccess = false;
      print(exception);
      print(stack);
    }
    return isSuccess;
  }
}
