import 'dart:convert' show json;

class IllustRankModel {
  int count;
  String status;
  List<Contents> response;
  Pagination pagination;

  IllustRankModel.fromParams(
      {this.count, this.status, this.response, this.pagination});

  factory IllustRankModel(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new IllustRankModel.fromJson(json.decode(jsonStr))
          : new IllustRankModel.fromJson(jsonStr);

  IllustRankModel.fromJson(jsonRes) {
    count = jsonRes['count'];
    status = jsonRes['status'];
    response = jsonRes['response'] == null ? null : [];

    for (var responseItem in response == null ? [] : jsonRes['response']) {
      response.add(
          responseItem == null ? null : new Contents.fromJson(responseItem));
    }

    pagination = jsonRes['pagination'] == null
        ? null
        : new Pagination.fromJson(jsonRes['pagination']);
  }

  @override
  String toString() {
    return '{"count": $count,"status": ${status != null ? '${json.encode(status)}' : 'null'},"response": $response,"pagination": $pagination}';
  }
}

class Pagination {
  Object previous;
  int current;
  int next;
  int pages;
  int per_page;
  int total;

  Pagination.fromParams(
      {this.previous,
      this.current,
      this.next,
      this.pages,
      this.per_page,
      this.total});

  Pagination.fromJson(jsonRes) {
    previous = jsonRes['previous'];
    current = jsonRes['current'];
    next = jsonRes['next'];
    pages = jsonRes['pages'];
    per_page = jsonRes['per_page'];
    total = jsonRes['total'];
  }

  @override
  String toString() {
    return '{"previous": $previous,"current": $current,"next": $next,"pages": $pages,"per_page": $per_page,"total": $total}';
  }
}

class Contents {
  String content;
  String date;
  String mode;
  List<Works> works;

  Contents.fromParams({this.content, this.date, this.mode, this.works});

  Contents.fromJson(jsonRes) {
    content = jsonRes['content'];
    date = jsonRes['date'];
    mode = jsonRes['mode'];
    works = jsonRes['works'] == null ? null : [];

    for (var worksItem in works == null ? [] : jsonRes['works']) {
      works.add(worksItem == null ? null : new Works.fromJson(worksItem));
    }
  }

  @override
  String toString() {
    return '{"content": ${content != null ? '${json.encode(content)}' : 'null'},"date": ${date != null ? '${json.encode(date)}' : 'null'},"mode": ${mode != null ? '${json.encode(mode)}' : 'null'},"works": $works}';
  }
}

class Works {
  int previous_rank;
  int rank;
  Work work;

  Works.fromParams({this.previous_rank, this.rank, this.work});

  Works.fromJson(jsonRes) {
    previous_rank = jsonRes['previous_rank'];
    rank = jsonRes['rank'];
    work = jsonRes['work'] == null ? null : new Work.fromJson(jsonRes['work']);
  }

  @override
  String toString() {
    return '{"previous_rank": $previous_rank,"rank": $rank,"work": $work}';
  }
}

class Work {
  Object caption;
  Object content_type;
  Object favorite_id;
  Object is_liked;
  Object is_manga;
  Object metadata;
  Object tools;
  int height;
  int id;
  int page_count;
  int publicity;
  int width;
  String age_limit;
  String book_style;
  String created_time;
  String reuploaded_time;
  String sanity_level;
  String title;
  String type;
  List<String> tags;
  Image_Urls image_urls;
  Stats stats;
  User user;

  Work.fromParams(
      {this.caption,
      this.content_type,
      this.favorite_id,
      this.is_liked,
      this.is_manga,
      this.metadata,
      this.tools,
      this.height,
      this.id,
      this.page_count,
      this.publicity,
      this.width,
      this.age_limit,
      this.book_style,
      this.created_time,
      this.reuploaded_time,
      this.sanity_level,
      this.title,
      this.type,
      this.tags,
      this.image_urls,
      this.stats,
      this.user});

  Work.fromJson(jsonRes) {
    caption = jsonRes['caption'];
    content_type = jsonRes['content_type'];
    favorite_id = jsonRes['favorite_id'];
    is_liked = jsonRes['is_liked'];
    is_manga = jsonRes['is_manga'];
    metadata = jsonRes['metadata'];
    tools = jsonRes['tools'];
    height = jsonRes['height'];
    id = jsonRes['id'];
    page_count = jsonRes['page_count'];
    publicity = jsonRes['publicity'];
    width = jsonRes['width'];
    age_limit = jsonRes['age_limit'];
    book_style = jsonRes['book_style'];
    created_time = jsonRes['created_time'];
    reuploaded_time = jsonRes['reuploaded_time'];
    sanity_level = jsonRes['sanity_level'];
    title = jsonRes['title'];
    type = jsonRes['type'];
    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']) {
      tags.add(tagsItem);
    }

