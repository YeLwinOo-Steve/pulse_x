import 'package:example/service/api_service.dart';
import 'package:example/view_models/counter_view_model.dart';
import 'package:example/view_models/posts_view_model.dart';
import 'package:example/view_models/quotes_view_model.dart';
import 'package:example/view_models/timer_view_model.dart';
import 'package:pulse_x/pulse_x.dart';

PulseXInjector injector = PulseXInjector.instance;

class DI {
  static void setUp() {
    injector.registerLazySingleton(() => PulseXNavigator());
    injector.registerLazySingleton(
      () => PostService(),
    );
    injector.registerLazySingleton(
      () => QuotesViewModel(),
    );
    injector.registerLazySingleton(
      () => CounterViewModel(),
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
