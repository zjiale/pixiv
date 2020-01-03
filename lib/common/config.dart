class Config {
  String cookie;
  Map<String, String> _headerMap;

  static Map<String, String> headers = {
    "Referer": "https://www.pixiv.net/ranking.php?mode=daily",
    "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36"
  };

  Map<String, String> getHeader() {
    if (null == _headerMap) {
      _headerMap = Map();
      _headerMap["Cookie"] = cookie;
    }
    return _headerMap;
  }
}
