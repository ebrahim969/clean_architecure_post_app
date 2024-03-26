import 'package:clean_architicure_posts/core/widgets/custom_btn.dart';
import 'package:clean_architicure_posts/features/posts/domain/entiteis/post.dart';
import 'package:clean_architicure_posts/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:clean_architicure_posts/features/posts/presentation/widgets/custom_txt_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormAddUpdatPost extends StatefulWidget {
  const FormAddUpdatPost({
    super.key,
    required this.isUpdatePost,
    this.post,
  });
  final bool isUpdatePost;
  final Post? post;
  @override
  State<FormAddUpdatPost> createState() => _FormAddUpdatPostState();
}

GlobalKey<FormState> formKey = GlobalKey();
TextEditingController _titleController = TextEditingController();
TextEditingController _bodyController = TextEditingController();

class _FormAddUpdatPostState extends State<FormAddUpdatPost> {
  @override
  void initState() {
    super.initState();
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
              controller: _titleController,
              labelText: widget.isUpdatePost ? "" : "title"),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            controller: _bodyController,
            labelText: widget.isUpdatePost ? "" : "body",
            maxLines: 5,
          ),
          CustomTextButton(
            txt: "add",
            onPressed: validateAndUpdateOrDeletePost,
          )
        ],
      ),
    );
  }

  void validateAndUpdateOrDeletePost() {
    final isValidate = formKey.currentState!.validate();

    if (isValidate) {
      final post = Post(
          id: widget.isUpdatePost ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);

      if (widget.isUpdatePost) {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
