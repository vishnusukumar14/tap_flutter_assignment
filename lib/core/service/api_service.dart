import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../features/home/domain/entities/company.dart';
import '../../features/home/domain/entities/company_detail.dart';

@injectable
class ApiService {
  final Dio _dio;

  static const String _baseUrl = 'https://eol122duf9sy4de.m.pipedream.net';
  static const String _detailBaseUrl =
      'https://eo61q3zd4heiwke.m.pipedream.net';

  ApiService(this._dio) {
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

  Future<List<Company>> getCompanies() async {
    try {
      final response = await _dio.get('/#');

      final List<dynamic> companiesJson = response.data['data'];
      return companiesJson.map((json) => Company.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        throw HttpException(
          'Failed to load companies: ${e.response!.statusCode}',
        );
      } else {
        throw Exception('Error fetching company lists: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error fetching company lists: $e');
    }
  }

  Future<CompanyDetail> getCompanyDetail() async {
    try {
      // Temporarily override baseUrl
      final response = await _dio.get(
        '$_detailBaseUrl/#',
        options: Options(
          // You can override headers or timeouts here if needed
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      return CompanyDetail.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Error fetching company detail: ${e.message}');
    }
  }
}
