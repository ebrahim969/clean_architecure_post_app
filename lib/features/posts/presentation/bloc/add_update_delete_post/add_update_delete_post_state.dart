part of 'add_update_delete_post_bloc.dart';

sealed class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

final class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

class LoadingAddUpdateDeletePostState extends AddUpdateDeletePostState {}

class MessageAddUpdateDeletePostState extends AddUpdateDeletePostState {
  final String message;

  const MessageAddUpdateDeletePostState({required this.message});
  @override
  List<Object> get props => [message];
}

class FailureAddUpdateDeletePostState extends AddUpdateDeletePostState {
  final String message;

  const FailureAddUpdateDeletePostState({required this.message});
  @override
  List<Object> get props => [message];
}
