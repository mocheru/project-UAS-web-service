import 'dart:convert';
import 'package:controller/controller.dart';

class Produk {
  final int id_produk;
  final String? nama_produk;
  final double harga_produk;

  Produk(
      {required this.id_produk,
      required this.nama_produk,
      required this.harga_produk});

  Map<String, dynamic> toMap() => {
        'id_produk': id_produk,
        'nama_produk': nama_produk,
        'harga_produk': harga_produk
      };

  final Controller ctrl = Controller();

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
      id_produk: json['id_produk'],
      nama_produk: json['nama_produk'],
      harga_produk: json['harga_produk']);
}

Produk produkFromJson(String str) => Produk.fromJson(json.decode(str));
