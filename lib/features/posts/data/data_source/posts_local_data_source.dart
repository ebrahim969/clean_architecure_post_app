import 'dart:convert';
import 'package:clean_architicure_posts/core/error/exception.dart';
import 'package:clean_architicure_posts/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

class PostsLocalDataSourceImplement implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImplement({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson =
        postModels.map((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString("CACHED_POSTS", json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString("CACHED_POSTS");
    if (jsonString != null) {
      List jsonStringDecode = json.decode(jsonString);
      List<PostModel> jsonToPostModels = jsonStringDecode
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
