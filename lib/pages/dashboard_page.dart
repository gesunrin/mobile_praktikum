import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Consumer<DashboardProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                buildMenuItem(
                  context,
                  'Mahasiswa',
                  Icons.school,
                  Colors.blue,
                  provider.mahasiswa,
                  provider.tambahMahasiswa,
                ),
                const SizedBox(height: 15),
                buildMenuItem(
                  context,
                  'Dosen',
                  Icons.person,
                  Colors.green,
                  provider.dosen,
                  provider.tambahDosen,
                ),
                const SizedBox(height: 15),
                buildMenuItem(
                  context,
                  'Mata Kuliah',
                  Icons.book,
                  Colors.orange,
                  provider.matakuliah,
                  provider.tambahMataKuliah,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    int total,
    VoidCallback onTap,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 30),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Total: $total',
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add_circle, size: 30),
          onPressed: onTap,
        ),
      ),
    );
  }
}