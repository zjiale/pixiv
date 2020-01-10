import 'dart:convert' show json;
import 'package:flutter/foundation.dart';

dynamic convertValueByType(value, Type type, {String stack: ""}) {
  if (value == null) {
    debugPrint("$stack : value is null");
    if (type == String) {
      return "";
    } else if (type == int) {
      return 0;
    } else if (type == double) {
      return 0.0;
    } else if (type == bool) {
      return false;
    }
    return null;
  }

  if (value.runtimeType == type) {
    return value;
  }
  var valueS = value.toString();
  debugPrint("$stack : ${value.runtimeType} is not $type type");
  if (type == String) {
    return valueS;
  } else if (type == int) {
    return int.tryParse(valueS);
  } else if (type == double) {
    return double.tryParse(valueS);
  } else if (type == bool) {
    valueS = valueS.toLowerCase();
    var intValue = int.tryParse(valueS);
    if (intValue != null) {
      return intValue == 1;
    }
    return valueS == "true";
  }
}

void tryCatch(Function f) {
  try {
    f?.call();
  } catch (e, stack) {
    debugPrint("$e");
    debugPrint("$stack");
  }
}

class DetailModel {
  String status;
  List<Contents> response;
  int count;

  DetailModel({
    this.status,
    this.response,
    this.count,
  });

  factory DetailModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Contents> response = jsonRes['response'] is List ? [] : null;
    if (response != null) {
      for (var item in jsonRes['response']) {
        if (item != null) {
          tryCatch(() {
            response.add(Contents.fromJson(item));
          });
        }
      }
    }

