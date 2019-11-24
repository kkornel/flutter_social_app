class Comment {
  int id;
  int postId;
  String author;
  String text;
  DateTime dateCreated;

  Comment(Map<String, dynamic> json) {
    this.id = json['id'];
    this.postId = json['post'];
    this.author = json['author'];
    this.text = json['text'];
    this.dateCreated = DateTime.parse(json['date_created']);
  }

  @override
  String toString() {
    return 'Comment: id: $id, postId: $postId, author: $author, content: $text, dateCreated: $dateCreated';
  }
}
