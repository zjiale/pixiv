class Api {
  static final String BASE_URL = "https://api.imjad.cn/pixiv/v1/";

  static final String RANKING =
      BASE_URL + "?type=rank&content=illust&mode=daily&per_page=20&page=1";

  // 最新插画
  static final String LATEST = BASE_URL + "?type=latest&per_page=6";
  // 特辑
  static final String SHOWCASE = BASE_URL + "?type=showcase";
}
