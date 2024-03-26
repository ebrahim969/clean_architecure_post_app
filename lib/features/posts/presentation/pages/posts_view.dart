import 'package:clean_architicure_posts/core/widgets/loading_widget.dart';
import 'package:clean_architicure_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architicure_posts/features/posts/presentation/pages/add_update_post_view.dart';
import 'package:clean_architicure_posts/features/posts/presentation/widgets/message_display_widget.dart';
import 'package:clean_architicure_posts/features/posts/presentation/widgets/posts_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFlaotingBtn(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text("Posts"),
        centerTitle: true,
      );

  Widget _buildBody() {
    return BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
      if (state is LoadingPostsState) {
        return const LoadingWidget();
      } else if (state is LoadedPostsState) {
        return RefreshIndicator(
            onRefresh: () => _buildRefresh(context),
            child: PostsListWidget(posts: state.posts));
      } else if (state is FailurePostsState) {
        return MessageDisplayWidget(message: state.errMessage);
      }
      return const LoadingWidget();
    });
  }

  Widget _buildFlaotingBtn(context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                const AddUpdatePostView(isUpdatePost: false)));
      },
      child: const Center(
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _buildRefresh(context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshAllPostsEvent());
  }
}
