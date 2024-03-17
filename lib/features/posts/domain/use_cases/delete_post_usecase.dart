import 'package:clean_architicure_posts/core/error/failure.dart';
import 'package:clean_architicure_posts/features/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostsRepo repo;

  DeletePostUseCase(this.repo);

  Future<Either<Failure, Unit>> call(int postId) async {
    return repo.deletePost(postId);
  }
}
