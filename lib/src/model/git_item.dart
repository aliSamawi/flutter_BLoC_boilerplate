import 'package:flutter_bloc_boilerplate/src/model/owner_git_item.dart';

class GitItem{
  int id ;
  String name ;
  String full_name ;
  String description ;
  String html_url ;
  String created_at ;
  int watchers_count ;
  int open_issues_count ;
  int forks_count ;
  int stargazers_count ;
  OwnerGitItem owner ;

  GitItem({this.id,this.name,this.full_name,this.description,this.html_url,
      this.created_at,this.watchers_count,this.open_issues_count,this.forks_count,this.stargazers_count,
      this.owner});

  factory GitItem.fromJson(Map<String, dynamic> json) {
    return GitItem(
      id: json['id'],
      name: json['name'],
      full_name: json['full_name'],
      description: json['description'],
      html_url: json['html_url'],
      created_at: json['created_at'],
      watchers_count: json['watchers_count'],
      open_issues_count: json['open_issues_count'],
      forks_count: json['forks_count'],
      stargazers_count: json['stargazers_count'],
      owner: OwnerGitItem.fromJson(json['owner']),
    );
  }

}