import 'dart:convert';
import 'package:clean_architecture_study/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String title;
  final String content;
  final String image;

  ResultSearchModel({
    this.title,
    this.content,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'content': this.content,
      'image': this.image,
    };
  }

  static ResultSearchModel fromMap(Map<String, dynamic> map) {
    if(map == null) return null;
    return ResultSearchModel(
      title: map['title'] as String,
      content: map['content'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  static ResultSearchModel fromJson(String map) => fromMap(json.decode(map));
}