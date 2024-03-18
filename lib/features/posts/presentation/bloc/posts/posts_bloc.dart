import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architicure_posts/core/error/failure.dart';
import 'package:clean_architicure_posts/core/utils/strings/failure_messages.dart';
import 'package:clean_architicure_posts/features/posts/domain/entiteis/post.dart';
import 'package:clean_architicure_posts/features/posts/domain/use_cases/get_posts_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts.call();
        emit(failureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState failureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => FailurePostsState(errMessage: _getFailures(failure)),
      (posts) => LoadedPostsState(posts: posts),
    );
  }

  String _getFailures(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure _:
        return EMPTY_CACHED_FAILURE_MESSAGE;
      default:
        return "UnExcepected error, please try again later";
    }
  }
}
