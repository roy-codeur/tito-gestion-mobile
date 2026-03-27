import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '/config/app_config.dart';
import '../entities/response_data.dart';

class Api {
  final GetStorage _box = GetStorage();
  late final Dio _dio;

  Api() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 9),
        headers: {
          "Accept": "application/json",
        },
      ),
    );

    _initializeInterceptors();
  }

  /// 🔐 Interceptor pour injecter automatiquement le token
  void _initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _box.read('token');

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        onError: (e, handler) {
          // Tu peux gérer ici un logout automatique si 401
          if (e.response?.statusCode == 401) {
            _box.remove('token');
          }

          return handler.next(e);
        },
      ),
    );
  }

  /// 📥 GET
  Future<ResponseData> get(
    String endpoint, {
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: parameters,
      );

      return ResponseData.fromSuccessResponse(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    } catch (_) {
      return ResponseData.customError(message: 'Erreur inattendue');
    }
  }

  /// 📤 POST
  Future<ResponseData> post(
    String endpoint, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
      );

      return ResponseData.fromSuccessResponse(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    } catch (_) {
      return ResponseData.customError(message: 'Erreur inattendue');
    }
  }

  /// ✏️ PUT
  Future<ResponseData> put(
    String endpoint, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
      );

      return ResponseData.fromSuccessResponse(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    } catch (_) {
      return ResponseData.customError(message: 'Erreur inattendue');
    }
  }

  /// ❌ DELETE
  Future<ResponseData> delete(
    String endpoint, {
    dynamic data,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
      );

      return ResponseData.fromSuccessResponse(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    } catch (_) {
      return ResponseData.customError(message: 'Erreur inattendue');
    }
  }

  /// ⚠️ Gestion centralisée des erreurs
  ResponseData _handleError(DioException e) {
    // Pas de réponse → problème réseau
    if (e.response == null) {
      return ResponseData.noInternet();
    }

    // Timeout
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ResponseData.requestTimeout();
    }

    // Réponse serveur
    try {
      return ResponseData.fromErrorResponse(e.response!.data);
    } catch (_) {
      return ResponseData.customError(message: 'Erreur serveur');
    }
  }

  /// 📥 Pour téléchargement (ex: fichiers)
  Dio get downloader {
    _dio.options.baseUrl = AppConfig.appUrl;
    return _dio;
  }
}