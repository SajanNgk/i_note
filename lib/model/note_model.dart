import 'dart:convert';

class Note {
  final String id;
  final String? title;
  final String? body;
  final DateTime createdAt;

  Note({
    required this.id,
    this.title,
    this.body,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt.toUtc().toIso8601String(), // Store createdAt as UTC ISO 8601 string
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] as String?,
      body: map['body'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String).toLocal(), // Convert UTC string back to local DateTime
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

  Note copyWith({
    String? id,
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
}
