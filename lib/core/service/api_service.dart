import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../features/home/domain/entities/bond.dart';
import '../../features/home/domain/entities/bond_detail.dart';

@injectable
class ApiService {
  final Dio _dio;

  static const String _baseUrl = 'https://eol122duf9sy4de.m.pipedream.net';

  ApiService(this._dio) {
    // Configure Dio with default options
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );

    // Add interceptors if needed
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          if (kDebugMode) {
            print(object);
          }
        },
      ),
    );
  }

  Future<List<Bond>> getCompanies() async {
    try {
      final response = await _dio.get('/companies');

      final List<dynamic> companiesJson = response.data['data'];
      return companiesJson.map((json) => Bond.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw HttpException(
          'Failed to load companies: ${e.response!.statusCode}',
        );
      } else {
        throw Exception('Error fetching companies: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error fetching companies: $e');
    }
  }
}
