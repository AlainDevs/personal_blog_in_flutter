import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/core/service_locator.dart';
import 'src/features/blog/presentation/view_models/blog_list_viewmodel.dart';
import 'src/features/blog/presentation/view_models/blog_post_details_viewmodel.dart';
import 'src/features/blog/presentation/views/blog_list_view.dart';
import 'src/features/blog/presentation/views/blog_post_details_view.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Blog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (_) => BlogListViewModel(locator())..loadPosts(),
        child: const BlogListView(),
      ),
      onGenerateRoute: (settings) {
        if (settings.name?.startsWith('/post/') ?? false) {
          final postId = settings.name!.replaceFirst('/post/', '');
          return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => BlogPostDetailsViewModel(locator(), postId)..loadPost(),
              child: BlogPostDetailsView(postId: postId),
            ),
          );
        }
        return null;
      },
    );
  }
}
