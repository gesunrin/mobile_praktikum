void main() {
  // =========================
  // OBJECT DASAR
  // =========================
  Mahasiswa mhs1 = Mahasiswa("Ghea", "Informatika");
  mhs1.tampilkanData();

  print("\n=== MAHASISWA AKTIF ===");
  var aktif = MahasiswaAktif("Risha", "Sistem Informasi", 4);
  aktif.tampilkanData();
  aktif.tampilkanSemester();

  print("\n=== MAHASISWA ALUMNI ===");
  var alumni = MahasiswaAlumni("Naswa", "Teknik Informatika", 2023);
  alumni.tampilkanData();
  alumni.tampilkanLulus();

  print("\n=== DOSEN (MIXIN) ===");
  var dosen = Dosen("Pak Budi", "Informatika");
  dosen.tampilkanData();
  dosen.mengajar();
  dosen.meneliti();
  dosen.ngoding();
}

// =========================
// CLASS DASAR
// =========================
class Mahasiswa {
  String nama;
  String jurusan;

  Mahasiswa(this.nama, this.jurusan);

  void tampilkanData() {
    print("Nama: $nama");
    print("Jurusan: $jurusan");
  }
}

// =========================
// EXTENDS (PEWARISAN)
// =========================
class MahasiswaAktif extends Mahasiswa {
  int semester;

  MahasiswaAktif(super.nama, super.jurusan, this.semester);

  void tampilkanSemester() {
    print("Semester: $semester");
  }
}

class MahasiswaAlumni extends Mahasiswa {
  int tahunLulus;

  MahasiswaAlumni(super.nama, super.jurusan, this.tahunLulus);

  void tampilkanLulus() {
    print("Lulus tahun: $tahunLulus");
  }
}

// =========================
// MIXIN
// =========================
mixin BisaNgajar {
  void mengajar() {
    print("Sedang mengajar");
  }
}

mixin BisaMeneliti {
  void meneliti() {
    print("Sedang meneliti");
  }
}

mixin BisaNgoding {
  void ngoding() {
    print("Sedang coding");
  }
}

// =========================
// CLASS DOSEN (PAKAI MIXIN)
// =========================
class Dosen extends Mahasiswa
    with BisaNgajar, BisaMeneliti, BisaNgoding {
  Dosen(super.nama, super.jurusan);
}