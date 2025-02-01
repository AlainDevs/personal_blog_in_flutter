import 'package:flutter/material.dart';
import '../../../../core/base_viewmodel.dart';
import '../../data/models/blog_post.dart';
import '../../data/repositories/blog_repository.dart';

class BlogListViewModel extends BaseViewModel {
  final IBlogRepository _repository;
  List<BlogPost> _posts = [];
  
  List<BlogPost> get posts => _posts;
  
  BlogListViewModel(this._repository);

  Future<void> loadPosts() async {
    try {
      setLoading(true);
      setError(null);
      _posts = await _repository.getPosts();
      notifyListeners();
    } catch (e) {
      setError('Failed to load blog posts: ${e.toString()}');
      _posts = [];
    } finally {
      setLoading(false);
    }
  }

  void refresh() {
    loadPosts();
  }

  Future<void> navigateToPostDetails(BuildContext context, String postId) async {
    await Navigator.pushNamed(context, '/post/$postId');
  }
}