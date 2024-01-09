import 'dart:convert';
import 'dart:io';

import 'package:mysql1/mysql1.dart';
import 'lib/pelanggan.dart';
import 'lib/produk.dart';
import 'lib/kategori.dart';
import 'lib/supplier.dart';
import 'lib/api_key.dart';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler)
  ..get('/pelanggan', getPelanggan)
  ..post('/pelangganFilter', filterPelanggan)
  ..post('/pelangganInsert', insertPelanggan)
  ..put('/pelangganUp', upPelanggan)
  ..delete('/pelangganDel', delPelanggan)
  ..get('/produk', getProduk)
  ..post('/produkFilter', filterProduk)
  ..post('/produkInsert', insertProduk)
  ..put('/produkUp', upProduk)
  ..delete('/produkDel', delProduk)
  ..get('/kategori', getKategori)
  ..post('/kategoriFilter', filterKategori)
  ..post('/kategoriInsert', insertKategori)
  ..put('/kategoriUp', upKategori)
  ..delete('/kategoriDel', delKategori)
  ..get('/supplier', getSupplier)
  ..post('/supplierFilter', filterSupplier)
  ..post('/supplierInsert', insertSupplier)
  ..put('/supplierUp', upSupplier)
  ..delete('/supplierDel', delSupplier);

Future<MySqlConnection> _ConnectSql() async {
  var settings = ConnectionSettings(
      host: '127.0.0.1',
      port: 3306,
      user: 'dart2',
      password: 'password',
      db: 'toko_makmur'); //,
  //queryParameters:{
  //'api_key' : pelangganApiKey
  //};
  var cn = await MySqlConnection.connect(settings);
  return cn;
}

///////////////////////User//////////////////////
Future<Response> getPelanggan(Request request) async {
  var conn = await _ConnectSql();
  var users = await conn.query('select * from pelanggan', []);
  return Response.ok(users.toString());
}

//Filter
Future<Response> filterPelanggan(Request request) async {
  String body = await request.readAsString();
  var obj = json.decode(body);
  var nama = "%" + obj['nama'] + "%";
  var conn = await _ConnectSql();
  var users = await conn.query(
      'select * from pelanggan where nama_pelanggan like ?',
      [nama]); //filter nama
  return Response.ok(users.toString());
}

