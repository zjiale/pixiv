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

class ImageModel {
  String status;
  List<ImageList> response;
  int count;
  Pagination pagination;

  ImageModel({
    this.status,
    this.response,
    this.count,
    this.pagination,
  });

  factory ImageModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<ImageList> response = jsonRes['response'] is List ? [] : null;
    if (response != null) {
      for (var item in jsonRes['response']) {
        if (item != null) {
          tryCatch(() {
            response.add(ImageList.fromJson(item));
          });
        }
      }
    }

    return ImageModel(
      status: convertValueByType(jsonRes['status'], String,
          stack: "ImageModel-status"),
      response: response,
      count:
          convertValueByType(jsonRes['count'], int, stack: "ImageModel-count"),
      pagination: Pagination.fromJson(jsonRes['pagination']),
    );
  }
  Map<String, dynamic> toJson() => {
        'status': status,
        'response': response,
        'count': count,
        'pagination': pagination,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class ImageList {
  int id;
  String title;
  String caption;
  List<String> tags;
  List<Object> tools;
  Image_urls image_urls;
  int width;
  int height;
  Object stats;
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
  Object metadata;
  Object content_type;
  String sanity_level;

  ImageList({
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
    this.sanity_level,
  });

  factory ImageList.fromJson(jsonRes) {
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

    List<Object> tools = jsonRes['tools'] is List ? [] : null;
    if (tools != null) {
      for (var item in jsonRes['tools']) {
        if (item != null) {
          tryCatch(() {
            tools.add(item);
          });
        }
      }
    }

    return ImageList(
      id: convertValueByType(jsonRes['id'], int, stack: "ImageList-id"),
      title: convertValueByType(jsonRes['title'], String,
          stack: "ImageList-title"),
      caption: convertValueByType(jsonRes['caption'], String,
          stack: "ImageList-caption"),
      tags: tags,
      tools: tools,
      image_urls: Image_urls.fromJson(jsonRes['image_urls']),
      width:
          convertValueByType(jsonRes['width'], int, stack: "ImageList-width"),
      height:
          convertValueByType(jsonRes['height'], int, stack: "ImageList-height"),
      stats: convertValueByType(jsonRes['stats'], Object,
          stack: "ImageList-stats"),
      publicity: convertValueByType(jsonRes['publicity'], int,
          stack: "ImageList-publicity"),
      age_limit: convertValueByType(jsonRes['age_limit'], String,
          stack: "ImageList-age_limit"),
      created_time: convertValueByType(jsonRes['created_time'], String,
          stack: "ImageList-created_time"),
      reuploaded_time: convertValueByType(jsonRes['reuploaded_time'], String,
          stack: "ImageList-reuploaded_time"),
      user: User.fromJson(jsonRes['user']),
      is_manga: convertValueByType(jsonRes['is_manga'], bool,
          stack: "ImageList-is_manga"),
      is_liked: convertValueByType(jsonRes['is_liked'], bool,
          stack: "ImageList-is_liked"),
      favorite_id: convertValueByType(jsonRes['favorite_id'], int,
          stack: "ImageList-favorite_id"),
      page_count: convertValueByType(jsonRes['page_count'], int,
          stack: "ImageList-page_count"),
      book_style: convertValueByType(jsonRes['book_style'], String,
          stack: "ImageList-book_style"),
      type:
          convertValueByType(jsonRes['type'], String, stack: "ImageList-type"),
      metadata: convertValueByType(jsonRes['metadata'], Object,
          stack: "ImageList-metadata"),
      content_type: convertValueByType(jsonRes['content_type'], Object,
          stack: "ImageList-content_type"),
      sanity_level: convertValueByType(jsonRes['sanity_level'], String,
          stack: "ImageList-sanity_level"),
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
        'sanity_level': sanity_level,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class Image_urls {
  String px_128x128;
  String px_480mw;
  String large;

  Image_urls({
    this.px_128x128,
    this.px_480mw,
    this.large,
  });

  factory Image_urls.fromJson(jsonRes) => jsonRes == null
      ? null
      : Image_urls(
          px_128x128: convertValueByType(jsonRes['px_128x128'], String,
              stack: "Image_urls-px_128x128"),
          px_480mw: convertValueByType(jsonRes['px_480mw'], String,
              stack: "Image_urls-px_480mw"),
          large: convertValueByType(jsonRes['large'], String,
              stack: "Image_urls-large"),
        );
  Map<String, dynamic> toJson() => {
        'px_128x128': px_128x128,
        'px_480mw': px_480mw,
        'large': large,
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

class Pagination {
  Object previous;
  int next;
  int current;
  int per_page;
  int total;
  int pages;

  Pagination({
    this.previous,
    this.next,
    this.current,
    this.per_page,
    this.total,
    this.pages,
  });

  factory Pagination.fromJson(jsonRes) => jsonRes == null
      ? null
      : Pagination(
          previous: convertValueByType(jsonRes['previous'], Object,
              stack: "Pagination-previous"),
          next: convertValueByType(jsonRes['next'], int,
              stack: "Pagination-next"),
          current: convertValueByType(jsonRes['current'], int,
              stack: "Pagination-current"),
          per_page: convertValueByType(jsonRes['per_page'], int,
              stack: "Pagination-per_page"),
          total: convertValueByType(jsonRes['total'], int,
              stack: "Pagination-total"),
          pages: convertValueByType(jsonRes['pages'], int,
              stack: "Pagination-pages"),
        );
  Map<String, dynamic> toJson() => {
        'previous': previous,
        'next': next,
        'current': current,
        'per_page': per_page,
        'total': total,
        'pages': pages,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
