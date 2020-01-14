class Config {
  String cookie;
  Map<String, String> _headerMap;

  static Map<String, String> headers = {
    "Referer": "https://www.pixiv.net/ranking.php?mode=daily",
    "User-Agent":
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36"
  };

  static List rankTab = [
    {"text": "日榜", "type": "daily"},
    {"text": "新人", "type": "rookie"},
    {"text": "周榜", "type": "weekly"},
    {"text": "月榜", "type": "monthly"},
    {"text": "过去", "type": "other"},
  ];

  Map<String, String> getHeader() {
    if (null == _headerMap) {
      _headerMap = Map();
      _headerMap["Cookie"] = cookie;
    }
    return _headerMap;
  }
}
