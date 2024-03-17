import 'package:clean_architicure_posts/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit>cachePosts(List<PostModel> posts);
}

class PostsLocalDataSourceImplement implements PostsLocalDataSource
{
  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
  
}