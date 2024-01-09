import 'dart:convert';
import 'package:controller/controller.dart';

class Supplier {
  final int id_supplier;
  final String? nama_supplier;

  Supplier({required this.id_supplier, required this.nama_supplier});

  Map<String, dynamic> toMap() =>
      {'id_supplier': id_supplier, 'nama_supplier': nama_supplier};

  final Controller ctrl = Controller();

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
      id_supplier: json['id_supplier'], nama_supplier: json['nama_supplier']);
}

Supplier supplierFromJson(String str) => Supplier.fromJson(json.decode(str));
