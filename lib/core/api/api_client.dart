import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  static const String hackerNewsBaseUrl =
      'https://hacker-news.firebaseio.com/v0';
  static const String githubBaseUrl = 'https://api.github.com';

  late final Dio hackerNewsClient;
  late final Dio githubClient;

  ApiClient() {
    hackerNewsClient = _createDioClient(hackerNewsBaseUrl);
    githubClient = _createDioClient(githubBaseUrl);
  }

  Dio _createDioClient(String baseUrl) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    return dio;
  }

  void dispose() {
    hackerNewsClient.close();
    githubClient.close();
  }
}
