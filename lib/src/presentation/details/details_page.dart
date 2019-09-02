import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/src/base/bloc_provider.dart';
import 'package:flutter_bloc_boilerplate/src/model/git_item.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'details_bloc.dart';

class DetailsPage extends StatelessWidget {

  static getLaunchPage(GitItem gitItem) =>
  BlocProvider(bloc: DetailsBloc(), child: DetailsPage(gitItem));

  GitItem gitItem;
  DetailsPage(this.gitItem,{Key key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gitItem.name),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:16.0,left: 8 , right: 8),
        child: Wrap(
          spacing: 20, // to apply margin horizontally
          runSpacing: 20,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: gitItem.owner.avatar_url,
                fit: BoxFit.fill,
                height: 64.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(gitItem.stargazers_count.toString()),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 30.0,
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
                child: Text("name: ${gitItem.name}")),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("description: ${gitItem.description}")),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("watchers: ${gitItem.watchers_count}")),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("forks: ${gitItem.forks_count}")),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("issues' number: ${gitItem.open_issues_count}")),
            Align(
                alignment: Alignment.centerLeft,
                child:
                  InkWell(
                      child: new Text('Git Link',style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                      onTap: () => launch(gitItem.html_url)
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
