import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailRiwayatPage extends StatefulWidget {
  final String docId;

  const DetailRiwayatPage({super.key, required this.docId});

  @override
  State<DetailRiwayatPage> createState() => _DetailRiwayatPageState();
}

class _DetailRiwayatPageState extends State<DetailRiwayatPage> {
  List<bool> _isExpandedList = [false, false, false];
  List<String> _deskripsiList = ['', '', ''];
  List<bool> _isExpandedList2 = [false, false, false];
  List<String> _deskripsiList2 = ['', '', ''];
  bool _showTable = false;

  Future<Map<String, dynamic>> fetchData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userId = user.uid;

    final historyDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('HistoryTesMinat')
        .doc(widget.docId)
        .get();

    if (!historyDoc.exists) {
      throw Exception('No history documents found');
    }

    final historyData = historyDoc.data();
    if (historyData == null) {
      throw Exception('History data is null');
    }

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

    return {
      'tanggal': tanggal,
      'namaKategori': namaKategoriList,
      'deskripsi': deskripsiList,
      'namaKategori2': namaKategoriList2,
      'deskripsi2': deskripsiList2,
      'totals': totals,
      'ranks': ranks,
    };
  }

  String _formatDeskripsi(String deskripsi) {
    // Pisahkan deskripsi berdasarkan label "Pekerjaan yang sesuai" dan "Jurusan kuliah yang disarankan"
    final pekerjaanPattern = RegExp(r'Pekerjaan yang sesuai:\s*(.*)');
    final jurusanPattern = RegExp(r'Jurusan kuliah yang disarankan:\s*(.*)');

    final pekerjaanMatch = pekerjaanPattern.firstMatch(deskripsi);
    final jurusanMatch = jurusanPattern.firstMatch(deskripsi);

    final pekerjaan = pekerjaanMatch != null
        ? pekerjaanMatch.group(1)?.trim() ?? 'Pekerjaan tidak tersedia'
        : 'Pekerjaan tidak tersedia';

    final jurusan = jurusanMatch != null
        ? jurusanMatch.group(1)?.trim() ?? 'Jurusan tidak tersedia'
        : 'Jurusan tidak tersedia';

    final deskripsiUtama = deskripsi.split('Pekerjaan yang sesuai:')[0].trim();

    return '$deskripsiUtama\n\nPekerjaan yang sesuai: $pekerjaan\n\nJurusan kuliah yang disarankan: $jurusan';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Riwayat',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
               if (snapshot.hasError) {
              return Center(child: Text('Terjadi kesalahan'));
            } else if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              final data = snapshot.data!;
              final tanggal = data['tanggal'] ?? 'Tanggal tidak tersedia';
              final namaKategoriList = data['namaKategori'] ?? [];
              final deskripsiList = data['deskripsi'] ?? [];
              final namaKategoriList2 = data['namaKategori2'] ?? [];
              final deskripsiList2 = data['deskripsi2'] ?? [];
              final totals = data['totals'] as List<int>;
              final ranks = data['ranks'] as List<int>;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Tanggal: $tanggal',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Pekerjaan yang disukai',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < 3; i++)
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          i < namaKategoriList.length
                                              ? namaKategoriList[i]
                                              : 'Kategori tidak tersedia',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          _isExpandedList[i]
                                              ? Icons.keyboard_arrow_down
                                              : Icons.keyboard_arrow_right,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isExpandedList[i] =
                                                !_isExpandedList[i];
                                            _deskripsiList[i] =
                                                _isExpandedList[i]
                                                    ? deskripsiList[i]
                                                    : '';
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  if (_isExpandedList[i])
                                    Text(
                                      _deskripsiList[i],
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Pekerjaan yang tidak disukai',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 245, 104, 94),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < 3; i++)
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          i < namaKategoriList2.length
                                              ? namaKategoriList2[i]
                                              : 'Kategori tidak tersedia',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          _isExpandedList2[i]
                                              ? Icons.keyboard_arrow_down
                                              : Icons.keyboard_arrow_right,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isExpandedList2[i] =
                                                !_isExpandedList2[i];
                                            _deskripsiList2[i] =
                                                _isExpandedList2[i]
                                                    ? deskripsiList2[i]
                                                    : '';
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  if (_isExpandedList2[i])
                                    Text(
                                      _deskripsiList2[i],
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 46, 155, 233),
                        ),
                        onPressed: () {
                          setState(() {
                            _showTable = !_showTable;
                          });
                        },
                        child: Text(
                          _showTable ? 'Sembunyikan Tabel' : 'Tampilkan Tabel',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_showTable) ...[
                      Text(
                        'Tabel Hasil Tes Minat',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10),
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        columnWidths: {
                          0: FlexColumnWidth(2),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.green,
                            ),
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Kategori',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Total',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Rank',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          for (int i = 0; i < 12; i++)
                            TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      [
                                        'Outdoor',
                                        'Mechanical',
                                        'Computational',
                                        'Scientific',
                                        'Personal Contact',
                                        'Aesthetic',
                                        'Literacy',
                                        'Musical',
                                        'Sosial Service',
                                        'Clerical',
                                        'Practical',
                                        'Medical'
                                      ][i],
                                      style: TextStyle(fontFamily: 'Poppins'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      totals[i].toString(),
                                      style: TextStyle(fontFamily: 'Poppins'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      ranks[i].toString(),
                                      style: TextStyle(fontFamily: 'Poppins'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
