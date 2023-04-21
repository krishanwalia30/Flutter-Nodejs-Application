class Note {
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? dateadded;

  Note({this.id, this.userid, this.title, this.content, this.dateadded});

  // to create a note from a map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      userid: map['userid'],
      title: map['title'],
      content: map['content'],
      dateadded: DateTime.tryParse(map['dateadded']),
    );
  }

  // to create a map from a note
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userid": userid,
      "title": title,
      "content": content,
      "dateadded": dateadded?.toIso8601String(),
    };
  }
}
