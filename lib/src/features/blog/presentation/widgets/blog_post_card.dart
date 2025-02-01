import 'package:flutter/material.dart';
import '../../data/models/blog_post.dart';
import 'package:intl/intl.dart';

class BlogPostCard extends StatelessWidget {
  const BlogPostCard({
    super.key,
    required this.post,
    required this.onTap,
    this.isDesktop = false,
  });

  final bool isDesktop;
  final VoidCallback onTap;
  final BlogPost post;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(isDesktop ? 16.0 : 8.0),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.thumbnailUrl != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  post.thumbnailUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post.content.split('\n').first,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'By ${post.author}',
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(post.publishDate),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        if (post.tags.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 24,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: post.tags
                                  .map((tag) => Padding(
                                        padding: const EdgeInsets.only(right: 4),
                                        child: Chip(
                                          visualDensity: VisualDensity.compact,
                                          labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                                          label: Text(
                                            tag,
                                            style: const TextStyle(fontSize: 11),
                                          ),
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          padding: EdgeInsets.zero,
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}