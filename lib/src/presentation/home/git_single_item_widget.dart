import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_boilerplate/src/model/git_item.dart';
import 'package:flutter_bloc_boilerplate/src/statics/routes.dart';
import 'package:transparent_image/transparent_image.dart';

class GitSingleItemWidget extends StatelessWidget {
  GitItem gitItem;
  GitSingleItemWidget(this.gitItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, Routes.details, arguments: gitItem);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 64,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: gitItem.owner.avatar_url,
                    fit: BoxFit.fill,
                    height: 64.0,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(gitItem.name),
                      Row(
                        children: <Widget>[
                          Text(gitItem.stargazers_count.toString()),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 30.0,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.navigate_next,
                color: Colors.grey,
                size: 30.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
