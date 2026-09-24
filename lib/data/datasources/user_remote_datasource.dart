import 'package:dio/dio.dart';

import '../../core/network/dio_client.dart';
import '../models/user_model.dart';

class UserRemoteDataSource {
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await DioClient.dio.get(
        'https://randomuser.me/api/?results=20',
      );

      print('STATUS CODE: ${response.statusCode}');
      print('RESPONSE TYPE: ${response.data.runtimeType}');

      if (response.statusCode != 200) {
        throw Exception(
          'API Status Code: ${response.statusCode}',
        );
      }

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid API response');
      }

      final results = data['results'];

      if (results is! List) {
        throw Exception('results is not a List');
      }

      print('USERS COUNT: ${results.length}');

      return results
          .map(
            (json) => UserModel.fromJson(
          Map<String, dynamic>.from(json),
        ),
      )
          .toList();
    } on DioException catch (e) {
      print('DIO ERROR: ${e.type}');
      print('DIO MESSAGE: ${e.message}');
      print('DIO RESPONSE: ${e.response?.data}');

      throw Exception(
        e.message ?? 'Network request failed',
      );
    } catch (e) {
      print('USER API ERROR: $e');

      throw Exception(
        e.toString(),
      );
    }
  }
}