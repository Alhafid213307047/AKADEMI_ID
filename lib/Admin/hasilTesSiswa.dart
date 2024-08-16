import 'package:akademi_id/Admin/detailHasilTes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HasilTesSiswa extends StatefulWidget {
  const HasilTesSiswa({super.key});

  @override
  State<HasilTesSiswa> createState() => _HasilTesSiswaState();
}

class _HasilTesSiswaState extends State<HasilTesSiswa> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _searchQuery = '';

  Future<List<DocumentSnapshot>> _fetchUserData() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('Users').orderBy('username').get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hasil Tes Siswa',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                labelText:
                    'Cari berdasarkan username, nama lengkap, atau asal sekolah',
                labelStyle: TextStyle(fontFamily: "Poppins"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<DocumentSnapshot>>(
              future: _fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Text('Tidak ada data',
                          style: TextStyle(fontFamily: 'Poppins')));
                }

                List<DocumentSnapshot> userDocs = snapshot.data!;

                // Filter data berdasarkan pencarian
                List<DocumentSnapshot> filteredDocs = userDocs.where((doc) {
                  String username =
                      (doc['username'] as String?)?.toLowerCase() ?? '';
                  String namaLengkap =
                      (doc['namalengkap'] as String?)?.toLowerCase() ?? '';
                  String asalSekolah =
                      (doc['asalsekolah'] as String?)?.toLowerCase() ?? '';

                  return username.contains(_searchQuery) ||
                      namaLengkap.contains(_searchQuery) ||
                      asalSekolah.contains(_searchQuery);
                }).toList();

                return SingleChildScrollView(
                  child: Column(
                    children: filteredDocs.map((doc) {
                      String docId = doc.id; // Ambil docId dari dokumen
                      String username =
                          (doc['username'] as String?)?.isEmpty ?? true
                              ? '-'
                              : doc['username'];
                      String namaLengkap =
                          (doc['namalengkap'] as String?)?.isEmpty ?? true
                              ? '-'
                              : doc['namalengkap'];
                      String asalSekolah =
                          (doc['asalsekolah'] as String?)?.isEmpty ?? true
                              ? '-'
                              : doc['asalsekolah'];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 16.0),
                        padding: const EdgeInsets.all(12.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username : $username',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Nama Lengkap : $namaLengkap',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Asal Sekolah : $asalSekolah',
                              style: TextStyle(
                                  fontFamily: 'Poppins', fontSize: 14),
                            ),
                            SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        DetailHasilTesSiswa(docId: docId),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin =
                                          Offset(1.0, 0.0); // Mulai dari kanan
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                          position: offsetAnimation,
                                          child: child);
                                    },
                                  ),
                                );
                              },
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Detail >',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
