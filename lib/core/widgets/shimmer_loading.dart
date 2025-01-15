import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class NewsCardShimmer extends StatelessWidget {
  const NewsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shadowColor: theme.colorScheme.primary.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          image: const DecorationImage(
            image: NetworkImage(
              'https://www.transparenttextures.com/patterns/paper.png',
            ),
            repeat: ImageRepeat.repeat,
            opacity: 0.03,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: const ShimmerLoading(
                    width: 80,
                    height: 14,
                  ),
                ),
                const Spacer(),
                const ShimmerLoading(
                  width: 60,
                  height: 12,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerLoading(
                    height: 24,
                    width: double.infinity,
                  ),
                  SizedBox(height: 8),
                  ShimmerLoading(
                    height: 24,
                    width: 300,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            size: 16,
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.2),
                          ),
                          const SizedBox(width: 4),
                          const ShimmerLoading(
                            width: 30,
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    const ShimmerLoading(
                      width: 40,
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.comment,
                            size: 16,
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.2),
                          ),
                          const SizedBox(width: 4),
                          const ShimmerLoading(
                            width: 30,
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    const ShimmerLoading(
                      width: 40,
                      height: 10,
                    ),
                  ],
                ),
                const Spacer(),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ShimmerLoading(
                      width: 100,
                      height: 12,
                    ),
                    SizedBox(height: 4),
                    ShimmerLoading(
                      width: 80,
                      height: 12,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
