import 'dart:convert';
import 'package:clean_architecture_study/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String title;
  final int id;
  final String image;

  ResultSearchModel({
    this.title,
    this.id,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'login': this.title,
      'id': this.id,
      'avatar_url': this.image,
    };
  }

  static ResultSearchModel fromMap(Map<String, dynamic> map) {
    if(map == null) return null;
    return ResultSearchModel(
      title: map['login'] as String,
      id: map['id'] as int,
      image: map['avatar_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  static ResultSearchModel fromJson(String map) => fromMap(json.decode(map));
}