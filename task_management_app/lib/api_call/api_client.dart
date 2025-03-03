// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// // import 'api_config.dart';

// class ApiClient {
//   static final ApiClient _instance = ApiClient._internal();
//   late final Dio _dio;

//   // final FlutterSecureStorage _secureStorageHelper = const FlutterSecureStorage();

//   // Private constructor for Singleton
//   ApiClient._internal() {
//     _dio = Dio(
//       BaseOptions(
//         baseUrl: ApiConfig.baseUrl, // Replace with your base URL
//         connectTimeout: const Duration(seconds: 5),
//         receiveTimeout: const Duration(seconds: 5),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       ),
//     );

//     // Add interceptor for token
//     // _dio.interceptors.add(InterceptorsWrapper(
//     //   onRequest: (options, handler) async {
//     //     // Fetch token from secure storage
//     //     String? token = await _secureStorageHelper.read(key: 'id_token');
//     //     if (token != null) {
//     //       options.headers['Authorization'] = 'Bearer $token';
//     //     }
//     //     return handler.next(options); // Continue with the request
//     //   },
//     //   onError: (error, handler) {
//     //     return handler.next(error); // Continue with the error
//     //   },
//     // ));
//   }

//   factory ApiClient() {
//     return _instance;
//   }

//   // Generic GET request
//   Future<dynamic> get(
//     String endpoint, {
//     Map<String, dynamic>? queryParams,
//     dynamic data,
//   }) async {
//     try {
//       final response = await _dio.get(
//         endpoint,
//         data: data,
//         queryParameters: queryParams,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       _handleError(e);
//     }
//   }

//   // Generic POST request
//   Future<dynamic> post(String endpoint, {dynamic data}) async {
//     try {
//       final response = await _dio.post(endpoint, data: data);
//       return response.data;
//     } on DioException catch (e) {
//       _handleError(e);
//     }
//   }

//   // Generic POST request
//   Future<dynamic> postWithQueryParams(
//     String endpoint, {
//     dynamic data,
//     Map<String, dynamic>? queryParams,
//   }) async {
//     try {
//       final response = await _dio.post(endpoint, data: data, queryParameters: queryParams);
//       return response.data;
//     } on DioException catch (e) {
//       return _handleErrors(e);
//     }
//   }

//   // Error handling function
//   Map<String, dynamic> _handleErrors(DioException e) {
//     if (e.response != null) {
//       if (kDebugMode) {
//         print('❌ API Error: ${e.response?.statusCode} - ${e.response?.data}');
//       }

//       return {
//         'success': false,
//         'statusCode': e.response?.statusCode,
//         'error': e.response?.data ?? 'An error occurred',
//       };
//     } else {
//       if (kDebugMode) {
//         print('❌ API Error: ${e.message}');
//       }

//       return {
//         'success': false,
//         'statusCode': null,
//         'error': 'Network error: ${e.message}',
//       };
//     }
//   }
//   // // Generic POST request
//   // Future<dynamic> postWithQueryParams(String endpoint,
//   //     {dynamic data, Map<String, dynamic>? queryParams}) async {
//   //   try {
//   //     final response =
//   //         await _dio.post(endpoint, data: data, queryParameters: queryParams);
//   //     return response.data;
//   //   } on DioException catch (e) {
//   //     _handleError(e);
//   //   }
//   // }

//   // Generic PUT request
//   Future<dynamic> put(String endpoint, {dynamic data}) async {
//     try {
//       final response = await _dio.put(endpoint, data: data);
//       return response.data;
//     } on DioException catch (e) {
//       _handleError(e);
//     }
//   }

//   // Generic DELETE request
//   Future<dynamic> delete(String endpoint) async {
//     try {
//       final response = await _dio.delete(endpoint);
//       return response.data;
//     } on DioException catch (e) {
//       _handleError(e);
//     }
//   }

//   // Error handling
//   void _handleError(DioException error) {
//     if (error.response != null) {
//       throw ApiException(
//         message: (error.response?.data['message'] ?? 'Unknown error occurred').toString(),
//         statusCode: error.response?.statusCode,
//       );
//     } else {
//       throw ApiException(message: error.message ?? 'An unknown error occurred');
//     }
//   }

//   // Generic POST request for multipart data
//   Future<dynamic> postMultipart(String endpoint, {required FormData formData}) async {
//     try {
//       final response = await _dio.post(
//         endpoint,
//         data: formData,
//         options: Options(
//           headers: {
//             'Content-Type': 'multipart/form-data',
//           },
//         ),
//       );
//       return response.data;
//     } on DioException catch (e) {
//       _handleError(e);
//     }
//   }

// // Generic POST request for URL-encoded data
//   Future<dynamic> postUrlEncoded(String endpoint, {required Map<String, dynamic> data}) async {
//     try {
//       final response = await _dio.post(
//         endpoint,
//         data: FormData.fromMap(data),
//         options: Options(
//           headers: {
//             'Content-Type': 'application/x-www-form-urlencoded',
//           },
//         ),
//       );
//       return response.data;
//     } on DioException catch (e) {
//       _handleError(e);
//     }
//   }
// }

// // Custom exception class
// class ApiException implements Exception {
//   final String message;
//   final int? statusCode;

//   ApiException({required this.message, this.statusCode});

//   @override
//   String toString() => 'ApiException: $message (Status code: $statusCode)';
// }
