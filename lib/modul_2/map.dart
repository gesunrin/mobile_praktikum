import 'dart:io';

void main() {
  // =========================
  // A. MAP AWAL (contoh)
  // =========================
  Map<String, String> students = {
    '001': 'ghea',
    '002': 'risha',
    '003': 'naswa',
    '004': 'fanny',
  };

  print('Map awal: $students');

  // =========================
  // B. TAMBAH DATA
  // =========================
  students['005'] = 'delta';
  print('Setelah tambah data: $students');

  // =========================
  // C. TAMPILKAN DATA BERDASARKAN KEY
  // =========================
  print('Data dengan key 002: ${students['002']}');

  // =========================
  // D. UBAH DATA
  // =========================
  students['003'] = 'najwa';
  print('Setelah ubah data key 003: $students');

  // =========================
  // E. HAPUS DATA
  // =========================
  students.remove('005');
  print('Setelah hapus data key 005: $students');

  // =========================
  // F. CEK DATA BERDASARKAN KEY
  // =========================
  print('Apakah key 001 ada? ${students.containsKey('001')}');
  print('Apakah key 005 ada? ${students.containsKey('005')}');

  // =========================
  // G. HITUNG JUMLAH DATA
  // =========================
  print('Jumlah data: ${students.length}');

  // =========================
  // H. TAMPILKAN SEMUA KEY
  // =========================
  print('Semua key: ${students.keys}');

  // =========================
  // I. TAMPILKAN SEMUA VALUE
  // =========================
  print('Semua value: ${students.values}');

  // =========================
  // J. TAMPILKAN SEMUA DATA
  // =========================
  print('Semua data map:');
  students.forEach((key, value) {
    print('$key : $value');
  });

  print('\n==============================');
  print('=== INPUT DATA MAP ===');
  print('==============================');

  // =========================
  // K. INPUT SINGLE
  // =========================
  Map<String, String> dataMap = {};

  stdout.write('Masukkan 1 key: ');
  String keySingle = stdin.readLineSync()!;
  stdout.write('Masukkan 1 value: ');
  String valueSingle = stdin.readLineSync()!;
  dataMap[keySingle] = valueSingle;

  print('Hasil input single: $dataMap');

  // =========================
  // L. INPUT MULTIPLE
  // =========================
  stdout.write('\nMasukkan jumlah data map: ');
  int jumlah = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < jumlah; i++) {
    stdout.write('Masukkan key ke-${i + 1}: ');
    String key = stdin.readLineSync()!;
    stdout.write('Masukkan value ke-${i + 1}: ');
    String value = stdin.readLineSync()!;
    dataMap[key] = value;
  }

  print('\nData map setelah input multiple: $dataMap');

  // =========================
  // M. TAMPILKAN DATA BERDASARKAN KEY
  // =========================
  stdout.write('\nMasukkan key yang ingin ditampilkan: ');
  String cariKey = stdin.readLineSync()!;
  if (dataMap.containsKey(cariKey)) {
    print('Data pada key $cariKey: ${dataMap[cariKey]}');
  } else {
    print('Key tidak ditemukan.');
  }

  // =========================
  // N. UBAH DATA BERDASARKAN KEY
  // =========================
  stdout.write('\nMasukkan key yang ingin diubah: ');
  String ubahKey = stdin.readLineSync()!;
  if (dataMap.containsKey(ubahKey)) {
    stdout.write('Masukkan value baru: ');
    String valueBaru = stdin.readLineSync()!;
    dataMap[ubahKey] = valueBaru;
    print('Setelah diubah: $dataMap');
  } else {
    print('Key tidak ditemukan.');
  }

  // =========================
  // O. HAPUS DATA BERDASARKAN KEY
  // =========================
  stdout.write('\nMasukkan key yang ingin dihapus: ');
  String hapusKey = stdin.readLineSync()!;
  dataMap.remove(hapusKey);
  print('Setelah dihapus: $dataMap');

  // =========================
  // P. CEK KEY
  // =========================
  stdout.write('\nMasukkan key yang ingin dicek: ');
  String cekKey = stdin.readLineSync()!;
  print('Apakah key "$cekKey" ada? ${dataMap.containsKey(cekKey)}');

  // =========================
  // Q. HASIL AKHIR
  // =========================
  print('\n=== HASIL AKHIR ===');
  dataMap.forEach((key, value) {
    print('$key : $value');
  });

  print('Jumlah data akhir: ${dataMap.length}');
  print('Semua key akhir: ${dataMap.keys}');
  print('Semua value akhir: ${dataMap.values}');
}