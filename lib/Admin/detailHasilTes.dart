import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class DetailHasilTesSiswa extends StatefulWidget {
  final String docId; // Menggunakan docId sebagai parameter

  const DetailHasilTesSiswa({super.key, required this.docId});

  @override
  State<DetailHasilTesSiswa> createState() => _DetailHasilTesSiswaState();
}

class _DetailHasilTesSiswaState extends State<DetailHasilTesSiswa> {
  Future<Map<String, dynamic>> _fetchUserData(String docId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(docId).get();

    if (!userDoc.exists) {
      throw Exception('User data not found');
    }

    final data = userDoc.data() ?? {};
    final namaLengkap = data['namalengkap'] ?? '-';
    final namaSekolah = data['asalsekolah'] ?? '-';

    return {
      'namaLengkap': namaLengkap,
      'namaSekolah': namaSekolah,
    };
  }

  Future<List<Map<String, dynamic>>> _fetchDataMinat(String docId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userId = user.uid;

    print('Fetching data for userId: $userId and docId: $docId'); // Debugging

    // Mengambil data dari koleksi HistoryTesMinat berdasarkan docId
    final historyCollection = await FirebaseFirestore.instance
        .collection('Users')
        .doc(docId) // Menggunakan docId untuk mengambil koleksi HistoryTesMinat
        .collection('HistoryTesMinat')
        .get(); // Mengambil semua dokumen dalam koleksi

    if (historyCollection.docs.isEmpty) {
      return []; // Mengembalikan list kosong jika tidak ada data
    }

    List<Map<String, dynamic>> results = [];

    for (final historyDoc in historyCollection.docs) {
      final historyData = historyDoc.data();

      final rankList = List<String>.from(historyData['rank'] ?? []);
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
      List<String> docIds2 = [];

      for (int i = 0; i < 3; i++) {
        final rank = i < rankList.length ? rankList[i].toLowerCase() : '';
        final docId = rankToDocId[rank] ?? 'UNKNOWN';
        docIds.add(docId);
      }

      for (int i = rankList.length - 3; i < rankList.length; i++) {
        final rank = i >= 0 ? rankList[i].toLowerCase() : '';
        final docId = rankToDocId[rank] ?? 'UNKNOWN';
        docIds2.add(docId);
      }

      docIds2 = docIds2.reversed.toList();

      List<String> namaKategoriList = [];
      List<String> deskripsiList = [];
      List<String> namaKategoriList2 = [];
      List<String> deskripsiList2 = [];

      for (String docId in docIds) {
        final kategoriDoc = await FirebaseFirestore.instance
            .collection('KategoriTesMinat')
            .doc(docId)
            .get();
        final namaKategori = kategoriDoc.exists
            ? (kategoriDoc.data()?['nama'] ?? 'Nama tidak tersedia')
            : 'Kategori tidak ditemukan';
        final deskripsi = kategoriDoc.exists
            ? (kategoriDoc.data()?['deskripsi'] ?? 'Deskripsi tidak tersedia')
            : 'Deskripsi tidak tersedia';
        namaKategoriList.add(namaKategori);
        deskripsiList.add(_formatDeskripsi(deskripsi));
      }

      for (String docId in docIds2) {
        final kategoriDoc = await FirebaseFirestore.instance
            .collection('KategoriTesMinat')
            .doc(docId)
            .get();
        final namaKategori = kategoriDoc.exists
            ? (kategoriDoc.data()?['nama'] ?? 'Nama tidak tersedia')
            : 'Kategori tidak ditemukan';
        final deskripsi = kategoriDoc.exists
            ? (kategoriDoc.data()?['deskripsi'] ?? 'Deskripsi tidak tersedia')
            : 'Deskripsi tidak tersedia';
        namaKategoriList2.add(namaKategori);
        deskripsiList2.add(_formatDeskripsi(deskripsi));
      }

      final totals = [
        historyData['out'] ?? 0,
        historyData['me'] ?? 0,
        historyData['comp'] ?? 0,
        historyData['sci'] ?? 0,
        historyData['pers'] ?? 0,
        historyData['aesth'] ?? 0,
        historyData['lit'] ?? 0,
        historyData['mus'] ?? 0,
        historyData['sos'] ?? 0,
        historyData['cler'] ?? 0,
        historyData['prac'] ?? 0,
        historyData['med'] ?? 0,
      ]
          .map((value) =>
              value is int ? value : int.tryParse(value.toString()) ?? 0)
          .toList();

      final sortedTotals = [...totals];
      sortedTotals.sort();
      final ranks =
          totals.map((total) => sortedTotals.indexOf(total) + 1).toList();

      results.add({
        'tanggal': tanggal,
        'namaKategori': namaKategoriList,
        'deskripsi': deskripsiList,
        'namaKategori2': namaKategoriList2,
        'deskripsi2': deskripsiList2,
        'totals': totals,
        'ranks': ranks,
      });
    }

    return results;
  }

