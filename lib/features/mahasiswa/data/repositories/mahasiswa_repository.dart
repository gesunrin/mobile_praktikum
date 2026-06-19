import 'package:dio/dio.dart';
import 'package:mobile_praktikum/core/network/dio_client.dart';
import 'package:mobile_praktikum/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  final Dio _dio = DioClient.dio;

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final response = await _dio.get('/comments');
      final List<dynamic> data = response.data as List<dynamic>;

      return data.take(20).map((item) {
        return MahasiswaModel.fromJson(item as Map<String, dynamic>);
      }).toList();
    } on DioException catch (e) {
      throw Exception('Gagal memuat data mahasiswa: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}