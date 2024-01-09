import 'dart:convert';
import 'package:controller/controller.dart';

class Kategori {
  final int id_kategori;
  final String? nama_kategori;

  Kategori({required this.id_kategori, required this.nama_kategori});

  Map<String, dynamic> toMap() =>
      {'id_kategori': id_kategori, 'nama_kategori': nama_kategori};

  final Controller ctrl = Controller();

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
      id_kategori: json['id_kategori'], nama_kategori: json['nama_kategori']);
}

Kategori kategoriFromJson(String str) => Kategori.fromJson(json.decode(str));
