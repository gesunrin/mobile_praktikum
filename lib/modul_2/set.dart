import 'dart:io';

void main() {
  // =========================
  // A. SET AWAL (contoh)
  // =========================
  Set<String> names = {'ghea', 'risha', 'naswa', 'fanny'};
  print('Set awal: $names');

  // =========================
  // B. TAMBAH DATA
  // =========================
  names.add('delta');
  print('Setelah tambah data: $names');

  // =========================
  // C. TAMBAH DATA DUPLICATE
  // =========================
  names.add('ghea');
  print('Setelah tambah duplicate (ghea): $names');
  print('Catatan: data duplicate tidak ditambahkan pada Set');

  // =========================
  // D. HAPUS DATA
  // =========================
  names.remove('delta');
  print('Setelah hapus data: $names');

  // =========================
  // E. CEK DATA TERTENTU
  // =========================
  print('Apakah ada "risha"? ${names.contains('risha')}');
  print('Apakah ada "delta"? ${names.contains('delta')}');

  // =========================
  // F. HITUNG JUMLAH DATA
  // =========================
  print('Jumlah data: ${names.length}');

  // =========================
  // G. TAMPILKAN SEMUA DATA
  // =========================
  print('Semua data pada set:');
  for (String name in names) {
    print(name);
  }

  print('\n==============================');
  print('=== INPUT DATA SET ===');
  print('==============================');

  // =========================
  // H. INPUT DATA SET
  // =========================
  Set<String> dataSet = {};

  stdout.write('Masukkan jumlah data: ');
  int jumlah = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < jumlah; i++) {
    stdout.write('Data ke-${i + 1}: ');
    String data = stdin.readLineSync()!;
    dataSet.add(data);
  }

  print('\nData set: $dataSet');

  // =========================
  // I. TAMBAH DATA BARU
  // =========================
  stdout.write('\nMasukkan data yang ingin ditambahkan: ');
  String tambahData = stdin.readLineSync()!;
  dataSet.add(tambahData);
  print('Setelah tambah data: $dataSet');

  // =========================
  // J. TAMBAH DATA DUPLICATE
  // =========================
  stdout.write('\nMasukkan data duplicate yang ingin ditambahkan: ');
  String duplicateData = stdin.readLineSync()!;
  dataSet.add(duplicateData);
  print('Setelah tambah duplicate: $dataSet');
  print('Catatan: jika data sama, Set tidak akan menambah data baru.');

  // =========================
  // K. HAPUS DATA
  // =========================
  stdout.write('\nMasukkan data yang ingin dihapus: ');
  String hapusData = stdin.readLineSync()!;
  dataSet.remove(hapusData);
  print('Setelah hapus data: $dataSet');

  // =========================
  // L. CEK DATA
  // =========================
  stdout.write('\nMasukkan data yang ingin dicek: ');
  String cekData = stdin.readLineSync()!;
  print('Apakah "$cekData" ada? ${dataSet.contains(cekData)}');

  // =========================
  // M. HASIL AKHIR
  // =========================
  print('\n=== HASIL AKHIR ===');
  for (String item in dataSet) {
    print(item);
  }
  print('Jumlah data akhir: ${dataSet.length}');
}