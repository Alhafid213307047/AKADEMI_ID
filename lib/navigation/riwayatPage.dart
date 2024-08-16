import 'package:akademi_id/navigation/detailRiwayatBakat.dart';
import 'package:akademi_id/navigation/detailRiwayatKepribadian.dart';
import 'package:akademi_id/navigation/detailRiwayatPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<Map<String, dynamic>> fetchData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userId = user.uid;

    final historyQuery = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('HistoryTesMinat')
        .orderBy('tanggal', descending: true)
        .limit(1)
        .get();

    if (historyQuery.docs.isEmpty) {
      throw Exception('No history documents found');
    }

    final historyDoc = historyQuery.docs.first;
    final historyData = historyDoc.data();
    final rankList = List<String>.from(historyData['rank'] as List<dynamic>);
    final tanggal =
        historyData['tanggal'] as String? ?? 'Tanggal tidak tersedia';

    final rankToDocId = {
      'sos': 'SS',
      'mus': 'MUS',
      'lit': 'LIT',
      'aesth': 'AESTH',
      'cler': 'CLER',
      'pers': 'PERS',
      'sci': 'SCI',
      'comp': 'COMP',
      'prac': 'PRAC',
      'me': 'ME',
      'out': 'OUT',
      'med': 'MED',
    };

    List<String> docIds = [];
    for (int i = 0; i < 3; i++) {
      final rank = i < rankList.length ? rankList[i].toLowerCase() : '';
      final docId = rankToDocId[rank] ?? 'UNKNOWN';
      docIds.add(docId);
    }

    List<String> namaKategoriList = [];
    for (String docId in docIds) {
      final kategoriDoc = await FirebaseFirestore.instance
          .collection('KategoriTesMinat')
          .doc(docId)
          .get();
      final namaKategori = kategoriDoc.exists
          ? (kategoriDoc.data()?['nama'] ?? 'Nama tidak tersedia')
          : 'Kategori tidak ditemukan';
      namaKategoriList.add(namaKategori);
    }

    return {
      'tanggal': tanggal,
      'namaKategori': namaKategoriList,
      'docId': historyDoc.id, // Add this line to include the doc ID
    };
  }

  Future<Map<String, dynamic>> fetchDataBakat() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userId = user.uid;

    final historyQuery = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('HistoryTesBakat')
        .orderBy('tanggal', descending: true)
        .limit(1)
        .get();

    if (historyQuery.docs.isEmpty) {
      throw Exception('No history documents found');
    }

    final historyDoc = historyQuery.docs.first;
    final historyData = historyDoc.data();

    return {
      'tanggal': historyData['tanggal'] as String? ?? 'Tanggal tidak tersedia',
      'tes': [
        'Pengetahuan Umum',
        'Kemampuan Verbal',
        'Kemampuan Analisis-Sintesis',
        'Kemampuan Berpikir Logis',
        'Kemampuan Practice-Numeric',
        'Kemampuan Theoretic-Numeric',
        'Kemampuan Imajinasi',
        'Kemampuan Spasial',
        'Daya Ingat & Konsentrasi'
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
        historyData['TB1'] ?? 0,
        historyData['TB2'] ?? 0,
        historyData['TB3'] ?? 0,
        historyData['TB4'] ?? 0,
        historyData['TB5'] ?? 0,
        historyData['TB6'] ?? 0,
        historyData['TB7'] ?? 0,
        historyData['TB8'] ?? 0,
        historyData['TB9'] ?? 0,
      ],
      'kategori': [
        historyData['CategoryTB1'] ?? 'Kategori tidak tersedia',
        historyData['CategoryTB2'] ?? 'Kategori tidak tersedia',
        historyData['CategoryTB3'] ?? 'Kategori tidak tersedia',
        historyData['CategoryTB4'] ?? 'Kategori tidak tersedia',
        historyData['CategoryTB5'] ?? 'Kategori tidak tersedia',
        historyData['CategoryTB6'] ?? 'Kategori tidak tersedia',
        historyData['CategoryTB7'] ?? 'Kategori tidak tersedia',
        historyData['CategoryTB8'] ?? 'Kategori tidak tersedia',
        historyData['CategoryTB9'] ?? 'Kategori tidak tersedia',
      ],
      'docId': historyDoc.id, // Add this line to include the doc ID
    };
  }

 Future<List<Map<String, dynamic>>> fetchKepribadianData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      final userId = user.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('HistoryKepribadian')
          .get();

      // Pastikan setiap dokumen memiliki ID
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final docId = doc.id; // Ambil ID dokumen
        data['docId'] = docId; // Tambahkan ID dokumen ke data
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text(
                'Tes Minat',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 13
                ),
              ),
            ),
            Tab(
              child: Text(
                'Tes Bakat',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 13
                ),
              ),
            ),
            Tab(
              child: Text(
                'Tes Kepribadian',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 13
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTesMinatContent(),
          _buildTesBakatContent(),
          _buildTesKepribadianContent(),
        ],
      ),
    );
  }

  Widget _buildTesMinatContent() {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          return Center(child: Text('Tidak ada data Riwayat Tes Minat'));
        }

        final data = snapshot.data!;
        final namaKategoriList = data['namaKategori'] as List<String>;
        final docId = data['docId'] as String;

        return ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal: ${data['tanggal']}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Pekerjaan yang disukai :',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                  ...namaKategoriList.asMap().entries.map((entry) {
                    int index = entry.key + 1; // Adding 1 to start index from 1
                    String kategori = entry.value;
                    return Text(
                      '$index. $kategori',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    );
                  }).toList(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailRiwayatPage(docId: docId),
                          ),
                        );
                      },
                      child: Text(
                        'Detail >',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF04558F),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTesBakatContent() {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchDataBakat(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          return Center(child: Text('Tidak ada data Riwayat Tes Bakat'));
        }

        final data = snapshot.data!;
        final namaKategoriList = (data['kategori'] as List<dynamic>)
            .map((e) => e as String)
            .toList();
        final namaTes = data['tes'] as List<String>;
        final docId = data['docId'] as String;

        return ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal: ${data['tanggal']}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  ...namaTes.asMap().entries.map((entry) {
                    int index = entry.key; // Menyimpan indeks
                    String tes = entry.value;
                    String kategori = index < namaKategoriList.length
                        ? namaKategoriList[index]
                        : 'Kategori tidak tersedia';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1}. $tes',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Kategori : $kategori',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 6.0),
                      ],
                    );
                  }).toList(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailRiwayatBakat(docId: docId),
                          ),
                        );
                      },
                      child: Text(
                        'Detail >',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF04558F),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

 Widget _buildTesKepribadianContent() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchKepribadianData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          return Center(child: Text('Tidak ada data Riwayat Tes Kepribadian'));
        }

        final dataList = snapshot.data!;

        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            final data = dataList[index];
            final tanggal =
                data['tanggal'] as String? ?? 'Tanggal tidak tersedia';
            final scoreP =
                data['highscoreP'] as String? ?? 'Kategori tidak tersedia';
            // final scoreK =
            //     data['highscoreK'] as String? ?? 'Kategori tidak tersedia';
            final docId = data['docId'] as String? ?? '';

            final categoryP = getCategoryAndDescription(scoreP);
            // final categoryK = getCategoryAndDescription(scoreK);

            return Container(
              margin: EdgeInsets.only(bottom: 16.0),
              color: Colors.grey[300],
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal: $tanggal',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Kepribadian yang menggambarkan diri Anda:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Kategori : $categoryP',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  // SizedBox(height: 5),
                  // Text(
                  //   'Kepribadian yang tidak menggambarkan diri Anda:',
                  //   style: TextStyle(
                  //     fontFamily: 'Poppins',
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // Text(
                  //   categoryK,
                  //   style: TextStyle(
                  //     fontFamily: 'Poppins',
                  //     fontSize: 16,
                  //   ),
                  // ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (docId.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailRiwayatKepribadian(docId: docId),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('ID dokumen tidak tersedia'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Detail >',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF04558F),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


  String getCategoryAndDescription(String value) {
    switch (value) {
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
        return 'Unknown';
    }
  }

}
