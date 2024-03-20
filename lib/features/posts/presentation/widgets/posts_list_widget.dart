import 'package:clean_architicure_posts/features/posts/domain/entiteis/post.dart';
import 'package:flutter/material.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: ((context, index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(
              posts[index].title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].body),
            contentPadding: const EdgeInsets.all(10),
            onTap: () {},
          );
        }),
        separatorBuilder: ((context, index) {
          return const Divider(
            thickness: 1,
            color: Colors.grey,
          );
        }),
        itemCount: posts.length);
  }
}