  Future<List<Map<String, dynamic>>> _fetchDataBakat(String docId) async {
    final historyCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(docId)
        .collection('HistoryTesBakat');

    final historySnapshot = await historyCollection.get();

    if (historySnapshot.docs.isEmpty) {
      return [];
    }

    final List<Map<String, dynamic>> testDetails = [];

    for (var doc in historySnapshot.docs) {
      final testData = doc.data();
      testDetails.add({
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
      });
    }

    return testDetails;
  }

  Future<Map<String, dynamic>> _fetchKarirImpian(String docId) async {
    final userDocRef =
        FirebaseFirestore.instance.collection('Users').doc(docId);
    final karirDocRef = userDocRef.collection('Karir Impian');

    final pilihan1Doc = await karirDocRef.doc('pilihan1').get();
    final pilihan2Doc = await karirDocRef.doc('pilihan2').get();
    final pilihan3Doc = await karirDocRef.doc('pilihan3').get();
    final skillDimilikiDoc = await karirDocRef.doc('skill_dimiliki').get();
    final skillBelumDimilikiDoc =
        await karirDocRef.doc('skill_belum_dimiliki').get();
    final actionPlanDoc = await karirDocRef.doc('action_plan').get();

    return {
      'pilihan1': pilihan1Doc.data() ?? {},
      'pilihan2': pilihan2Doc.data() ?? {},
      'pilihan3': pilihan3Doc.data() ?? {},
      'skill_dimiliki': skillDimilikiDoc.data()?['skill_dimiliki'] ?? [],
      'skill_belum_dimiliki':
          skillBelumDimilikiDoc.data()?['skill_belum_dimiliki'] ?? [],
      'action_plan': actionPlanDoc.data() ?? {},
    };
  }

