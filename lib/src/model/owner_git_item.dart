class OwnerGitItem{
  int id ;
  String login ;
  String avatar_url ;
  String html_url ;

  OwnerGitItem({this.id,this.login,this.avatar_url,this.html_url});

  factory OwnerGitItem.fromJson(Map<String, dynamic> json) {
    return OwnerGitItem(
        id: json['id'],
        login: json['login'],
        avatar_url: json['avatar_url'],
        html_url: json['html_url'],
    );
  }
}