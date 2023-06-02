import 'dart:math';
import 'package:example/models/post.dart';
import 'package:example/service/api_service.dart';
import 'package:pulse_x/pulse_x.dart';

class PostsViewModel extends PulseXFutureViewModel {
  final ApiService service;
  PostsViewModel({required this.service});
  @override
  void onInit() {
    super.onInit();
    _fetchPosts();
  }

  void _fetchPosts() async {
    changeState(PulseXState.loading());
    try {
      List<Post> posts = await service.getPosts();
      changeState(PulseXState.loaded(
        posts,
      ));
    } catch (ex) {
      changeState(PulseXState.error(ex.toString()));
    }
  }
}
