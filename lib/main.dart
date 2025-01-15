import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_mvvm/core/theme/app_theme.dart';
import 'package:flutter_mvvm/features/news/domain/models/news_item.dart';
import 'package:flutter_mvvm/features/news/presentation/views/news_detail_view.dart';
import 'package:flutter_mvvm/features/news/presentation/views/news_list_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TechPulseApp(),
    ),
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const NewsListView(),
      ),
      GoRoute(
        path: '/detail',
        builder: (context, state) {
          final item = state.extra as NewsItem;
          return NewsDetailView(item: item);
        },
      ),
    ],
  );
});

class TechPulseApp extends ConsumerWidget {
  const TechPulseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'TechPulse',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
