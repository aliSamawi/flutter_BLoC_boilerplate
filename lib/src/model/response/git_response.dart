import 'package:flutter_bloc_boilerplate/src/model/git_item.dart';

class GitResponse{
  int total_count ;
  List<GitItem> items ;

  GitResponse({this.total_count,this.items});

  factory GitResponse.fromJson(Map<String, dynamic> json) {
    return GitResponse(
        total_count: json['total_count'],
        items: (json['items'] as List).map((i) => GitItem.fromJson(i)).toList()
    );
  }
}