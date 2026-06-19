import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_praktikum/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:mobile_praktikum/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repository.dart';

final mahasiswaAktifRepositoryProvider =
    Provider<MahasiswaAktifRepository>((ref) {
  return MahasiswaAktifRepository();
});

final mahasiswaAktifListProvider =
    FutureProvider<List<MahasiswaAktifModel>>((ref) async {
  final repository = ref.read(mahasiswaAktifRepositoryProvider);
  return repository.getMahasiswaAktifList();
});