import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'edit_data_page.dart';
import 'tambah_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listdata = [];
  bool _isloading = true;

  Future<void> _getdata() async {
    try {
      final response = await http.get(Uri.parse("http://10.5.11.7/uasmobile/read.php"));
      if (response.statusCode == 200) {
        setState(() {
          _listdata = json.decode(response.body);
          _isloading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      setState(() {
        _isloading = false;
      });
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
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peminjaman Barang Baknus'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("qias"),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("path_to_your_image.jpg"),
              ),
              decoration: BoxDecoration(
                color: Colors.indigo[300],
              ),
            ),
            ListTile(
              title: Text('Daftar Barang'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/second');
              },
            ),
            ListTile(
              title: Text('Daftar peminjaman'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/third');
              },
            ),
            ListTile(
              title: Text('Daftar peminjam'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/fourth');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'path_to_your_image.jpg', // Update with your image asset path
            //   height: 200,
            //   width: 200,
            // ),
            SizedBox(height: 20),
            Text("Peminjaman Barang Baknus 666"),
          ],
        ),
      ),
    );
  }
}
