import '../models/blog_post.dart';

abstract class IBlogRepository {
  Future<List<BlogPost>> getPosts();
  Future<BlogPost?> getPostById(String id);
}

class MockBlogRepository implements IBlogRepository {
  final List<BlogPost> _mockPosts = [
    BlogPost(
      id: '1',
      title: 'Getting Started with Flutter',
      content: '''
Flutter is a powerful framework for building cross-platform applications. In this post, we'll explore the basics of Flutter development and how to get started with your first app.

## Key Points
- Setting up your development environment
- Understanding widgets
- State management basics
- Building your first app

Flutter's widget-based architecture makes it easy to create beautiful, native applications for mobile, web, and desktop from a single codebase.
      ''',
      author: 'John Doe',
      publishDate: DateTime.now().subtract(const Duration(days: 5)),
      thumbnailUrl: 'assets/images/flutter_logo.png',
      tags: ['Flutter', 'Mobile Development', 'Getting Started'],
    ),
    BlogPost(
      id: '2',
      title: 'MVVM in Flutter',
      content: '''
Model-View-ViewModel (MVVM) is an architectural pattern that helps separate business logic from UI code. This post explores implementing MVVM in Flutter using Provider.

## Topics Covered
- MVVM basics
- Provider setup
- State management
- Code organization

Learn how to structure your Flutter applications for better maintainability and testability.
      ''',
      author: 'Jane Smith',
      publishDate: DateTime.now().subtract(const Duration(days: 2)),
      thumbnailUrl: 'assets/images/flutter_logo.png',
      tags: ['Flutter', 'Architecture', 'MVVM', 'Provider'],
    ),
  ];

  @override
  Future<List<BlogPost>> getPosts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return _mockPosts;
  }

  @override
  Future<BlogPost?> getPostById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockPosts.firstWhere(
      (post) => post.id == id,
      orElse: () => throw Exception('Post not found'),
    );
  }
}