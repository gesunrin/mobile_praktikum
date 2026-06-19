import 'dart:io';

void main() {
  // =========================
  // A. LIST AWAL (contoh)
  // =========================
  List<String> names = ['ghea', 'risha', 'naswa', 'fanny'];
  print('Names awal: $names');

  // =========================
  // B. TAMBAH DATA
  // =========================
  names.add('delta');
  print('Setelah ditambah: $names');

  // =========================
  // C. TAMPIL INDEX
  // =========================
  print('Elemen pertama: ${names[0]}');
  print('Elemen kedua: ${names[1]}');

  // =========================
  // D. UBAH DATA
  // =========================
  names[2] = 'najwa';
  print('Setelah diubah: $names');

  // =========================
  // E. HAPUS DATA
  // =========================
  names.remove('delta');
  print('Setelah dihapus: $names');

  // =========================
  // F. HITUNG JUMLAH
  // =========================
  print('Jumlah data: ${names.length}');

  // =========================
  // G. LOOPING
  // =========================
  print('Menampilkan semua data:');
  for (String name in names) {
    print(name);
  }

  print('\n==============================');
  print('=== INPUT DATA LIST ===');
  print('==============================');

  // =========================
  // H. INPUT DATA
  // =========================
  List<String> dataList = [];

  stdout.write('Masukkan jumlah data: ');
  int jumlah = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < jumlah; i++) {
    stdout.write('Data ke-${i + 1}: ');
    String data = stdin.readLineSync()!;
    dataList.add(data);
  }

  print('\nData list: $dataList');

  // =========================
  // I. TAMPIL BERDASARKAN INDEX
  // =========================
  stdout.write('\nMasukkan index yang ingin ditampilkan: ');
  int index = int.parse(stdin.readLineSync()!);
  print('Data pada index $index: ${dataList[index]}');

  // =========================
  // J. UBAH DATA
  // =========================
  stdout.write('\nMasukkan index yang ingin diubah: ');
  int indexUbah = int.parse(stdin.readLineSync()!);
  stdout.write('Masukkan data baru: ');
  String newData = stdin.readLineSync()!;
  dataList[indexUbah] = newData;
  print('Setelah diubah: $dataList');

  // =========================
  // K. HAPUS DATA
  // =========================
  stdout.write('\nMasukkan index yang ingin dihapus: ');
  int indexHapus = int.parse(stdin.readLineSync()!);
  dataList.removeAt(indexHapus);
  print('Setelah dihapus: $dataList');

  // =========================
  // L. HASIL AKHIR
  // =========================
  print('\n=== HASIL AKHIR ===');
  for (int i = 0; i < dataList.length; i++) {
    print('Index $i: ${dataList[i]}');
  }

  print('Jumlah data akhir: ${dataList.length}');
}