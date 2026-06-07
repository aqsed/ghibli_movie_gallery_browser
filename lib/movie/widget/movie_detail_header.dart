import 'package:flutter/material.dart';

const _EXPANDED_HEIGHT = 330.0;

class MovieDetailHeader extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final String? heroTag;

  const MovieDetailHeader({
    super.key,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    this.actions = const [],
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      pinned: true,
      expandedHeight: _EXPANDED_HEIGHT,
      foregroundColor: Colors.white,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            _buildBannerImage(theme),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.72)],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        shadows: const [Shadow(offset: Offset(0, 1), blurRadius: 10)],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitle!,
                        style: theme.textTheme.titleMedium?.copyWith(color: Colors.white.withValues(alpha: 0.86)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerImage(ThemeData theme) {
    final image = Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => ColoredBox(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Icon(Icons.movie_rounded, size: 54, color: theme.colorScheme.onSurfaceVariant),
      ),
    );

    return heroTag == null ? image : Hero(tag: heroTag!, child: image);
  }
}
