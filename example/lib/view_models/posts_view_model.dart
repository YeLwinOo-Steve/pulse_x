import 'dart:math';
import 'package:example/models/post.dart';
import 'package:example/service/api_service.dart';
import 'package:pulse/pulse.dart';

class PostsViewModel extends PulseFutureViewModel {
  final ApiService service;
  PostsViewModel({required this.service});
  @override
  void onInit() {
    super.onInit();
    _fetchPosts();
  }

  void _fetchPosts() async {
    changeState(PulseState.loading());
    try {
      List<Post> posts = await service.getPosts();
      changeState(PulseState.loaded(
        posts,
      ));
    } catch (ex) {
      changeState(PulseState.error(ex.toString()));
    }
  }
}
