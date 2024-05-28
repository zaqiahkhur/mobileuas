import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uasmobile/edit_p.dart';

class DaftarPeminjamPage extends StatefulWidget {
  @override
  _DaftarPeminjamPageState createState() => _DaftarPeminjamPageState();
}

class _DaftarPeminjamPageState extends State<DaftarPeminjamPage> {
  List<Map<String, dynamic>> _dataPeminjam = [];

  @override
  void initState() {
    super.initState();
    _fetchDataPeminjam();
  }

  Future<void> _fetchDataPeminjam() async {
    try {
      final response = await http.get(
        Uri.parse("http://10.5.11.7/uasmobile/readpeminjam.php"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _dataPeminjam = data.cast<Map<String, dynamic>>();
        });
      } else {
        throw Exception('Gagal mengambil data peminjam');
      }
    } catch (e) {
      print(e);
    }
  }
  Future<bool> _hapus(String id) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.5.11.7/uasmobile/delete.php"),
        body: {"id": id},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Peminjam'),
      ),
      body: _dataPeminjam.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _dataPeminjam.length,
              itemBuilder: (context, index) {
                final peminjam = _dataPeminjam[index];
                return ListTile(
                  onTap: (){
                     Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditpPage(
                                  ListData: {
                                    "id": peminjam['id'],
                                    "no_identitas": peminjam['No_identitas'],
                                    "nama": peminjam['Nama'],
                                    "kelas": peminjam['Kelas'],
                                    "jurusan": peminjam['Jurusan'],
                                  },
                                ),
                              ),
                            );
                          },
                  title: Text('No Identitas: ${peminjam['No_identitas']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text('Nama: ${peminjam['Nama']}'),
                        Text('Kelas : ${peminjam['Kelas']}'),
                      Text('jurusan: ${peminjam['Jurusan']}'),

                      // Tambahkan informasi peminjaman lainnya sesuai kebutuhan
                    ],
                  ),
                );
              },
            ),
            
    );
  }
}
