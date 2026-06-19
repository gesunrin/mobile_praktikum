import '../models/dashboard_model.dart';

class DashboardRepository {
  Future<DashboardData> getDashboardData() async {
    await Future.delayed(const Duration(seconds: 1));

    return DashboardData(
      username: 'Ghefira',
      lastUpdate: DateTime.now(),
      stats: [
        DashboardStats(
          title: 'Total Mahasiswa',
          value: '120',
          subtitle: 'Jumlah mahasiswa',
        ),
        DashboardStats(
          title: 'Mahasiswa Aktif',
          value: '98',
          subtitle: 'Sedang aktif kuliah',
        ),
        DashboardStats(
          title: 'Dosen',
          value: '12',
          subtitle: 'Data dosen',
        ),
        DashboardStats(
          title: 'Mahasiswa Lulus',
          value: '40',
          subtitle: 'Sudah lulus',
        ),
      ],
    );
  }

  Future<DashboardData> refreshDashboard() async {
    return getDashboardData();
  }
}