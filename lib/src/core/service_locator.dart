import 'package:get_it/get_it.dart';
import '../features/blog/data/repositories/blog_repository.dart';

final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  locator.registerLazySingleton<IBlogRepository>(() => MockBlogRepository());
}