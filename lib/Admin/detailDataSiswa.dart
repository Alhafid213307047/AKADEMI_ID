import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailDataSiswa extends StatelessWidget {
  final DocumentSnapshot doc;

  const DetailDataSiswa({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    String username = (doc['username'] as String?) ?? '-';
    String namaLengkap = (doc['namalengkap'] as String?) ?? '-';
    String asalSekolah = (doc['asalsekolah'] as String?) ?? '-';
    String email = (doc['email'] as String?) ?? '-';
    String tanggalLahir = (doc['tanggallahir'] as String?) ?? '-';
    String noTelepon = (doc['notelepon'] as String?) ?? '-';
    String alamat = (doc['alamat'] as String?) ?? '-';
    String imageUrl = (doc['image'] as String?) ?? '';

    void viewPhotoProfile() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 500,
                height: 500,
                child: Center(
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/profil.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail $username',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20
          ),
        ),
        backgroundColor: Color.fromARGB(255, 46, 155, 233),
        iconTheme: IconThemeData(
          color: Colors.white, // Mengatur warna ikon kembali
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 46, 155, 233),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: viewPhotoProfile,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : AssetImage('assets/images/profil.png')
                            as ImageProvider,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  username,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Nama Lengkap',
                      style: TextStyle(fontFamily: 'Poppins')),
                  subtitle: Text(namaLengkap,
                      style: TextStyle(fontFamily: 'Poppins')),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email', style: TextStyle(fontFamily: 'Poppins')),
                  subtitle:
                      Text(email, style: TextStyle(fontFamily: 'Poppins')),
                ),
                ListTile(
                  leading: Icon(Icons.cake),
                  title: Text('Tanggal Lahir',
                      style: TextStyle(fontFamily: 'Poppins')),
                  subtitle: Text(tanggalLahir,
                      style: TextStyle(fontFamily: 'Poppins')),
                ),
                ListTile(
                  leading: Icon(Icons.school),
                  title: Text('Asal Sekolah',
                      style: TextStyle(fontFamily: 'Poppins')),
                  subtitle: Text(asalSekolah,
                      style: TextStyle(fontFamily: 'Poppins')),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Nomor Telepon',
                      style: TextStyle(fontFamily: 'Poppins')),
                  subtitle:
                      Text(noTelepon, style: TextStyle(fontFamily: 'Poppins')),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title:
                      Text('Alamat', style: TextStyle(fontFamily: 'Poppins')),
                  subtitle:
                      Text(alamat, style: TextStyle(fontFamily: 'Poppins')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
