import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architicure_posts/core/error/failure.dart';
import 'package:clean_architicure_posts/core/utils/strings/failure_messages.dart';
import 'package:clean_architicure_posts/core/utils/strings/success_messages.dart';
import 'package:clean_architicure_posts/features/posts/domain/entiteis/post.dart';
import 'package:clean_architicure_posts/features/posts/domain/use_cases/add_post_usecase.dart';
import 'package:clean_architicure_posts/features/posts/domain/use_cases/delete_post_usecase.dart';
import 'package:clean_architicure_posts/features/posts/domain/use_cases/update_post_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;
  AddUpdateDeletePostBloc(
      {required this.addPost,
      required this.updatePost,
      required this.deletePost})
      : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdateDeletePostState());
        final messageOrFailurePost = await addPost(event.post);
        emit(failureOrMessageState(messageOrFailurePost, ADD_POST_SUCCESS));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddUpdateDeletePostState());
        final messageOrFailurePost = await updatePost(event.post);
        emit(failureOrMessageState(messageOrFailurePost, UPDATE_POST_SUCCESS));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddUpdateDeletePostState());
        final messageOrFailurePost = await deletePost(event.postId);
        emit(failureOrMessageState(messageOrFailurePost, DELETE_POST_SUCCESS));
      }
    });
  }

  AddUpdateDeletePostState failureOrMessageState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) =>
          FailureAddUpdateDeletePostState(message: _getFailures(failure)),
      (_) => MessageAddUpdateDeletePostState(message: message),
    );
  }

  String _getFailures(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "UnExcepected error, please try again later";
    }
  }
}
