import 'package:dio/dio.dart';
import 'package:mobile_praktikum/core/network/dio_client.dart';
import 'package:mobile_praktikum/features/dosen/data/models/dosen_model.dart';

class DosenRepository {
  final Dio _dio = DioClient.dio;

  Future<List<DosenModel>> getDosenList() async {
    try {
      final response = await _dio.get('/users');
      final List<dynamic> data = response.data as List<dynamic>;

      return data.map((item) {
        return DosenModel.fromJson(item as Map<String, dynamic>);
      }).toList();
    } on DioException catch (e) {
      throw Exception('Gagal memuat data dosen: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}