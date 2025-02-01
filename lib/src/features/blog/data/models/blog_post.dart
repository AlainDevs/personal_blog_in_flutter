class BlogPost {
  final String id;
  final String title;
  final String content;
  final String author;
  final DateTime publishDate;
  final String? thumbnailUrl;
  final List<String> tags;

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.publishDate,
    this.thumbnailUrl,
    this.tags = const [],
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      publishDate: DateTime.parse(json['publishDate'] as String),
      thumbnailUrl: json['thumbnailUrl'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'publishDate': publishDate.toIso8601String(),
      'thumbnailUrl': thumbnailUrl,
      'tags': tags,
    };
  }
}