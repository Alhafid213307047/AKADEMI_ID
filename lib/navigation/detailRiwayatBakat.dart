import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailRiwayatBakat extends StatefulWidget {
  final String docId;

  const DetailRiwayatBakat({Key? key, required this.docId}) : super(key: key);

  @override
  State<DetailRiwayatBakat> createState() => _DetailRiwayatBakatState();
}

class _DetailRiwayatBakatState extends State<DetailRiwayatBakat> {
  Future<Map<String, dynamic>> _fetchTestBakatDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userId = user.uid;
    final historySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('HistoryTesBakat')
        .doc(widget.docId)
        .get();

    final testData = historySnapshot.data()!;

    return {
      'tanggal': testData['tanggal'],
      'tes': [
        'PENGETAHUAN UMUM',
        'KEMAMPUAN VERBAL',
        'KEMAMPUAN ANALISIS-SINTESIS',
        'KEMAMPUAN BERPIKIR LOGIS',
        'KEMAMPUAN PRACTICE-NUMERIC',
        'KEMAMPUAN THEORETIC-NUMERIC',
        'KEMAMPUAN IMAJINASI',
        'KEMAMPUAN SPASIAL',
        'DAYA INGAT & KONSENTRASI',
      ],
      'deskripsi': [
        'Mengukur kemampuan membuat keputusan, rasa realitas, berpikir konkrit praktis, common sense, intuisi',
        'Mengukur kemampuan rasa bahasa, menghayati masalah bahasa, perasaan empati, berpikir induktif dengan menggunakan bahasa, memahami pengertian, komponen intuisi',
        'Mengukur kemampuan mengkombinasi, fleksibilitas berpikir, kedalaman berpikir, tidak suka penyelesaian kira-kira',
        'Mengukur kemampuan abstraksi, pembentukan pengertian, mencari inti persoalan, kemampuan pekerjaan ritmis',
        'Mengukur kemampuan berpikir praktis dengan bilangan, daya nalar, kemampuan menyimpulkan. Penting untuk pekerjaan sekolah khususnya untuk pekerjaan ritmis',
        'Mengukur kemampuan analisa, berpikir induktif dengan bilangan, momen-momen ritmis',
        'Mengukur kemampuan berpikir tiga dimensi atau mengukur visualisasi gambar, bentuk, pola, dan posisi. kemampuan membayangkan, konkrit menyeluruh, konstruktif. Penting untuk pekerjaan tehnik, ahli gigi, dan masinis',
        'Kemampuan membayangkan ruang, komponen konstruktif, moment analitik, berpikir praktis. Penting untuk mengikuti kursus bengkel, matematika, pertukangan, perancang mode, arsitek, ahli tehnik, ahli gigi, masinis',
        'Mengukur daya ingatan, konsentrasi menetap/lama, tanda ketahanan',
      ],
      'skor': [
        testData['TB1'],
        testData['TB2'],
        testData['TB3'],
        testData['TB4'],
        testData['TB5'],
        testData['TB6'],
        testData['TB7'],
        testData['TB8'],
        testData['TB9'],
      ],
      'kategori': [
        testData['CategoryTB1'],
        testData['CategoryTB2'],
        testData['CategoryTB3'],
        testData['CategoryTB4'],
        testData['CategoryTB5'],
        testData['CategoryTB6'],
        testData['CategoryTB7'],
        testData['CategoryTB8'],
        testData['CategoryTB9'],
      ]
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hasil Tes Bakat',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _fetchTestBakatDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Terjadi kesalahan'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('Tidak ada data'));
            }

            final data = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanggal: ${data['tanggal']}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Table(
                      border: TableBorder.all(),
                      columnWidths: {
                        0: FlexColumnWidth(4),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(2),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.green),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Tes',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Skor',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Kategori',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        ...List.generate(9, (index) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['tes'][index],
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data['deskripsi'][index],
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['skor'][index].toString(),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['kategori'][index],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
