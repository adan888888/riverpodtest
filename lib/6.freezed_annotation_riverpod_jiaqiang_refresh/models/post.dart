// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'post.freezed.dart';
part 'post.g.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

@freezed
abstract class Post with _$Post {
    const factory Post({
        @JsonKey(name: "id")
        int? id,
        @JsonKey(name: "title")
        String? title,
        @JsonKey(name: "content")
        String? content,
        @JsonKey(name: "avatarUrl")
        String? avatarUrl,
    }) = _Post;

    factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
