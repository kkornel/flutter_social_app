class Like {
  int id;
  int postId;
  String author;
  DateTime dateReceived;

  Like(Map<String, dynamic> json) {
    this.id = json['id'];
    this.postId = json['post'];
    this.author = json['author'];
    this.dateReceived = DateTime.parse(json['date_received']);
  }

  @override
  String toString() {
    return 'Like: id: $id, postId: $postId, author: $author, dateReceived: $dateReceived';
  }
}