  List<String> _parseSkills(dynamic skills) {
    if (skills is String) {
      return skills
          .split('\n')
          .where((skill) => skill.isNotEmpty)
          .map((skill) => skill.replaceAll('-', '').trim())
          .toList();
    }
    if (skills is List) {
      return skills.map((skill) => skill.toString()).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>> _fetchLatihanEnterpreneurData(
      String docId) async {
    try {
      // Ambil data dari koleksi Users
      final userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(docId).get();

      if (!userDoc.exists) {
        throw Exception('User document not found');
      }

      // Ambil data dari koleksi Latihan Enterpreneur
      final latihanQuery = await FirebaseFirestore.instance
          .collection('Users')
          .doc(docId)
          .collection('Latihan Enterpreneur')
          .get();

      if (latihanQuery.docs.isEmpty) {
        return {}; // Tidak ada dokumen
      }

      // Ambil data dari dokumen pertama jika ada lebih dari satu dokumen
      final latihanDoc = latihanQuery.docs.first.data();

      return {
        'tanggal': latihanDoc['tanggal'] ?? 'Tidak ada',
        'nama_brand': latihanDoc['nama_brand'] ?? 'Tidak ada',
        'tagline': latihanDoc['tagline'] ?? 'Tidak ada',
        'latar_belakang': latihanDoc['latar_belakang'] ?? 'Tidak ada',
        'produk': latihanDoc['produk'] ?? 'Tidak ada',
        'keunggulan': latihanDoc['keunggulan'] ?? 'Tidak ada',
        'target_pasar': latihanDoc['target_pasar'] ?? 'Tidak ada',
        'promosi': latihanDoc['promosi'] ?? 'Tidak ada',
        'harga_pokok': latihanDoc['harga_pokok'] ?? 'Tidak ada',
        'harga_jual': latihanDoc['harga_jual'] ?? 'Tidak ada',
      };
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  String _formatDeskripsi(String deskripsi) {
    // Implement formatting logic here if needed
    return deskripsi;
  }

  List<String> _parseSkills2(List<String> skills) {
    return skills.isEmpty ? ['-'] : skills;
  }

  Future<List<Map<String, dynamic>>> _fetchDataKepribadian(String docId) async {
    final historyCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(docId)
        .collection('HistoryKepribadian');

    final historySnapshot = await historyCollection.get();

    if (historySnapshot.docs.isEmpty) {
      return [];
    }

    final List<Map<String, dynamic>> testDetails = [];

    for (var doc in historySnapshot.docs) {
      final testData = doc.data();
      testDetails.add({
        'tanggal': testData['tanggal'],
        'highscoreP': testData['highscoreP'],
        'deskripsiP': testData['deskripsiP'],
      });
    }

    return testDetails;
  }

  Future<Map<String, dynamic>> _fetchDataKepribadianPDF(String docId) async {
    final historyCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(docId)
        .collection('HistoryKepribadian');

    final historySnapshot = await historyCollection.get();

    if (historySnapshot.docs.isEmpty) {
      return {}; // Mengembalikan map kosong jika tidak ada dokumen
    }

    // Mengambil dokumen pertama dari hasil snapshot
    final testData = historySnapshot.docs.first.data();

    return {
      'tanggal': testData['tanggal'] ?? 'Tidak ada tanggal',
      'highscoreP': testData['highscoreP'] ?? 'Unknown',
      'deskripsiP': testData['deskripsiP'] ?? 'Tidak ada deskripsi',
    };
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

  Future<void> saveDetailToPdf(BuildContext context, String docId) async {
    pw.Widget _buildRow(String label, String value) {
      return pw.Table(
        border: null, // Menghilangkan border
        columnWidths: {
          0: pw.FractionColumnWidth(0.25), // Proporsi kolom pertama lebih kecil
          1: pw.FractionColumnWidth(0.05), // Proporsi kolom kedua tetap kecil
          2: pw.FractionColumnWidth(0.70), // Proporsi kolom ketiga lebih besar
        },
        children: [
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(0),
                child: pw.Text(
                  label,
                  style: pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(0),
                child: pw.Text(
                  ':',
                  style: pw.TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(0),
                child: pw.Text(
                  value.isNotEmpty ? value : '-',
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      );
    }

    try {
      final userData = await _fetchUserData(docId);
      final namaLengkap = userData['namaLengkap'];
      final namaSekolah = userData['namaSekolah'];

      final dataResults = await _fetchDataMinat(docId);

      final bakatResults = await _fetchDataBakat(docId);

      List<pw.TableRow> createBakatTableRows(List<dynamic> results) {
        return results
            .map((result) {
              final tes = result['tes'] is List
                  ? List<String>.from(result['tes'])
                  : <String>[];
              final skorDynamic = result['skor'] is List
                  ? List<dynamic>.from(result['skor'])
                  : <dynamic>[];
              final kategori = result['kategori'] is List
                  ? List<String>.from(result['kategori'])
                  : <String>[];

              final skor = skorDynamic.map((item) {
                if (item is int) return item;
                if (item is String) return int.tryParse(item) ?? 0;
                return 0;
              }).toList();

              return List.generate(
                tes.length,
                (index) => pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text(tes[index]),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text(skor[index].toString()),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text(kategori[index]),
                    ),
                  ],
                ),
              );
            })
            .expand((element) => element)
            .toList();
      }

      final tesBakatTableRows = createBakatTableRows(bakatResults);
      final hasilTesKepribadian = await _fetchDataKepribadianPDF(docId);
      final tanggalkepribadian = hasilTesKepribadian['tanggal'] ?? 'Tidak ada tanggal';
      final highscoreP = hasilTesKepribadian['highscoreP'] ?? 'Unknown';
      final deskripsiP = hasilTesKepribadian['deskripsiP'] ?? 'Tidak ada deskripsi';
      final kategori = getCategoryAndDescription(highscoreP);

      // Ambil data Karir Impian
      final karirImpianData = await _fetchKarirImpian(docId);
      final userDocRef =
          FirebaseFirestore.instance.collection('Users').doc(docId);
      final karirDocRef = userDocRef.collection('Karir Impian');

      final pilihan1 = karirImpianData['pilihan1'] is Map<String, dynamic>
          ? karirImpianData['pilihan1'] as Map<String, dynamic>
          : {};
      final pilihan2 = karirImpianData['pilihan2'] is Map<String, dynamic>
          ? karirImpianData['pilihan2'] as Map<String, dynamic>
          : {};
      final pilihan3 = karirImpianData['pilihan3'] is Map<String, dynamic>
          ? karirImpianData['pilihan3'] as Map<String, dynamic>
          : {};
      final skillDimilikiDoc = await karirDocRef.doc('skill_dimiliki').get();
      final skillBelumDimilikiDoc =
          await karirDocRef.doc('skill_belum_dimiliki').get();
      final skillDimiliki = skillDimilikiDoc.exists
          ? (skillDimilikiDoc.data() as Map<String, dynamic>)
              .values
              .map((v) => v.toString())
              .toList()
          : <String>[];
      final skillBelumDimiliki = skillBelumDimilikiDoc.exists
          ? (skillBelumDimilikiDoc.data() as Map<String, dynamic>)
              .values
              .map((v) => v.toString())
              .toList()
          : <String>[];

      // Ambil data Latihan Enterpreneur
      final latihanData = await _fetchLatihanEnterpreneurData(docId);

      String getValueOrDefault(String? value) =>
          (value?.isEmpty ?? true) ? '-' : value!;

      final tanggal = getValueOrDefault(latihanData['tanggal']);
      final namaBrand = getValueOrDefault(latihanData['nama_brand']);
      final tagline = getValueOrDefault(latihanData['tagline']);
      final latarBelakang = getValueOrDefault(latihanData['latar_belakang']);
      final produk = getValueOrDefault(latihanData['produk']);
      final keunggulan = getValueOrDefault(latihanData['keunggulan']);
      final targetPasar = getValueOrDefault(latihanData['target_pasar']);
      final promosi = getValueOrDefault(latihanData['promosi']);
      final hargaPokok = getValueOrDefault(latihanData['harga_pokok']);
      final hargaJual = getValueOrDefault(latihanData['harga_jual']);

      final fontData = await rootBundle.load('fonts/times_new_roman.ttf');
      final imageData = await rootBundle.load('assets/images/kopsuratpnm.png');
      final image = pw.MemoryImage(imageData.buffer.asUint8List());
      final font = pw.Font.ttf(fontData);
      final pdf = pw.Document(
        theme: pw.ThemeData.withFont(
          base: font,
        ),
      );
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.copyWith(
            marginLeft: 2.5 * PdfPageFormat.cm,
            marginTop: 2.5 * PdfPageFormat.cm,
            marginRight: 2.5 * PdfPageFormat.cm,
            marginBottom: 2.5 * PdfPageFormat.cm,
          ),
          build: (pw.Context context) => [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                 pw.Image(image), // Add the image here
                pw.SizedBox(height: 10),
                _buildRow('Nama Lengkap', namaLengkap),
                _buildRow('Asal Sekolah', namaSekolah),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Tes Minat (${dataResults.isNotEmpty ? dataResults.first['tanggal'] ?? 'Tidak ada tanggal' : 'Tidak ada tanggal'})',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 14),
                ),

                pw.SizedBox(height: 10),
                // Add the formatted conent piece by piece
                if (dataResults.isNotEmpty) ...[
                  for (var result in dataResults) ...[
                    pw.Text(
                      'Pekerjaan yang disukai:',
                      style: pw.TextStyle(
                          fontSize: 12),
                    ),
                    pw.SizedBox(height: 5),
                    if (result['namaKategori'] is List<String> &&
                        result['deskripsi'] is List<String>) ...[
                      for (int i = 0;
                          i < (result['namaKategori'] as List<String>).length;
                          i++) ...[
                        pw.Text(
                          '${i + 1}. ${result['namaKategori'][i]}',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                        pw.Text(
                          result['deskripsi'].isNotEmpty
                              ? result['deskripsi'][i]
                              : 'Tidak ada deskripsi',
                          style: pw.TextStyle(fontSize: 12),
                          textAlign: pw.TextAlign.justify,
                        ),
                        pw.SizedBox(height: 10),
                      ],
                    ],
                    pw.Text(
                      'Pekerjaan yang tidak disukai:',
                      style: pw.TextStyle(
                           fontSize: 12),
                    ),
                    pw.SizedBox(height: 5),
                    if (result['namaKategori2'] is List<String> &&
                        result['deskripsi2'] is List<String>) ...[
                      for (int i = 0;
                          i < (result['namaKategori2'] as List<String>).length;
                          i++) ...[
                        pw.Text(
                          '${i + 1}. ${result['namaKategori2'][i]}',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                        pw.Text(
                          result['deskripsi2'].isNotEmpty
                              ? result['deskripsi2'][i]
                              : 'Tidak ada deskripsi',
                          style: pw.TextStyle(fontSize: 12),
                          textAlign: pw.TextAlign.justify,
                        ),
                        pw.SizedBox(height: 5),
                      ],
                    ],
                  ],
                ] else ...[
                  pw.Text('Tidak ada tes minat tersedia'),
                ],
              ],
            ),
            pw.SizedBox(height: 20),
            // Page 2: Tes Bakat
            pw.Text(
              'Tes Bakat (${bakatResults.isNotEmpty ? bakatResults.first['tanggal'] ?? 'Tidak ada tanggal' : 'Tidak ada tanggal'})',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
            ),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          'Tes Bakat',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          'Skor',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          'Kategori',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                ...tesBakatTableRows,
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Tes Kepribadian ($tanggalkepribadian)',
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Kategori : $kategori',
              style: pw.TextStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 5),
            pw.Text(
              deskripsiP,
              style: pw.TextStyle(fontSize: 12),
              textAlign: pw.TextAlign.justify,
            ),
            pw.SizedBox(height: 20,),
            // Page 3: Karir Impian dan Latihan Enterpreneur
            pw.Text(
              'Karir Impian',
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Pilihan 1',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            _buildRow('Pekerjaan Impian', pilihan1['pekerjaan_impian'] ?? '-'),
            _buildRow('Jurusan Kuliah', pilihan1['jurusan_kuliah'] ?? '-'),
            _buildRow('Jurusan SMK/K', pilihan1['jurusan_sma_k'] ?? '-'),
            _buildRow('Keterampilan', pilihan1['keterampilan'] ?? '-'),
            pw.SizedBox(height: 10),
            pw.Text(
              'Pilihan 2',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            _buildRow('Pekerjaan Impian', pilihan2['pekerjaan_impian'] ?? '-'),
            _buildRow('Jurusan Kuliah', pilihan2['jurusan_kuliah'] ?? '-'),
            _buildRow('Jurusan SMK/K', pilihan2['jurusan_sma_k'] ?? '-'),
            _buildRow('Keterampilan', pilihan2['keterampilan'] ?? '-'),
            pw.SizedBox(height: 10),
            pw.Text(
              'Pilihan 3',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            _buildRow('Pekerjaan Impian', pilihan3['pekerjaan_impian'] ?? '-'),
            _buildRow('Jurusan Kuliah', pilihan3['jurusan_kuliah'] ?? '-'),
            _buildRow('Jurusan SMK/K', pilihan3['jurusan_sma_k'] ?? '-'),
            _buildRow('Keterampilan', pilihan3['keterampilan'] ?? '-'),
            pw.SizedBox(height: 20),
            pw.Text(
              'Keterampilan Dimiliki:',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              skillDimiliki.isNotEmpty ? skillDimiliki.join('\n') : '-',
              style: pw.TextStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Keterampilan Belum Dimiliki:',
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              skillBelumDimiliki.isNotEmpty
                  ? skillBelumDimiliki.join('\n')
                  : '-',
              style: pw.TextStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Latihan Enterpreneur',
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            _buildRow('Tanggal', tanggal),
            _buildRow('Nama Brand', namaBrand),
            _buildRow('Tagline', tagline),
            _buildRow('Latar Belakang', latarBelakang),
            _buildRow('Produk', produk),
            _buildRow('Keunggulan', keunggulan),
            _buildRow('Target Pasar', targetPasar),
            _buildRow('Promosi', promosi),
            _buildRow('Harga Pokok', hargaPokok),
            _buildRow('Harga Jual', hargaJual),
          ],
        ),
      );

      // Mendapatkan direktori dokumen aplikasi
      final directory = await getExternalStorageDirectory();
      final folderPath = '${directory?.path}/AkadamiID';
      final folder = Directory(folderPath);
      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      final filePath = '$folderPath/$namaLengkap.pdf';
      final file = File(filePath);

      // Menyimpan file PDF
      await file.writeAsBytes(await pdf.save());

      // Menampilkan notifikasi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File berhasil disimpan ke ${file.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan file: $e')),
      );
      print('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Hasil Tes Siswa',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download, color: Colors.blue.shade800),
            onPressed: () async {
              // Mengambil docId dari widget
              final docId = widget.docId;
              await saveDetailToPdf(context, docId);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([
          _fetchUserData(widget.docId), // Mengambil data pengguna
          _fetchDataMinat(widget.docId), // Mengambil data Tes Minat
          _fetchDataBakat(widget.docId), // Mengambil data Tes Bakat
          _fetchDataKepribadian(widget.docId),
          _fetchKarirImpian(widget.docId), // Mengambil data Karir Impian
          _fetchLatihanEnterpreneurData(widget.docId),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Data tidak tersedia'));
          }

          final userData = snapshot.data![0]; // Data Pengguna
          final dataResults = snapshot.data![1]; // Data Tes Minat
          final bakatResults = snapshot.data![2]; // Data Tes Bakat
          final kepribadianResults = snapshot.data![3];
          final additionalData = snapshot.data![4];
          final latihanData = snapshot.data![5];

          final namaLengkap = userData['namaLengkap'] ?? 'Tidak ada nama';
          final namaSekolah = userData['namaSekolah'] ?? 'Tidak ada sekolah';

          final pilihan1 = additionalData['pilihan1'];
          final pilihan2 = additionalData['pilihan2'];
          final pilihan3 = additionalData['pilihan3'];

          // Pastikan skill_dimiliki dan skill_belum_dimiliki adalah list
          final skillDimiliki = _parseSkills(additionalData['skill_dimiliki']);
          final skillBelumDimiliki =
              _parseSkills(additionalData['skill_belum_dimiliki']);

          final actionPlan = additionalData['action_plan'];
          String getValueOrDefault(String? value) =>
              (value?.isEmpty ?? true) ? '-' : value!;
          final tanggal = getValueOrDefault(latihanData['tanggal'] as String?);
          final namaBrand =
              getValueOrDefault(latihanData['nama_brand'] as String?);
          final tagline = getValueOrDefault(latihanData['tagline'] as String?);
          final latarBelakang =
              getValueOrDefault(latihanData['latar_belakang'] as String?);
          final produk = getValueOrDefault(latihanData['produk'] as String?);
          final keunggulan =
              getValueOrDefault(latihanData['keunggulan'] as String?);
          final targetPasar =
              getValueOrDefault(latihanData['target_pasar'] as String?);
          final promosi = getValueOrDefault(latihanData['promosi'] as String?);
          final hargaPokok =
              getValueOrDefault(latihanData['harga_pokok'] as String?);
          final hargaJual =
              getValueOrDefault(latihanData['harga_jual'] as String?);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Informasi Pengguna
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama : $namaLengkap',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Asal Sekolah : $namaSekolah',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                // Tes Minat
                if (dataResults.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Tes Minat',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (dataResults.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 6),
                    child: Text(
                      'Tidak ada tes minat tersedia',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  ),
                if (dataResults.isNotEmpty)
                  ...dataResults.map((result) {
                    final tanggal = result['tanggal'] ?? 'Tidak ada tanggal';
                    final namaKategori =
                        result['namaKategori'] as List<String>? ?? [];
                    final deskripsi =
                        result['deskripsi'] as List<String>? ?? [];
                    final namaKategori2 =
                        result['namaKategori2'] as List<String>? ?? [];
                    final deskripsi2 =
                        result['deskripsi2'] as List<String>? ?? [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'Tes Minat ($tanggal)',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Pekerjaan yang disukai:',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        ...List.generate(
                          namaKategori.length,
                          (index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}. ${namaKategori[index]}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  deskripsi.isNotEmpty
                                      ? deskripsi[index]
                                      : 'Tidak ada deskripsi',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 6),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Pekerjaan yang tidak disukai:',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        ...List.generate(
                          namaKategori2.length,
                          (index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}. ${namaKategori2[index]}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  deskripsi2.isNotEmpty
                                      ? deskripsi2[index]
                                      : 'Tidak ada deskripsi',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 6),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),

                // Tes Bakat
                if (bakatResults.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Tes Bakat',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (bakatResults.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Tidak ada tes bakat tersedia',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  ),
                SizedBox(height: 6),
                if (bakatResults.isNotEmpty)
                  ...bakatResults.map((result) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tes Bakat (${result['tanggal']})',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
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
                                        fontSize: 12,
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
                                        fontSize: 12,
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
                                        fontSize: 12,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            result['tes'][index],
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            result['deskripsi'][index],
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        result['skor'][index].toString(),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        result['kategori'][index],
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                if (kepribadianResults.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Tes Kepribadian',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (kepribadianResults.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Tidak ada hasil tes kepribadian',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  ),
                if (kepribadianResults.isNotEmpty)
                  ...kepribadianResults.map((result) {
                    final tanggal = result['tanggal'] ?? 'Tidak ada tanggal';
                    final highscoreP = result['highscoreP'] ?? 'Unknown';
                    final deskripsiP =
                        result['deskripsiP'] ?? 'Tidak ada deskripsi';
                    final kategori = getCategoryAndDescription(highscoreP);

                    return Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tes Kepribadian ($tanggal)',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Kategori: $kategori',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            deskripsiP,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                // Data Tambahan
                if (additionalData.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Data Tambahan',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (additionalData.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Tidak ada data tambahan tersedia',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                      ),
                    ),
                  ),
                SizedBox(height: 16),
                if (additionalData.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Karir Impian',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Pilihan 1',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Pekerjaan Impian  :  ${pilihan1?['pekerjaan_impian'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Jurusan Kuliah  :  ${pilihan1?['jurusan_kuliah'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Jurusan SMK/K  :  ${pilihan1?['jurusan_sma_k'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Keterampilan  :  ${pilihan1?['keterampilan'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Pilihan 2',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Pekerjaan Impian  :  ${pilihan2?['pekerjaan_impian'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Jurusan Kuliah  :  ${pilihan2?['jurusan_kuliah'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Jurusan SMK/K  :  ${pilihan2?['jurusan_sma_k'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Keterampilan  :  ${pilihan2?['keterampilan'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Pilihan 3',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Pekerjaan Impian  :  ${pilihan3?['pekerjaan_impian'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Jurusan Kuliah  :  ${pilihan3?['jurusan_kuliah'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Jurusan SMK/K  :  ${pilihan3?['jurusan_sma_k'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Keterampilan  :  ${pilihan3?['keterampilan'] ?? '-'}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Skill Dimiliki
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Skill Dimiliki:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  skillDimiliki.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            '- ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: skillDimiliki
                              .map<Widget>(
                                (skill) => Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    '- $skill',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                  SizedBox(height: 10),

                  // Skill Belum Dimiliki
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Skill Belum Dimiliki:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  skillBelumDimiliki.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            '- ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: skillBelumDimiliki
                              .map<Widget>(
                                (skill) => Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    '- $skill',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                  SizedBox(height: 10),

                  // Action Plan
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Action Plan',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...List.generate(10, (index) {
                    final year = index + 1;
                    return Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Tahun $year  : ${actionPlan['tahun_$year'] ?? '-'}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 10),

                  // Latihan Enterpreneur
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Latihan Enterpreneur',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Tanggal : $tanggal',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Nama Brand : $namaBrand',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Tagline : $tagline',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Latar Belakang : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      '$latarBelakang',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Produk : $produk',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Keunggulan : ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      '$keunggulan',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Target Pasar : $targetPasar',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Promosi : $promosi',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Harga Pokok : $hargaPokok',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Harga Jual : $hargaJual',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
