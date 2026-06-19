import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_praktikum/features/dosen/data/models/dosen_model.dart';
import 'package:mobile_praktikum/features/dosen/presentation/providers/dosen_provider.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  Future<void> _refreshAll(WidgetRef ref) async {
    await ref.read(dosenNotifierProvider.notifier).refresh();
    ref.invalidate(savedUsersProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);
    final savedUsers = ref.watch(savedUsersProvider);

    return Scaffold(
      backgroundColor: const Color(0xfff6f8fc),
      appBar: AppBar(
        title: const Text(
          'Data Dosen',
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
          _SavedUsersSection(
            savedUsers: savedUsers,
            onRemove: (userId) async {
              await ref
                  .read(dosenNotifierProvider.notifier)
                  .removeSavedUser(userId);
              ref.invalidate(savedUsersProvider);
            },
            onClear: () async {
              await ref.read(dosenNotifierProvider.notifier).clearSavedUsers();
              ref.invalidate(savedUsersProvider);
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Dosen',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: dosenState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => _ErrorView(
                message: 'Gagal memuat data dosen: $error',
                onRetry: () => _refreshAll(ref),
              ),
              data: (dosenList) => RefreshIndicator(
                onRefresh: () => _refreshAll(ref),
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: dosenList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final dosen = dosenList[index];

                    return _DosenCard(
                      dosen: dosen,
                      onSave: () async {
                        await ref
                            .read(dosenNotifierProvider.notifier)
                            .saveSelectedDosen(dosen);
                        ref.invalidate(savedUsersProvider);
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

class _SavedUsersSection extends StatelessWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;
  final Future<void> Function(String userId) onRemove;
  final Future<void> Function() onClear;

  const _SavedUsersSection({
    required this.savedUsers,
    required this.onRemove,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return savedUsers.when(
      loading: () => const Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: LinearProgressIndicator(),
      ),
      error: (error, stackTrace) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Gagal memuat data tersimpan: $error'),
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
                  const Icon(Icons.bookmark_rounded, color: Colors.indigo),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Dosen Tersimpan',
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
                  'Belum ada dosen yang disimpan.',
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
                      avatar: const Icon(Icons.person, size: 18),
                      label: Text(name),
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

class _DosenCard extends StatelessWidget {
  final DosenModel dosen;
  final Future<void> Function() onSave;

  const _DosenCard({
    required this.dosen,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28,
              child: Text(
                dosen.id.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dosen.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('@${dosen.username}'),
                  const SizedBox(height: 4),
                  Text(dosen.email),
                  const SizedBox(height: 4),
                  Text('${dosen.address.street}, ${dosen.address.city}'),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await onSave();

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${dosen.username} disimpan'),
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