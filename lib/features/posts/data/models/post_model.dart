import 'package:clean_architicure_posts/features/posts/domain/entiteis/post.dart';

class PostModel extends Post {
  const PostModel(
      {super.id, required super.title, required super.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body};
  }
}
