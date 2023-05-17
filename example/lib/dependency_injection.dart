import 'package:example/service/api_service.dart';
import 'package:example/view_models/posts_view_model.dart';
import 'package:example/view_models/quotes_view_model.dart';
import 'package:example/view_models/timer_view_model.dart';
import 'package:pulse/pulse.dart';

PulseInjector injector = PulseInjector.instance;

class DI {
  static void setUp() {
    injector.registerLazySingleton(
      () => PostService(),
    );
    injector.registerLazySingleton(
      () => QuotesViewModel(),
    );
    final service = injector.find<PostService>();
    injector.registerLazySingleton(
      () => PostsViewModel(
        service: service,
      ),
    );
    injector.registerLazySingleton(
      () => TimerViewModel(),
    );
  }
}
