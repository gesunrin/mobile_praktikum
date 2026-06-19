import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_praktikum/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:mobile_praktikum/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  Future<void> _refreshAll(WidgetRef ref) async {
    await ref.read(mahasiswaNotifierProvider.notifier).refresh();
    ref.invalidate(savedMahasiswaProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);
    final savedMahasiswa = ref.watch(savedMahasiswaProvider);

    return Scaffold(
      backgroundColor: const Color(0xfff6f8fc),
      appBar: AppBar(
        title: const Text(
          'Data Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
            onPressed: () => _refreshAll(ref),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SavedMahasiswaSection(
            savedMahasiswa: savedMahasiswa,
            onRemove: (userId) async {
              await ref
                  .read(mahasiswaNotifierProvider.notifier)
                  .removeSavedMahasiswa(userId);
              ref.invalidate(savedMahasiswaProvider);
            },
            onClear: () async {
              await ref
                  .read(mahasiswaNotifierProvider.notifier)
                  .clearSavedMahasiswa();
              ref.invalidate(savedMahasiswaProvider);
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Mahasiswa',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: mahasiswaState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => _ErrorView(
                message: 'Gagal memuat data mahasiswa: $error',
                onRetry: () => _refreshAll(ref),
              ),
              data: (mahasiswaList) => RefreshIndicator(
                onRefresh: () => _refreshAll(ref),
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: mahasiswaList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final mahasiswa = mahasiswaList[index];

                    return _MahasiswaCard(
                      mahasiswa: mahasiswa,
                      onSave: () async {
                        await ref
                            .read(mahasiswaNotifierProvider.notifier)
                            .saveSelectedMahasiswa(mahasiswa);
                        ref.invalidate(savedMahasiswaProvider);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedMahasiswaSection extends StatelessWidget {
  final AsyncValue<List<Map<String, String>>> savedMahasiswa;
  final Future<void> Function(String userId) onRemove;
  final Future<void> Function() onClear;

  const _SavedMahasiswaSection({
    required this.savedMahasiswa,
    required this.onRemove,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return savedMahasiswa.when(
      loading: () => const Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: LinearProgressIndicator(),
      ),
      error: (error, stackTrace) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Gagal memuat mahasiswa tersimpan: $error'),
      ),
      data: (items) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.bookmark_rounded, color: Colors.teal),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Mahasiswa Tersimpan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (items.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        onClear();
                      },
                      child: const Text('Hapus Semua'),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (items.isEmpty)
                Text(
                  'Belum ada mahasiswa yang disimpan.',
                  style: TextStyle(color: Colors.grey.shade600),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: items.map((item) {
                    final name = item['username'] ?? '-';
                    final userId = item['user_id'] ?? '';

                    return InputChip(
                      avatar: const Icon(Icons.school, size: 18),
                      label: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onDeleted: () {
                        onRemove(userId);
                      },
                    );
                  }).toList(),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _MahasiswaCard extends StatelessWidget {
  final MahasiswaModel mahasiswa;
  final Future<void> Function() onSave;

  const _MahasiswaCard({
    required this.mahasiswa,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          _showDetailDialog(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xffdff7f4),
                child: Text(
                  mahasiswa.id.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mahasiswa.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mahasiswa.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mahasiswa.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await onSave();

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${mahasiswa.name} disimpan'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.bookmark_add_outlined, size: 18),
                      label: const Text('Simpan'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text('Detail Mahasiswa'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DetailTile(
                  icon: Icons.badge_outlined,
                  label: 'ID',
                  value: mahasiswa.id.toString(),
                ),
                _DetailTile(
                  icon: Icons.person_outline,
                  label: 'Nama',
                  value: mahasiswa.name,
                ),
                _DetailTile(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: mahasiswa.email,
                ),
                _DetailTile(
                  icon: Icons.notes_rounded,
                  label: 'Komentar',
                  value: mahasiswa.body,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}

class _DetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xfff1f4fb),
        child: Icon(icon, color: Colors.teal),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade600,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}