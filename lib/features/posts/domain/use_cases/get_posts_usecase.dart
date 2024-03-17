import 'package:clean_architicure_posts/core/error/failure.dart';
import 'package:clean_architicure_posts/features/posts/domain/entiteis/post.dart';
import 'package:clean_architicure_posts/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase {
  final PostsRepo repo;

  GetAllPostsUseCase(this.repo);

  Future<Either<Failure, List<Post>>> call() async {
    return repo.getAllPosts();
  }
}
