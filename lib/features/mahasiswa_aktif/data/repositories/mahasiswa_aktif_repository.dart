import 'package:dio/dio.dart';
import 'package:mobile_praktikum/core/network/dio_client.dart';
import 'package:mobile_praktikum/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  final Dio _dio = DioClient.dio;

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    try {
      final response = await _dio.get('/posts');
      final List<dynamic> data = response.data;

      return data
          .take(20)
          .map((e) => MahasiswaAktifModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Gagal mengambil data mahasiswa aktif: $e');
    }
  }
}