//Insert/Post
Future<Response> insertPelanggan(Request request) async {
  String body = await request.readAsString();
  Pelanggan pelanggan = pelangganFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
  insert into pelanggan (id_pelanggan, nama_pelanggan, alamat, email)
  values(
  '${pelanggan.id_pelanggan}','${pelanggan.nama_pelanggan}','${pelanggan.alamat}','${pelanggan.email}')""";
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from pelanggan where nama_pelanggan = ?";
  var userResponse = await conn.query(sql, [pelanggan.nama_pelanggan]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

//Update/Put
Future<Response> upPelanggan(Request request) async {
  String body = await request.readAsString();
  Pelanggan pelanggan = pelangganFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
      update pelanggan set  
        nama_pelanggan ='${pelanggan.nama_pelanggan}', alamat='${pelanggan.alamat}', 
        email ='${pelanggan.email}'
        where id_pelanggan ='${pelanggan.id_pelanggan}'
    """;
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from pelanggan where id_pelanggan = ?";
  var userResponse = await conn.query(sql, [pelanggan.id_pelanggan]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

//Delete
Future<Response> delPelanggan(Request request) async {
  String body = await request.readAsString();
  Pelanggan pelanggan = pelangganFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
      delete from pelanggan where id_pelanggan ='${pelanggan.id_pelanggan}'
  """;
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from pelanggan where id_pelanggan = ?";
  var userResponse = await conn.query(sql, [pelanggan.id_pelanggan]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

///////////////////////////////Produk/////////////////
Future<Response> getProduk(Request request) async {
  var conn = await _ConnectSql();
  var users = await conn.query('select * from produk', []);
  return Response.ok(users.toString());
}

//Filter
Future<Response> filterProduk(Request request) async {
  String body = await request.readAsString();
  var obj = json.decode(body);
  var nama = "%" + obj['nama'] + "%";
  var conn = await _ConnectSql();
  var users = await conn.query(
      'select * from produk where nama_produk like ?', [nama]); //filter nama
  return Response.ok(users.toString());
}

//Insert/Post
Future<Response> insertProduk(Request request) async {
  String body = await request.readAsString();
  Produk produk = produkFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
  insert into produk (id_produk, nama_produk, harga_produk)
  values(
  '${produk.id_produk}','${produk.nama_produk}','${produk.harga_produk}')""";
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from produk where nama_produk = ?";
  var userResponse = await conn.query(sql, [produk.nama_produk]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

//Update/Put
Future<Response> upProduk(Request request) async {
  String body = await request.readAsString();
  Produk produk = produkFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
      update produk set  
        nama_produk ='${produk.nama_produk}', harga_produk='${produk.harga_produk}' 
        where id_produk ='${produk.id_produk}'
    """;
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from produk where id_produk = ?";
  var userResponse = await conn.query(sql, [produk.id_produk]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

//Delete
Future<Response> delProduk(Request request) async {
  String body = await request.readAsString();
  Produk produk = produkFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
      delete from produk where id_produk ='${produk.id_produk}'
  """;
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from produk where id_produk = ?";
  var userResponse = await conn.query(sql, [produk.id_produk]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

///////////Kategori///////////////
Future<Response> getKategori(Request request) async {
  var conn = await _ConnectSql();
  var users = await conn.query('select * from kategori', []);
  return Response.ok(users.toString());
}

//Filter
Future<Response> filterKategori(Request request) async {
  String body = await request.readAsString();
  var obj = json.decode(body);
  var nama = "%" + obj['nama'] + "%";
  var conn = await _ConnectSql();
  var users = await conn.query(
      'select * from kategori where nama_kategori like ?',
      [nama]); //filter nama
  return Response.ok(users.toString());
}

//Insert/Post
Future<Response> insertKategori(Request request) async {
  String body = await request.readAsString();
  Kategori kategori = kategoriFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
  insert into kategori (id_kategori, nama_kategori)
  values(
  '${kategori.id_kategori}','${kategori.nama_kategori}')""";
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from kategori where nama_kategori = ?";
  var userResponse = await conn.query(sql, [kategori.nama_kategori]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

//Update/Put
Future<Response> upKategori(Request request) async {
  String body = await request.readAsString();
  Kategori kategori = kategoriFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
      update kategori set  
        nama_kategori ='${kategori.nama_kategori}' 
        where id_kategori ='${kategori.id_kategori}'
    """;
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from kategori where id_kategori = ?";
  var userResponse = await conn.query(sql, [kategori.id_kategori]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

//Delete
Future<Response> delKategori(Request request) async {
  String body = await request.readAsString();
  Kategori kategori = kategoriFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
      delete from kategori where id_kategori ='${kategori.id_kategori}'
  """;
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from kategori where id_kategori = ?";
  var userResponse = await conn.query(sql, [kategori.id_kategori]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

/////////Supplier/////////////
Future<Response> getSupplier(Request request) async {
  var conn = await _ConnectSql();
  var users = await conn.query('select * from supplier', []);
  return Response.ok(users.toString());
}

//Filter
Future<Response> filterSupplier(Request request) async {
  String body = await request.readAsString();
  var obj = json.decode(body);
  var nama = "%" + obj['nama'] + "%";
  var conn = await _ConnectSql();
  var users = await conn.query(
      'select * from supplier where nama_supplier like ?',
      [nama]); //filter nama
  return Response.ok(users.toString());
}

//Insert/Post
Future<Response> insertSupplier(Request request) async {
  String body = await request.readAsString();
  Supplier supplier = supplierFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
  insert into supplier (id_supplier, nama_supplier)
  values(
  '${supplier.id_supplier}','${supplier.nama_supplier}')""";
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from supplier where nama_supplier = ?";
  var userResponse = await conn.query(sql, [supplier.nama_supplier]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

//Update/Put
Future<Response> upSupplier(Request request) async {
  String body = await request.readAsString();
  Supplier supplier = supplierFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
      update supplier set  
        nama_supplier ='${supplier.nama_supplier}' 
        where id_supplier ='${supplier.id_supplier}'
    """;
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from supplier where id_supplier = ?";
  var userResponse = await conn.query(sql, [supplier.id_supplier]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

//Delete
Future<Response> delSupplier(Request request) async {
  String body = await request.readAsString();
  Supplier supplier = supplierFromJson(body);
  var conn = await _ConnectSql();
  var sqlExecute = """
      delete from supplier where id_supplier ='${supplier.id_supplier}'
  """;
  var execute = await conn.query(sqlExecute, []);
  var sql = "select * from supplier where id_supplier = ?";
  var userResponse = await conn.query(sql, [supplier.id_supplier]);
  //var response = _responseSuccessMsg(userResponse.toString());
  return Response.ok(userResponse.toString());
}

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