    return DetailModel(
      status: convertValueByType(jsonRes['status'], String,
          stack: "DetailModel-status"),
      response: response,
      count:
          convertValueByType(jsonRes['count'], int, stack: "DetailModel-count"),
    );
  }
  Map<String, dynamic> toJson() => {
        'status': status,
        'response': response,
        'count': count,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Contents {
  int id;
  String title;
  String caption;
  List<String> tags;
  List<String> tools;
  Image_urls image_urls;
  int width;
  int height;
  Stats stats;
  int publicity;
  String age_limit;
  String created_time;
  String reuploaded_time;
  User user;
  bool is_manga;
  bool is_liked;
  int favorite_id;
  int page_count;
  String book_style;
  String type;
  Metadata metadata;
  Object content_type;

  Contents({
    this.id,
    this.title,
    this.caption,
    this.tags,
    this.tools,
    this.image_urls,
    this.width,
    this.height,
    this.stats,
    this.publicity,
    this.age_limit,
    this.created_time,
    this.reuploaded_time,
    this.user,
    this.is_manga,
    this.is_liked,
    this.favorite_id,
    this.page_count,
    this.book_style,
    this.type,
    this.metadata,
    this.content_type,
  });

  factory Contents.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> tags = jsonRes['tags'] is List ? [] : null;
    if (tags != null) {
      for (var item in jsonRes['tags']) {
        if (item != null) {
          tryCatch(() {
            tags.add(item);
          });
        }
      }
    }

    List<String> tools = jsonRes['tools'] is List ? [] : null;
    if (tools != null) {
      for (var item in jsonRes['tools']) {
        if (item != null) {
          tryCatch(() {
            tools.add(item);
          });
        }
      }
    }

    return Contents(
      id: convertValueByType(jsonRes['id'], int, stack: "Contents-id"),
      title:
          convertValueByType(jsonRes['title'], String, stack: "Contents-title"),
      caption: convertValueByType(jsonRes['caption'], String,
          stack: "Contents-caption"),
      tags: tags,
      tools: tools,
      image_urls: Image_urls.fromJson(jsonRes['image_urls']),
      width: convertValueByType(jsonRes['width'], int, stack: "Contents-width"),
      height:
          convertValueByType(jsonRes['height'], int, stack: "Contents-height"),
      stats: Stats.fromJson(jsonRes['stats']),
      publicity: convertValueByType(jsonRes['publicity'], int,
          stack: "Contents-publicity"),
      age_limit: convertValueByType(jsonRes['age_limit'], String,
          stack: "Contents-age_limit"),
      created_time: convertValueByType(jsonRes['created_time'], String,
          stack: "Contents-created_time"),
      reuploaded_time: convertValueByType(jsonRes['reuploaded_time'], String,
          stack: "Contents-reuploaded_time"),
      user: User.fromJson(jsonRes['user']),
      is_manga: convertValueByType(jsonRes['is_manga'], bool,
          stack: "Contents-is_manga"),
      is_liked: convertValueByType(jsonRes['is_liked'], bool,
          stack: "Contents-is_liked"),
      favorite_id: convertValueByType(jsonRes['favorite_id'], int,
          stack: "Contents-favorite_id"),
      page_count: convertValueByType(jsonRes['page_count'], int,
          stack: "Contents-page_count"),
      book_style: convertValueByType(jsonRes['book_style'], String,
          stack: "Contents-book_style"),
      type: convertValueByType(jsonRes['type'], String, stack: "Contents-type"),
      metadata: Metadata.fromJson(jsonRes['metadata']),
      content_type: convertValueByType(jsonRes['content_type'], Object,
          stack: "Contents-content_type"),
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'caption': caption,
        'tags': tags,
        'tools': tools,
        'image_urls': image_urls,
        'width': width,
        'height': height,
        'stats': stats,
        'publicity': publicity,
        'age_limit': age_limit,
        'created_time': created_time,
        'reuploaded_time': reuploaded_time,
        'user': user,
        'is_manga': is_manga,
        'is_liked': is_liked,
        'favorite_id': favorite_id,
        'page_count': page_count,
        'book_style': book_style,
        'type': type,
        'metadata': metadata,
        'content_type': content_type,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Image_urls {
  String px_128x128;
  String px_480mw;
  String small;
  String medium;
  String large;

  Image_urls({
    this.px_128x128,
    this.px_480mw,
    this.small,
    this.medium,
    this.large,
  });

  factory Image_urls.fromJson(jsonRes) => jsonRes == null
      ? null
      : Image_urls(
          px_128x128: convertValueByType(jsonRes['px_128x128'], String,
              stack: "Image_urls-px_128x128"),
          px_480mw: convertValueByType(jsonRes['px_480mw'], String,
              stack: "Image_urls-px_480mw"),
          small: convertValueByType(jsonRes['small'], String,
              stack: "Image_urls-small"),
          medium: convertValueByType(jsonRes['medium'], String,
              stack: "Image_urls-medium"),
          large: convertValueByType(jsonRes['large'], String,
              stack: "Image_urls-large"),
        );
  Map<String, dynamic> toJson() => {
        'px_128x128': px_128x128,
        'px_480mw': px_480mw,
        'small': small,
        'medium': medium,
        'large': large,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Stats {
  int scored_count;
  int score;
  int views_count;
  Favorited_count favorited_count;
  int commented_count;

  Stats({
    this.scored_count,
    this.score,
    this.views_count,
    this.favorited_count,
    this.commented_count,
  });

  factory Stats.fromJson(jsonRes) => jsonRes == null
      ? null
      : Stats(
          scored_count: convertValueByType(jsonRes['scored_count'], int,
              stack: "Stats-scored_count"),
          score:
              convertValueByType(jsonRes['score'], int, stack: "Stats-score"),
          views_count: convertValueByType(jsonRes['views_count'], int,
              stack: "Stats-views_count"),
          favorited_count: Favorited_count.fromJson(jsonRes['favorited_count']),
          commented_count: convertValueByType(jsonRes['commented_count'], int,
              stack: "Stats-commented_count"),
        );
  Map<String, dynamic> toJson() => {
        'scored_count': scored_count,
        'score': score,
        'views_count': views_count,
        'favorited_count': favorited_count,
        'commented_count': commented_count,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Favorited_count {
  int public;
  int private;

  Favorited_count({
    this.public,
    this.private,
  });

  factory Favorited_count.fromJson(jsonRes) => jsonRes == null
      ? null
      : Favorited_count(
          public: convertValueByType(jsonRes['public'], int,
              stack: "Favorited_count-public"),
          private: convertValueByType(jsonRes['private'], int,
              stack: "Favorited_count-private"),
        );
  Map<String, dynamic> toJson() => {
        'public': public,
        'private': private,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class User {
  int id;
  String account;
  String name;
  bool is_following;
  bool is_follower;
  bool is_friend;
  Object is_premium;
  Profile_image_urls profile_image_urls;
  Object stats;
  Object profile;

  User({
    this.id,
    this.account,
    this.name,
    this.is_following,
    this.is_follower,
    this.is_friend,
    this.is_premium,
    this.profile_image_urls,
    this.stats,
    this.profile,
  });

  factory User.fromJson(jsonRes) => jsonRes == null
      ? null
      : User(
          id: convertValueByType(jsonRes['id'], int, stack: "User-id"),
          account: convertValueByType(jsonRes['account'], String,
              stack: "User-account"),
          name: convertValueByType(jsonRes['name'], String, stack: "User-name"),
          is_following: convertValueByType(jsonRes['is_following'], bool,
              stack: "User-is_following"),
          is_follower: convertValueByType(jsonRes['is_follower'], bool,
              stack: "User-is_follower"),
          is_friend: convertValueByType(jsonRes['is_friend'], bool,
              stack: "User-is_friend"),
          is_premium: convertValueByType(jsonRes['is_premium'], Object,
              stack: "User-is_premium"),
          profile_image_urls:
              Profile_image_urls.fromJson(jsonRes['profile_image_urls']),
          stats:
              convertValueByType(jsonRes['stats'], Object, stack: "User-stats"),
          profile: convertValueByType(jsonRes['profile'], Object,
              stack: "User-profile"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'account': account,
        'name': name,
        'is_following': is_following,
        'is_follower': is_follower,
        'is_friend': is_friend,
        'is_premium': is_premium,
        'profile_image_urls': profile_image_urls,
        'stats': stats,
        'profile': profile,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Profile_image_urls {
  String px_50x50;

  Profile_image_urls({
    this.px_50x50,
  });

  factory Profile_image_urls.fromJson(jsonRes) => jsonRes == null
      ? null
      : Profile_image_urls(
          px_50x50: convertValueByType(jsonRes['px_50x50'], String,
              stack: "Profile_image_urls-px_50x50"),
        );
  Map<String, dynamic> toJson() => {
        'px_50x50': px_50x50,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Metadata {
  List<Pages> pages;

  Metadata({
    this.pages,
  });

  factory Metadata.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<Pages> pages = jsonRes['pages'] is List ? [] : null;
    if (pages != null) {
      for (var item in jsonRes['pages']) {
        if (item != null) {
          tryCatch(() {
            pages.add(Pages.fromJson(item));
          });
        }
      }
    }

    return Metadata(
      pages: pages,
    );
  }
  Map<String, dynamic> toJson() => {
        'pages': pages,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Pages {
  Meta_Image_urls image_urls;

  Pages({
    this.image_urls,
  });

  factory Pages.fromJson(jsonRes) => jsonRes == null
      ? null
      : Pages(
          image_urls: Meta_Image_urls.fromJson(jsonRes['image_urls']),
        );
  Map<String, dynamic> toJson() => {
        'image_urls': image_urls,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Meta_Image_urls {
  String large;
  String px_128x128;
  String px_480mw;
  String medium;

  Meta_Image_urls({
    this.large,
    this.px_128x128,
    this.px_480mw,
    this.medium,
  });

  factory Meta_Image_urls.fromJson(jsonRes) => jsonRes == null
      ? null
      : Meta_Image_urls(
          large: convertValueByType(jsonRes['large'], String,
              stack: "Meta_Image_urls-large"),
          px_128x128: convertValueByType(jsonRes['px_128x128'], String,
              stack: "Meta_Image_urls-px_128x128"),
          px_480mw: convertValueByType(jsonRes['px_480mw'], String,
              stack: "Meta_Image_urls-px_480mw"),
          medium: convertValueByType(jsonRes['medium'], String,
              stack: "Meta_Image_urls-medium"),
        );
  Map<String, dynamic> toJson() => {
        'large': large,
        'px_128x128': px_128x128,
        'px_480mw': px_480mw,
        'medium': medium,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
