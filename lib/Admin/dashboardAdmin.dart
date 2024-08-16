import 'package:akademi_id/Admin/dataSiswa.dart';
import 'package:akademi_id/Admin/hasilTesSiswa.dart';
import 'package:akademi_id/screen/loginOption.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _adminName;

  @override
  void initState() {
    super.initState();
    _fetchAdminData();
  }

  Future<void> _fetchAdminData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot adminDoc =
          await _firestore.collection('Admin').doc(user.uid).get();
      setState(() {
        _adminName = adminDoc['nama'];
      });
    }
  }

  Future<void> _confirmLogout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi Keluar',
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Apakah Anda yakin ingin keluar akun?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Tidak',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Ya',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await _handleLogout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleLogout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 2));

    Navigator.pop(context);
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginOption()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard Admin',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _confirmLogout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Kolom pertama
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins'),
                          ),
                          SizedBox(height: 5),
                          Text(
                            _adminName ?? 'Loading...',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                    // Kolom kedua
                    Image.asset('assets/images/halo.png', height: 100),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            HasilTesSiswa(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Warna tombol biru
                    minimumSize:
                        Size(double.infinity, 45), // Lebar tombol infinity
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Radius tombol 12
                    ),
                  ),
                  child: Text(
                    'Hasil Tes Siswa',
                    style:
                        TextStyle(fontFamily: 'Poppins', color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            DataSiswa(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Warna tombol biru
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Radius tombol 12
                    ),
                  ),
                  child: Text(
                    'Data Siswa',
                    style:
                        TextStyle(fontFamily: 'Poppins', color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
