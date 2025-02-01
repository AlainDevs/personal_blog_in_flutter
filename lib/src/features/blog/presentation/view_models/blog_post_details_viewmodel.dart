import '../../../../core/base_viewmodel.dart';
import '../../data/models/blog_post.dart';
import '../../data/repositories/blog_repository.dart';

class BlogPostDetailsViewModel extends BaseViewModel {
  final IBlogRepository _repository;
  final String postId;
  BlogPost? _post;

  BlogPost? get post => _post;

  BlogPostDetailsViewModel(this._repository, this.postId);

  Future<void> loadPost() async {
    try {
      setLoading(true);
      setError(null);
      _post = await _repository.getPostById(postId);
      notifyListeners();
    } catch (e) {
      setError('Failed to load blog post: ${e.toString()}');
      _post = null;
    } finally {
      setLoading(false);
    }
  }

  void refresh() {
    loadPost();
  }
}