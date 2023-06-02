import 'package:example/dependency_injection.dart';
import 'package:example/models/post.dart';
import 'package:example/view_models/posts_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pulse_x/pulse_x.dart';

final red500 = Colors.red.shade500;
const amber = Colors.amber;
final amber200 = Colors.amber.shade200;
final indigo100 = Colors.indigo.shade100;
const indigo = Colors.indigoAccent;

class PostsView extends StatefulWidget {
  PostsView({Key? key}) : super(key: key);

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  final postViewModel = injector.find<PostsViewModel>();
  late PulseXReaction reaction;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reaction = PulseXReaction(postViewModel, (value, dispose) {
      if (value.status == PulseXStatus.loaded) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                '🥳 Hooray!!, Posts have been loaded!',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: indigo,
                    ),
              ),
            ),
            backgroundColor: indigo100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 8.0,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            behavior: SnackBarBehavior.floating,
            showCloseIcon: true,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    reaction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: PulseXFutureBuilder(
        viewModel: postViewModel,
        builder: (_, PulseXState<dynamic> state, __) {
          if (state.status == PulseXStatus.error) {
            return ErrorMessage(message: '${state.message}');
          } else if (state.status == PulseXStatus.loaded) {
            return const PostList();
          }
          return const Center(
            child: CupertinoActivityIndicator(
              radius: 20,
              color: amber,
            ),
          );
        },
      ),
    );
  }
}

class PostList extends StatelessWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = PulseXStateManager.of<PostsViewModel>(context);
    PulseXState? state = viewModel?.value;
    List<Post> posts = state?.value as List<Post>;
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: amber200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(
              8.0,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 6.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  posts[index].title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  posts[index].body,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ));
      },
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: red500,
            ),
      ),
    );
  }
}