    image_urls = jsonRes['image_urls'] == null
        ? null
        : new Image_Urls.fromJson(jsonRes['image_urls']);
    stats =
        jsonRes['stats'] == null ? null : new Stats.fromJson(jsonRes['stats']);
    user = jsonRes['user'] == null ? null : new User.fromJson(jsonRes['user']);
  }

  @override
  String toString() {
    return '{"caption": $caption,"content_type": $content_type,"favorite_id": $favorite_id,"is_liked": $is_liked,"is_manga": $is_manga,"metadata": $metadata,"tools": $tools,"height": $height,"id": $id,"page_count": $page_count,"publicity": $publicity,"width": $width,"age_limit": ${age_limit != null ? '${json.encode(age_limit)}' : 'null'},"book_style": ${book_style != null ? '${json.encode(book_style)}' : 'null'},"created_time": ${created_time != null ? '${json.encode(created_time)}' : 'null'},"reuploaded_time": ${reuploaded_time != null ? '${json.encode(reuploaded_time)}' : 'null'},"sanity_level": ${sanity_level != null ? '${json.encode(sanity_level)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"type": ${type != null ? '${json.encode(type)}' : 'null'},"tags": $tags,"image_urls": $image_urls,"stats": $stats,"user": $user}';
  }
}

class User {
  Object is_follower;
  Object is_following;
  Object is_friend;
  Object is_premium;
  Object profile;
  Object stats;
  int id;
  String account;
  String name;
  Profile_Image_Urls profile_image_urls;

  User.fromParams(
      {this.is_follower,
      this.is_following,
      this.is_friend,
      this.is_premium,
      this.profile,
      this.stats,
      this.id,
      this.account,
      this.name,
      this.profile_image_urls});

  User.fromJson(jsonRes) {
    is_follower = jsonRes['is_follower'];
    is_following = jsonRes['is_following'];
    is_friend = jsonRes['is_friend'];
    is_premium = jsonRes['is_premium'];
    profile = jsonRes['profile'];
    stats = jsonRes['stats'];
    id = jsonRes['id'];
    account = jsonRes['account'];
    name = jsonRes['name'];
    profile_image_urls = jsonRes['profile_image_urls'] == null
        ? null
        : new Profile_Image_Urls.fromJson(jsonRes['profile_image_urls']);
  }

  @override
  String toString() {
    return '{"is_follower": $is_follower,"is_following": $is_following,"is_friend": $is_friend,"is_premium": $is_premium,"profile": $profile,"stats": $stats,"id": $id,"account": ${account != null ? '${json.encode(account)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"profile_image_urls": $profile_image_urls}';
  }
}

class Profile_Image_Urls {
  String px_170x170;
  String px_50x50;

  Profile_Image_Urls.fromParams({this.px_170x170, this.px_50x50});

  Profile_Image_Urls.fromJson(jsonRes) {
    px_170x170 = jsonRes['px_170x170'];
    px_50x50 = jsonRes['px_50x50'];
  }

  @override
  String toString() {
    return '{"px_170x170": ${px_170x170 != null ? '${json.encode(px_170x170)}' : 'null'},"px_50x50": ${px_50x50 != null ? '${json.encode(px_50x50)}' : 'null'}}';
  }
}

class Stats {
  Object commented_count;
  int score;
  int scored_count;
  int views_count;
  Favorited_Count favorited_count;

  Stats.fromParams(
      {this.commented_count,
      this.score,
      this.scored_count,
      this.views_count,
      this.favorited_count});

  Stats.fromJson(jsonRes) {
    commented_count = jsonRes['commented_count'];
    score = jsonRes['score'];
    scored_count = jsonRes['scored_count'];
    views_count = jsonRes['views_count'];
    favorited_count = jsonRes['favorited_count'] == null
        ? null
        : new Favorited_Count.fromJson(jsonRes['favorited_count']);
  }

  @override
  String toString() {
    return '{"commented_count": $commented_count,"score": $score,"scored_count": $scored_count,"views_count": $views_count,"favorited_count": $favorited_count}';
  }
}

class Favorited_Count {
  Object private;
  Object public;

  Favorited_Count.fromParams({this.private, this.public});

  Favorited_Count.fromJson(jsonRes) {
    private = jsonRes['private'];
    public = jsonRes['public'];
  }

  @override
  String toString() {
    return '{"private": $private,"public": $public}';
  }
}

class Image_Urls {
  String large;
  String px_128x128;
  String px_480mw;

  Image_Urls.fromParams({this.large, this.px_128x128, this.px_480mw});

  Image_Urls.fromJson(jsonRes) {
    large = jsonRes['large'];
    px_128x128 = jsonRes['px_128x128'];
    px_480mw = jsonRes['px_480mw'];
  }

  @override
  String toString() {
    return '{"large": ${large != null ? '${json.encode(large)}' : 'null'},"px_128x128": ${px_128x128 != null ? '${json.encode(px_128x128)}' : 'null'},"px_480mw": ${px_480mw != null ? '${json.encode(px_480mw)}' : 'null'}}';
  }
}
