import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:mobile_praktikum/features/assets_media/presentation/pages/assets_media_page.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../dosen/presentation/pages/dosen_page.dart';
import '../../../mahasiswa/presentation/pages/mahasiswa_page.dart';
import '../../../mahasiswa_aktif/presentation/pages/mahasiswa_aktif_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/dashboard_widget.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  IconData getIconForStat(String title) {
    switch (title) {
      case 'Total Mahasiswa':
        return Icons.school_rounded;
      case 'Mahasiswa Aktif':
        return Icons.person_outline_rounded;
      case 'Mahasiswa Lulus':
        return Icons.workspace_premium_rounded;
      case 'Dosen':
        return Icons.people_outline_rounded;
      default:
        return Icons.analytics_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    final selectedIndex = ref.watch(selectedStatIndexProvider);

    return Scaffold(
      body: dashboardState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: $error',
          onRetry: () => ref.read(dashboardNotifierProvider.notifier).refresh(),
        ),
        data: (dashboardData) {
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(dashboardNotifierProvider.notifier).refresh(),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.75),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dashboardData.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Update: ${DateFormat('dd MMM yyyy, HH:mm').format(dashboardData.lastUpdate)}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Statistik Kampus',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dashboardData.stats.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    final stat = dashboardData.stats[index];

                    return ModernStatCard(
                      stats: stat,
                      icon: getIconForStat(stat.title),
                      gradientColors: AppConstants.dashboardGradients[
                          index % AppConstants.dashboardGradients.length],
                      isSelected: selectedIndex == index,
                      onTap: () {
                        ref.read(selectedStatIndexProvider.notifier).state =
                            index;

                        Widget? targetPage;

                        switch (stat.title) {
                          case 'Total Mahasiswa':
                            targetPage = const MahasiswaPage();
                            break;
                          case 'Mahasiswa Aktif':
                            targetPage = const MahasiswaAktifPage();
                            break;
                          case 'Dosen':
                            targetPage = const DosenPage();
                            break;
                          case 'Mahasiswa Lulus':
                            targetPage = const ProfilePage();
                            break;
                        }

                        if (targetPage != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => targetPage!,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),

                const SizedBox(height: 24),

                const Text(
                  'Materi Praktikum',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AssetsMediaPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xffeef2ff),
                          child: Icon(
                            Icons.image_outlined,
                            color: Colors.indigo,
                          ),
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Assets dan Media',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Menampilkan gambar dan data JSON dari assets',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}