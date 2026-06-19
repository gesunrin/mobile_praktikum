import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_praktikum/core/services/local_storage_service.dart';
import 'package:mobile_praktikum/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:mobile_praktikum/features/mahasiswa/data/repositories/mahasiswa_repository.dart';

final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

final mahasiswaLocalStorageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final savedMahasiswaProvider =
    FutureProvider.autoDispose<List<Map<String, String>>>((ref) async {
  final storage = ref.watch(mahasiswaLocalStorageProvider);
  return storage.getSavedMahasiswa();
});

class MahasiswaNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  final LocalStorageService _storage;

  MahasiswaNotifier(this._repository, this._storage)
      : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();

    try {
      final mahasiswaList = await _repository.getMahasiswaList();
      state = AsyncValue.data(mahasiswaList);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaList();
  }

  Future<void> saveSelectedMahasiswa(MahasiswaModel mahasiswa) async {
    await _storage.addMahasiswaToSavedList(
      userId: mahasiswa.id.toString(),
      username: mahasiswa.name,
    );
  }

  Future<void> removeSavedMahasiswa(String userId) async {
    await _storage.removeSavedMahasiswa(userId);
  }

  Future<void> clearSavedMahasiswa() async {
    await _storage.clearSavedMahasiswa();
  }
}

final mahasiswaNotifierProvider =
    StateNotifierProvider.autoDispose<MahasiswaNotifier,
        AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  final storage = ref.watch(mahasiswaLocalStorageProvider);

  return MahasiswaNotifier(repository, storage);
});