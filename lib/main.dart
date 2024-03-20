import 'package:clean_architicure_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architicure_posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architicure_posts/features/posts/presentation/pages/posts_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injetction_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const PostsApp());
}

class PostsApp extends StatelessWidget {
  const PostsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.sl<AddUpdateDeletePostBloc>())
      ],
      child: const MaterialApp(
        home: PostsView()
      ),
    );
  }
}
