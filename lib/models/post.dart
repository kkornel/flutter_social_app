import 'package:flutter_social_app/models/comment.dart';
import 'package:flutter_social_app/models/like.dart';

class Post {
  int id;
  String author;
  String content;
  DateTime datePosted;
  String location;
  String image;
  List<Like> likes = new List();
  List<Comment> comments = new List();

  Post(Map<String, dynamic> json) {
    this.id = json['id'];
    this.author = json['author'];
    this.content = json['content'];
    this.datePosted = DateTime.parse(json['date_posted']);
    this.location = json['location'];
    this.image = json['image'];

    for (var like in json['likes']) {
      this.likes.add(Like(like));
    }

    for (var comment in json['comments']) {
      this.comments.add(Comment(comment));
    }
  }

  @override
  String toString() {
    return 'Post: id: $id, author: $author, content: $content, datePosted: $datePosted,' +
        'location: $location, likes: $likes, comments: $comments, image: $image';
  }
}
