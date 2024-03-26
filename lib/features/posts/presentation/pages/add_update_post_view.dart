import 'package:clean_architicure_posts/core/widgets/loading_widget.dart';
import 'package:clean_architicure_posts/features/posts/domain/entiteis/post.dart';
import 'package:clean_architicure_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architicure_posts/features/posts/presentation/pages/posts_view.dart';
import 'package:clean_architicure_posts/features/posts/presentation/widgets/add_update_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdatePostView extends StatelessWidget {
  const AddUpdatePostView({super.key, required this.isUpdatePost, this.post});
  final Post? post;
  final bool isUpdatePost;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAddUpdatePostAppBar(),
      body: _buildAddUpdatePostBody(context),
    );
  }

  AppBar _buildAddUpdatePostAppBar() => AppBar(
        title: Text(isUpdatePost ? "Update Post" : "Add Post"),
      );

  Widget _buildAddUpdatePostBody(context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
            builder: ((context, state) {
          if (state is LoadingAddUpdateDeletePostState) {
            return const LoadingWidget();
          }
          return FormAddUpdatPost(
            isUpdatePost: isUpdatePost,
            post: isUpdatePost ? post : null,
          );
        }), listener: ((context, state) {
          if (state is MessageAddUpdateDeletePostState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ));
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const PostsView()),
                (route) => false);
          } else if (state is FailureAddUpdateDeletePostState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ));
          }
        })),
      ),
    );
  }
}
