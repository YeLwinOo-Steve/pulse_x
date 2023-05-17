// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

Post postsFromJson(String str) => Post.fromJson(json.decode(str));

String postsToJson(Post data) => json.encode(data.toJson());

class Post {
  int id;
  String title;
  String body;
  int userId;
  List<String> tags;
  int reactions;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.tags,
    required this.reactions,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    userId: json["userId"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    reactions: json["reactions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "userId": userId,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "reactions": reactions,
  };
}
