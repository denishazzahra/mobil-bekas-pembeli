class User {
  int? id;
  String? nama;
  String? username;
  String? kota;
  String? notelepon;

  User({this.id, this.nama, this.username, this.kota, this.notelepon});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    username = json['username'];
    kota = json['kota'];
    notelepon = json['notelepon'];
  }
}
