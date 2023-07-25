// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Note {
  final int? id;
  final String? title;
  final String? body;
  final DateTime createdAt;

  Note({
    this.id,
    this.title,
    this.body,
    required this.createdAt,
  });

 

  Note copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? createdAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Note(id: $id, title: $title, body: $body, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.body == body &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      body.hashCode ^
      createdAt.hashCode;
  }
}
