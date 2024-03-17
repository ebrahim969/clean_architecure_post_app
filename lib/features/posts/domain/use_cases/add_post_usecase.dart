import 'package:clean_architicure_posts/core/error/failure.dart';
import 'package:clean_architicure_posts/features/posts/domain/entiteis/post.dart';
import 'package:clean_architicure_posts/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

class AddPostUseCase {
  final PostsRepo repo;

  AddPostUseCase(this.repo);

  Future<Either<Failure, Unit>> call(Post post) async {
    return repo.addPost(post);
  }
}
