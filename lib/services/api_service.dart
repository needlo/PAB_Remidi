import 'package:dio/dio.dart';
import 'package:spacenews_core/core/constants/app_strings.dart';
import 'package:spacenews_core/models/article_model.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppStrings.apiBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: false,
        logPrint: (obj) => obj.toString(),
      ),
    );
  }

  /// Fetches a list of articles from the Spaceflight News API.
  ///
  /// [limit] - The maximum number of articles to fetch. Defaults to 20.
  /// Returns a list of [ArticleModel] objects.
  Future<List<ArticleModel>> getArticles({int limit = 20}) async {
    try {
      final response = await _dio.get(
        '/articles/',
        queryParameters: {
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final List<dynamic> results = data['results'] as List<dynamic>? ?? [];

        return results
            .map((json) => ArticleModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load articles. Status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      String errorMessage;

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          errorMessage = 'Connection timed out. Please check your internet connection.';
          break;
        case DioExceptionType.receiveTimeout:
          errorMessage = 'Server took too long to respond. Please try again.';
          break;
        case DioExceptionType.sendTimeout:
          errorMessage = 'Request timed out. Please try again.';
          break;
        case DioExceptionType.connectionError:
          errorMessage = AppStrings.networkError;
          break;
        case DioExceptionType.badResponse:
          errorMessage = 'Server returned an error: ${e.response?.statusCode}';
          break;
        case DioExceptionType.cancel:
          errorMessage = 'Request was cancelled.';
          break;
        default:
          errorMessage = AppStrings.genericError;
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(AppStrings.fetchArticlesError);
    }
  }
}
