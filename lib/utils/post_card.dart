import 'package:flutter/material.dart';
import 'package:flutter_social_app/utils/date_formatter.dart';
import 'package:flutter_social_app/utils/profile_clipper.dart';
import 'package:flutter_social_app/utils/custom_icon.dart';
import 'package:flutter_social_app/models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 4.0, left: 4.0, bottom: 4.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: ClipOval(
                    clipper: ProfileClipper(),
                    child: Image.network(
                      'https://pbs.twimg.com/media/EKHKiqgXUAAgwav?format=jpg&name=large',
                      width: 36.0,
                      height: 36.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          post.author,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(' · '),
                        Text(
                          DateFormatter.formatDate(post.datePosted),
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      post.location,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.0, bottom: 4.0),
            child: Text(post.content),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://pbs.twimg.com/media/EKCg0tLWkAA0b0g?format=jpg&name=4096x4096'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(CustomIcons.favorite),
                    onPressed: () {},
                  ),
                  Text(post.likes.length.toString()),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.chat_bubble),
                    onPressed: () {},
                  ),
                  Text(post.comments.length.toString()),
                ],
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
