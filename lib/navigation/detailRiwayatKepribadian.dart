import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailRiwayatKepribadian extends StatefulWidget {
  final String docId;
  const DetailRiwayatKepribadian({Key? key, required this.docId})
      : super(key: key);

  @override
  State<DetailRiwayatKepribadian> createState() => _DetailRiwayatKepribadianState();
}

class _DetailRiwayatKepribadianState extends State<DetailRiwayatKepribadian> {
  late Future<Map<String, dynamic>> _data;

  @override
  void initState() {
    super.initState();
    print('Document ID: ${widget.docId}'); 
    _data = fetchKepribadianDetail();
  }

  Future<Map<String, dynamic>> fetchKepribadianDetail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      final userId = user.uid;

      // Pastikan docId tidak null atau kosong
      if (widget.docId.isEmpty) {
        throw Exception('Document ID is empty');
      }

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('HistoryKepribadian')
          .doc(widget.docId)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        throw Exception('Dokumen tidak ditemukan');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }


  String getCategoryAndDescription(String score) {
    switch (score) {
      case 'D':
        return 'Dominance';
      case 'I':
        return 'Influence';
      case 'S':
        return 'Steadiness';
      case 'C':
        return 'Compliance';
      case 'D-I':
        return 'Dominance - Influence';
      case 'D-S':
        return 'Dominance - Steadiness';
      case 'D-C':
        return 'Dominance - Compliance';
      case 'I-S':
        return 'Influence - Steadiness';
      case 'I-C':
        return 'Influence - Compliance';
      case 'S-C':
        return 'Steadiness - Compliance';
      default:
        return 'Kategori tidak tersedia';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hasil Kepribadian',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final data = snapshot.data!;
            final tanggal = data['tanggal'] ?? 'Tidak tersedia';
            final scoreP = data['highscoreP'] ?? 'Tidak tersedia';
            final deskripsiP = data['deskripsiP'] ?? 'Tidak tersedia';
            // final scoreK = data['highscoreK'] ?? 'Tidak tersedia';
            // final deskripsiK = data['deskripsiK'] ?? 'Tidak tersedia';

            final categoryP = getCategoryAndDescription(scoreP);
            // final categoryK = getCategoryAndDescription(scoreK);

            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tanggal,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Kepribadian yang menggambarkan diri anda:',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Kategori',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Center(
                    child: Text(
                      '$categoryP',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    deskripsiP,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  // Text(
                  //   'Kepribadian yang tidak menggambarkan diri anda:',
                  //   style: TextStyle(
                  //     fontFamily: 'Poppins',
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // SizedBox(height: 10),
                  // Text(
                  //   'Kategori: $categoryK',
                  //   style: TextStyle(
                  //     fontFamily: 'Poppins',
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // Text(
                  //   deskripsiK,
                  //   style: TextStyle(
                  //     fontFamily: 'Poppins',
                  //   ),
                  //   textAlign: TextAlign.justify,
                  // ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
