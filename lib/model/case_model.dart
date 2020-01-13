import 'dart:convert' show json;
import 'package:flutter/foundation.dart';

dynamic convertValueByType(value, Type type, {String stack: ""}) {
  if (value == null) {
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

class CaseModel {
  bool error;
  String message;
  List<CaseBody> body;

  CaseModel({
    this.error,
    this.message,
    this.body,
  });

  factory CaseModel.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<CaseBody> body = jsonRes['body'] is List ? [] : null;
    if (body != null) {
      for (var item in jsonRes['body']) {
        if (item != null) {
          tryCatch(() {
            body.add(CaseBody.fromJson(item));
          });
        }
      }
    }

    return CaseModel(
      error:
          convertValueByType(jsonRes['error'], bool, stack: "CaseModel-error"),
      message: convertValueByType(jsonRes['message'], String,
          stack: "CaseModel-message"),
      body: body,
    );
  }
  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'body': body,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class CaseBody {
  String id;
  String lang;
  String title;
  String category;
  String subCategory;
  String subCategoryLabel;
  String subCategoryIntroduction;
  String thumbnailUrl;
  int publishDate;

  CaseBody({
    this.id,
    this.lang,
    this.title,
    this.category,
    this.subCategory,
    this.subCategoryLabel,
    this.subCategoryIntroduction,
    this.thumbnailUrl,
    this.publishDate,
  });

  factory CaseBody.fromJson(jsonRes) => jsonRes == null
      ? null
      : CaseBody(
          id: convertValueByType(jsonRes['id'], String, stack: "CaseBody-id"),
          lang: convertValueByType(jsonRes['lang'], String,
              stack: "CaseBody-lang"),
          title: convertValueByType(jsonRes['title'], String,
              stack: "CaseBody-title"),
          category: convertValueByType(jsonRes['category'], String,
              stack: "CaseBody-category"),
          subCategory: convertValueByType(jsonRes['subCategory'], String,
              stack: "CaseBody-subCategory"),
          subCategoryLabel: convertValueByType(
              jsonRes['subCategoryLabel'], String,
              stack: "CaseBody-subCategoryLabel"),
          subCategoryIntroduction: convertValueByType(
              jsonRes['subCategoryIntroduction'], String,
              stack: "CaseBody-subCategoryIntroduction"),
          thumbnailUrl: convertValueByType(jsonRes['thumbnailUrl'], String,
              stack: "CaseBody-thumbnailUrl"),
          publishDate: convertValueByType(jsonRes['publishDate'], int,
              stack: "CaseBody-publishDate"),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'lang': lang,
        'title': title,
        'category': category,
        'subCategory': subCategory,
        'subCategoryLabel': subCategoryLabel,
        'subCategoryIntroduction': subCategoryIntroduction,
        'thumbnailUrl': thumbnailUrl,
        'publishDate': publishDate,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
