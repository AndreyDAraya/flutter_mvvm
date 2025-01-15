import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm/features/news/domain/models/news_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsDetailView extends StatelessWidget {
  final NewsItem item;

  const NewsDetailView({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: theme.colorScheme.surface,
            surfaceTintColor: theme.colorScheme.surface,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: theme.colorScheme.primary,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://www.transparenttextures.com/patterns/asfalt-dark.png',
                  ),
                  repeat: ImageRepeat.repeat,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(theme),
                    const SizedBox(height: 24),
                    Text(
                      item.title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildMetadata(theme),
                    if (item.text != null) ...[
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary
                              .withAlpha(8), // 0.03 * 255
                          border: Border.all(
                            color: theme.colorScheme.primary
                                .withAlpha(51), // 0.2 * 255
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _stripHtmlTags(item.text!),
                          style: GoogleFonts.lora(
                            fontSize: 18,
                            height: 1.8,
                            color: theme.colorScheme.primary
                                .withAlpha(204), // 0.8 * 255
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    if (item.url != null) ...[
                      _buildUrlSection(theme),
                      const SizedBox(height: 32),
                    ],
                    _buildActions(context, theme),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Text(
          'TECH YORK TIME',
          style: GoogleFonts.unifrakturCook(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: theme.colorScheme.primary.withAlpha(51), // 0.2 * 255
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Vol. ${item.id % 100}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: theme.colorScheme.primary.withAlpha(179), // 0.7 * 255
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: theme.colorScheme.primary.withAlpha(51), // 0.2 * 255
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetadata(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withAlpha(13), // 0.05 * 255
        border: Border.all(
          color: theme.colorScheme.primary.withAlpha(51), // 0.2 * 255
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Posted by ${item.by}',
                style: GoogleFonts.lora(
                  color: theme.colorScheme.primary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildStatItem(
                theme,
                icon: Icons.arrow_upward,
                value: '${item.score}',
                label: 'points',
              ),
              const SizedBox(width: 24),
              _buildStatItem(
                theme,
                icon: Icons.comment,
                value: '${item.descendants}',
                label: 'comments',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    ThemeData theme, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: GoogleFonts.oswald(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.lora(
            color: theme.colorScheme.primary.withAlpha(179), // 0.7 * 255
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildUrlSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary.withAlpha(51), // 0.2 * 255
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Source',
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () => _launchUrl(item.url!),
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.link,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      Uri.parse(item.url!).host,
                      style: GoogleFonts.lora(
                        color: theme.colorScheme.primary,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (item.url != null) ...[
          _buildActionButton(
            theme,
            icon: Icons.open_in_browser,
            label: 'Open in Browser',
            onTap: () => _launchUrl(item.url!),
          ),
          const SizedBox(width: 16),
        ],
        _buildActionButton(
          theme,
          icon: Icons.share,
          label: 'Share',
          onTap: () => _shareUrl(context),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colorScheme.primary.withAlpha(51), // 0.2 * 255
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.lora(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  Future<void> _shareUrl(BuildContext context) async {
    if (item.url != null) {
      await Clipboard.setData(ClipboardData(text: item.url!));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Link copied to clipboard',
              style: GoogleFonts.lora(),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  String _stripHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}
