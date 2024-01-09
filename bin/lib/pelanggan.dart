import 'dart:convert';
import 'package:controller/controller.dart';

class Pelanggan {
  final int id_pelanggan;
  final String? nama_pelanggan;
  final String? alamat;
  final String? email;

  Pelanggan(
      {required this.id_pelanggan,
      required this.nama_pelanggan,
      required this.alamat,
      required this.email});

  Map<String, dynamic> toMap() => {
        'id_pelanggan': id_pelanggan,
        'nama_pelanggan': nama_pelanggan,
        'alamat': alamat,
        'email': email
      };

  final Controller ctrl = Controller();

  factory Pelanggan.fromJson(Map<String, dynamic> json) => Pelanggan(
      id_pelanggan: json['id_pelanggan'],
      nama_pelanggan: json['nama_pelanggan'],
      alamat: json['alamat'],
      email: json['email']);
}

Pelanggan pelangganFromJson(String str) => Pelanggan.fromJson(json.decode(str));
