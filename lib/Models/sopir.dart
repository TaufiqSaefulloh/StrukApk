class Sopir {
  final int? id;
  final String nama_sopir;
  final String email;
  final String token;

  // Konstruktor
  Sopir({
    required this.id,
    required this.nama_sopir,
    required this.email,
    required this.token,
  });

  // Method untuk membuat objek Sopir dari JSON
  factory Sopir.fromJson(Map<String, dynamic> json) {
    return Sopir(
      id: json['id'],
      nama_sopir: json['nama_sopir'],
      email: json['email'],
      token: json['token'],
    );
  }

  // Method untuk mengubah objek Sopir menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_sopir': nama_sopir,
      'email': email,
      'token': token,
    };
  }
}
