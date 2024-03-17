import 'package:clean_architicure_posts/core/error/failure.dart';
import 'package:clean_architicure_posts/features/posts/domain/entiteis/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepo {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(Post post);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> deletePost(int id);
}
