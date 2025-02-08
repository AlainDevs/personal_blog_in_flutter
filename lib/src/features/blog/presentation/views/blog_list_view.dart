import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../view_models/blog_list_viewmodel.dart';
import '../widgets/blog_post_card.dart';

class BlogListView extends StatelessWidget {
  const BlogListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isDesktop =
            sizingInformation.deviceScreenType == DeviceScreenType.desktop;
        final padding = isDesktop ? 24.0 : 8.0;

        return Scaffold(
          appBar: AppBar(
            leading: !isDesktop
                ? IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  )
                : null,
            title: const Text('Tech Blog'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<BlogListViewModel>().refresh();
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Navigation Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    // Navigate to Home
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                ListTile(
                  title: const Text('Categories'),
                  onTap: () {
                    // Navigate to Categories
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('About'),
                  onTap: () {
                    // Navigate to About
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: Consumer<BlogListViewModel>(
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

              if (viewModel.posts.isEmpty) {
                return const Center(
                  child: Text('No blog posts available'),
                );
              }

              if (isDesktop) {
                // Calculate dimensions for desktop grid
                final screenWidth = MediaQuery.of(context).size.width;
                final availableWidth = screenWidth - (2 * padding);
                final cardSpacing = 16.0;
                final maxCardWidth = 300.0; // Maximum width for each card
                final crossAxisCount = ((availableWidth + cardSpacing) /
                        (maxCardWidth + cardSpacing))
                    .floor();
                final cardWidth =
                    (availableWidth - (crossAxisCount - 1) * cardSpacing) /
                        crossAxisCount;

                // Calculate height based on content
                final imageHeight = cardWidth * (9 / 16); // AspectRatio 16:9
                final contentHeight =
                    200.0; // Fixed content height (title + excerpt + metadata)
                final cardHeight = imageHeight + contentHeight;

                return Padding(
                  padding: EdgeInsets.all(padding),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: cardSpacing,
                      mainAxisSpacing: cardSpacing,
                      childAspectRatio: cardWidth / cardHeight,
                    ),
                    itemCount: viewModel.posts.length,
                    itemBuilder: (context, index) {
                      final post = viewModel.posts[index];
                      return BlogPostCard(
                        post: post,
                        onTap: () =>
                            viewModel.navigateToPostDetails(context, post.id),
                        isDesktop: true,
                      );
                    },
                  ),
                );
              }

              // Mobile list view
              final imageHeight = MediaQuery.of(context).size.width * (9 / 16);
              final contentHeight = 200.0;
              final cardHeight = imageHeight + contentHeight;

              return ListView.builder(
                padding: EdgeInsets.all(padding),
                itemCount: viewModel.posts.length,
                itemBuilder: (context, index) {
                  final post = viewModel.posts[index];
                  return SizedBox(
                    height: cardHeight,
                    child: BlogPostCard(
                      post: post,
                      onTap: () =>
                          viewModel.navigateToPostDetails(context, post.id),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
