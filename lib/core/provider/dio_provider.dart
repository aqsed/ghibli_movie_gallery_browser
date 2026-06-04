import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _URL = 'https://ghibliapi.vercel.app';
const _DEFAULT_TIMEOUT_DURATION = Duration(seconds: 10);

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: _URL,
      connectTimeout: _DEFAULT_TIMEOUT_DURATION,
      receiveTimeout: _DEFAULT_TIMEOUT_DURATION,
      sendTimeout: _DEFAULT_TIMEOUT_DURATION,
    ),
  );

  dio.interceptors.add(LogInterceptor(requestBody: true));

  return dio;
});
