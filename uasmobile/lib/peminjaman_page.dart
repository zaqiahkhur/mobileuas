import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uasmobile/daftar_peminjaman_page.dart';

class PeminjamanPage extends StatefulWidget {
  final String kodeBarang;
  final String namaBarang;

  PeminjamanPage({Key? key, required this.kodeBarang, required this.namaBarang}) : super(key: key);

  @override
  _PeminjamanPageState createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaPeminjamController = TextEditingController();
  final TextEditingController _noidentitasController = TextEditingController();
  final TextEditingController _jumlahbarangController = TextEditingController();
  final TextEditingController _tanggalPinjamController = TextEditingController();
  final TextEditingController _tanggalKembaliController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _keperluanController = TextEditingController();

  @override
  void dispose() {
    _namaPeminjamController.dispose();
    _noidentitasController.dispose();
    _jumlahbarangController.dispose();
    _tanggalPinjamController.dispose();
    _tanggalKembaliController.dispose();
    _statusController.dispose();
    _keperluanController.dispose();
    super.dispose();
  }

 Future<bool> _submitPeminjaman() async {
  try {
    final response = await http.post(
      Uri.parse("http:/10.5.11.7/uasmobile/peminjaman.php"),
      body: {
        "kode_barang": widget.kodeBarang,
        "no_identitas": _noidentitasController.text,
        "Jumlah_barang": _jumlahbarangController.text,
        "tanggal_pinjam": _tanggalPinjamController.text,
        "tanggal_kembali": _tanggalKembaliController.text,
        "status": _statusController.text,
        "keperluan": _keperluanController.text,
      },
    );

    if (response.statusCode == 200) {
      // Jika peminjaman berhasil disimpan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Peminjaman berhasil disimpan'),
        ),
      );

      // Navigasi ke halaman DaftarPeminjamanPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DaftarPeminjamanPage()),
      );

      return true;
    } else {
      throw Exception('Gagal menyimpan peminjaman');
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
        title: Text("Peminjaman Barang"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Kode Barang: ${widget.kodeBarang}"),
                Text("Nama Barang: ${widget.namaBarang}"),
                SizedBox(height: 10),
                TextFormField(
                  controller: _noidentitasController,
                  decoration: InputDecoration(
                    hintText: "No Identitas",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'No Identitas tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _jumlahbarangController,
                  decoration: InputDecoration(
                    hintText: "Jumlah Barang",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jumlah Barang tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _tanggalPinjamController,
                  decoration: InputDecoration(
                    hintText: "Tanggal Pinjam (YYYY-MM-DD)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal Pinjam tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _tanggalKembaliController,
                  decoration: InputDecoration(
                    hintText: "Tanggal Kembali (YYYY-MM-DD)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal Kembali tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _statusController,
                  decoration: InputDecoration(
                    hintText: "Status",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Status tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _keperluanController,
                  decoration: InputDecoration(
                    hintText: "Keperluan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Keperluan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitPeminjaman().then((value) {
                        final snackBar = SnackBar(
                          content: Text(
                            value ? 'Peminjaman berhasil disimpan' : 'Peminjaman gagal disimpan',
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        if (value) {
                          Navigator.of(context).pop();
                        }
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
