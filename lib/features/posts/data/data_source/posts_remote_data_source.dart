// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:clean_architicure_posts/core/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:clean_architicure_posts/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPost();
  Future<Unit> addPost(PostModel post);
  Future<Unit> updatePost(PostModel post);
  Future<Unit> deletePost(int id);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImplement implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImplement({required this.client});

  @override
  Future<List<PostModel>> getAllPost() async {
    final response = await client.get(Uri.parse("$BASE_URL/posts/"),
        headers: {'Content-Type': "aplication/json"});
    if (response.statusCode == 200) {
      final responseDecoded = json.decode(response.body) as List;
      final List<PostModel> postModels = responseDecoded
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final body = {'title': post.title, 'body': post.body};

    final response =
        await client.post(Uri.parse("$BASE_URL/posts/"), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response =
        await client.delete(Uri.parse("$BASE_URL/posts/${id.toString()}"));
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final String postId = post.id.toString();
    final body = {'title': post.title, 'body': post.body};
    final response = await client.patch(Uri.parse("$BASE_URL/posts/$postId"),
        body: body, headers: {'Content-Type': "aplication/json"});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

}
