import 'dart:convert';

import '../../domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String login;
  final String htmlUrl;
  final String avatarUrl;

  ResultSearchModel({this.login, this.htmlUrl, this.avatarUrl});

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'html_url': htmlUrl,
      'avatar_url': avatarUrl,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResultSearchModel(
      login: map['login'],
      htmlUrl: map['html_url'],
      avatarUrl: map['avatar_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) =>
      ResultSearchModel.fromMap(json.decode(source));
}
