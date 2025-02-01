import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../view_models/blog_post_details_viewmodel.dart';
import 'package:intl/intl.dart';

class BlogPostDetailsView extends StatelessWidget {
  final String postId;

  const BlogPostDetailsView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop = sizingInformation.deviceScreenType == DeviceScreenType.desktop;
        
        return Scaffold(
          body: Consumer<BlogPostDetailsViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (viewModel.error != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        viewModel.error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: viewModel.refresh,
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }

              final post = viewModel.post;
              if (post == null) {
                return const Center(
                  child: Text('Post not found'),
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        post.title,
                        style: const TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 3.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      background: post.thumbnailUrl != null
                          ? Image.asset(
                              post.thumbnailUrl!,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: Theme.of(context).primaryColor,
                            ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 
                            MediaQuery.of(context).size.width * 0.2 : 16.0,
                        vertical: 24.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person_outline),
                              const SizedBox(width: 8),
                              Text(post.author),
                              const SizedBox(width: 16),
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 8),
                              Text(DateFormat.yMMMd().format(post.publishDate)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (post.tags.isNotEmpty) ...[
                            Wrap(
                              spacing: 8,
                              children: post.tags
                                  .map((tag) => Chip(
                                        label: Text(tag),
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 24),
                          ],
                          Text(
                            post.content,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}