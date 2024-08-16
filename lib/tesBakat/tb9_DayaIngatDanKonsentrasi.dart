import 'dart:async';

import 'package:akademi_id/tesBakat/Hasil/HasilTesBakat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:intl/intl.dart';

class TB_DayaIngatDanKonsentrasi extends StatefulWidget {
  final int scoretb1;
  final String categoryTb1;
  final int scoretb2;
  final String categoryTb2;
  final int scoretb3;
  final String categoryTb3;
  final int scoretb4;
  final String categoryTb4;
  final int scoretb5;
  final String categoryTb5;
  final int scoretb6;
  final String categoryTb6;
  final int scoretb7;
  final String categoryTb7;
  final int scoretb8;
  final String categoryTb8;

  const TB_DayaIngatDanKonsentrasi({
    super.key,
    required this.scoretb1,
    required this.categoryTb1,
    required this.scoretb2,
    required this.categoryTb2,
    required this.scoretb3,
    required this.categoryTb3,
    required this.scoretb4,
    required this.categoryTb4,
    required this.scoretb5,
    required this.categoryTb5,
    required this.scoretb6,
    required this.categoryTb6,
    required this.scoretb7,
    required this.categoryTb7,
    required this.scoretb8,
    required this.categoryTb8,
  });

  @override
  State<TB_DayaIngatDanKonsentrasi> createState() =>
      _TB_DayaIngatDanKonsentrasiState();
}

class _TB_DayaIngatDanKonsentrasiState
    extends State<TB_DayaIngatDanKonsentrasi> {
  bool _showInstructions = false;
  bool _showHafalan = true;
  List<String> _selectedAnswers =
      List.filled(20, ''); // Untuk menyimpan jawaban sementara
  late Timer _timer;
  int _secondsLeft = 360;
  int _remainingTime = 180;

  final Map<int, String> _keyAnswers = {
    1: 'D',
    2: 'E',
    3: 'B',
    4: 'A',
    5: 'C',
    6: 'A',
    7: 'D',
    8: 'E',
    9: 'C',
    10: 'B',
    11: 'B',
    12: 'A',
    13: 'E',
    14: 'C',
    15: 'D',
    16: 'B',
    17: 'E',
    18: 'A',
    19: 'C',
    20: 'D',
  };

  @override
  void initState() {
    super.initState();
    _secureScreen();
    _startHafalanTimer();
  }

  void _secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  void _startHafalanTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        setState(() {
          _showHafalan = false;
          _showInstructions = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
        // Mengumpulkan jawaban dan menampilkan dialog waktu habis
        int poin = _calculatePoints();
        int scoretb9 = _getScore(poin);
        int scoretb1 = widget.scoretb1;
        int scoretb2 = widget.scoretb2;
        int scoretb3 = widget.scoretb3;
        int scoretb4 = widget.scoretb4;
        int scoretb5 = widget.scoretb5;
        int scoretb6 = widget.scoretb6;
        int scoretb7 = widget.scoretb7;
        int scoretb8 = widget.scoretb8;
        String categoryTb9 = _getResultCategory(scoretb9);
        String categoryTb1 = widget.categoryTb1;
        String categoryTb2 = widget.categoryTb2;
        String categoryTb3 = widget.categoryTb3;
        String categoryTb4 = widget.categoryTb4;
        String categoryTb5 = widget.categoryTb5;
        String categoryTb6 = widget.categoryTb6;
        String categoryTb7 = widget.categoryTb7;
        String categoryTb8 = widget.categoryTb8;
        print('Total Poin: $poin');
        print('Nilai Score: $scoretb9');
        print('Kategori Hasil: $categoryTb9');
        _showTimeUpDialog(
          scoretb1,
          categoryTb1,
          scoretb2,
          categoryTb2,
          scoretb3,
          categoryTb3,
          scoretb4,
          categoryTb4,
          scoretb5,
          categoryTb5,
          scoretb6,
          categoryTb6,
          scoretb7,
          categoryTb7,
          scoretb8,
          categoryTb8,
          scoretb9,
          categoryTb9,
        );
      } else {
        setState(() {
          _secondsLeft--;
        });
      }
    });
  }

  int _calculatePoints() {
    int poin = 0;
    for (int i = 0; i < _selectedAnswers.length; i++) {
      String correctAnswer = _keyAnswers[i + 1] ?? '';
      if (_selectedAnswers[i] == correctAnswer) {
        poin++;
      }
      print(
          'Soal ${i + 1} : Jawaban ${_selectedAnswers[i]} : ${_selectedAnswers[i] == correctAnswer ? 'nilai 1' : 'nilai 0'}');
    }
    return poin;
  }

  void _submitAnswers() async {
    if (_secondsLeft > 0) {
      // Hanya menghitung poin dan menampilkan hasil jika timer masih berjalan
      int poin = _calculatePoints();
      int scoretb9 = _getScore(poin);
      String categoryTb9 = _getResultCategory(scoretb9);
      print('Total Poin: $poin');
      print('Nilai Score: $scoretb9');
      print('Kategori Hasil: $categoryTb9');
      // Ambil ID pengguna yang sedang login
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('Pengguna tidak ditemukan, pastikan pengguna sudah login.');
        return;
      }
      String userId = user.uid;
      // Format tanggal
      final String formattedDate =
          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now());
      // Simpan data ke Firestore
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .collection('HistoryTesBakat')
            .add({
          'tanggal': formattedDate,
          'TB1': widget.scoretb1,
          'TB2': widget.scoretb2,
          'TB3': widget.scoretb3,
          'TB4': widget.scoretb4,
          'TB5': widget.scoretb5,
          'TB6': widget.scoretb6,
          'TB7': widget.scoretb7,
          'TB8': widget.scoretb8,
          'TB9': scoretb9,
          'CategoryTB1': widget.categoryTb1,
          'CategoryTB2': widget.categoryTb2,
          'CategoryTB3': widget.categoryTb3,
          'CategoryTB4': widget.categoryTb4,
          'CategoryTB5': widget.categoryTb5,
          'CategoryTB6': widget.categoryTb6,
          'CategoryTB7': widget.categoryTb7,
          'CategoryTB8': widget.categoryTb8,
          'CategoryTB9': categoryTb9,
        });
        print('Data berhasil disimpan ke Firestore');

                // Arahkan ke halaman hasil tes bakat dengan animasi
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    final tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    final offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: HasilTesBakat(),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ));
              } catch (e) {
                print('Terjadi kesalahan saat menyimpan data: $e');
              }
    }
  }

  void _showTimeUpDialog(
      int scoretb1,
      String categoryTb1,
      int scoretb2,
      String categoryTb2,
      int scoretb3,
      String categoryTb3,
      int scoretb4,
      String categoryTb4,
      int scoretb5,
      String categoryTb5,
      int scoretb6,
      String categoryTb6,
      int scoretb7,
      String categoryTb7,
      int scoretb8,
      String categoryTb8,
      int scoretb9,
      String categoryTb9) {

    showDialog(
      context: context,
      barrierDismissible:
          false, // Mencegah dialog ditutup dengan menekan di luar dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'TIME UP!',
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Text(
            'Waktu Anda telah habis. Silakan lanjut ke tes berikutnya.',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
              // Ambil ID pengguna yang sedang login
              User? user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                print('Pengguna tidak ditemukan, pastikan pengguna sudah login.');
                return;
              }
              String userId = user.uid;

              // Format tanggal
              final String formattedDate =
                  DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now());

              // Simpan data ke Firestore
              try {
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userId)
                    .collection('HistoryTesBakat')
                    .add({
                  'tanggal': formattedDate,
                  'TB1': scoretb1,
                  'TB2': scoretb2,
                  'TB3': scoretb3,
                  'TB4': scoretb4,
                  'TB5': scoretb5,
                  'TB6': scoretb6,
                  'TB7': scoretb7,
                  'TB8': scoretb8,
                  'TB9': scoretb9,
                  'CategoryTB1': categoryTb1,
                  'CategoryTB2': categoryTb2,
                  'CategoryTB3': categoryTb3,
                  'CategoryTB4': categoryTb4,
                  'CategoryTB5': categoryTb5,
                  'CategoryTB6': categoryTb6,
                  'CategoryTB7': categoryTb7,
                  'CategoryTB8': categoryTb8,
                  'CategoryTB9': categoryTb9,
                });
                print('Data berhasil disimpan ke Firestore');
                
                Navigator.of(context).pop();

                  // Arahkan ke halaman hasil tes bakat dengan animasi
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      final offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: HasilTesBakat(),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 500),
                  ));
                } catch (e) {
                  print('Terjadi kesalahan saat menyimpan data: $e');
                }
              },
              child: Text(
                'Lihat Hasil Tes',
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  int _getScore(int poin) {
    // Mendefinisikan nilai score berdasarkan total poin
    switch (poin) {
      case 20:
        return 120;
      case 19:
        return 117;
      case 18:
        return 115;
      case 17:
        return 113;
      case 16:
        return 110;
      case 15:
        return 108;
      case 14:
        return 105;
      case 13:
        return 103;
      case 12:
        return 100;
      case 11:
        return 98;
      case 10:
        return 95;
      case 9:
        return 93;
      case 8:
        return 91;
      case 7:
        return 88;
      case 6:
        return 86;
      case 5:
        return 83;
      case 4:
        return 81;
      case 3:
        return 78;
      case 2:
        return 76;
      case 1:
        return 74;
      case 0:
        return 71;
      default:
        return 71; // Skor default jika poin tidak sesuai dengan range yang ada
    }
  }

  String _getResultCategory(int score) {
    // Menentukan kategori hasil berdasarkan nilai score
    if (score >= 71 && score <= 78) {
      return 'Sangat Rendah';
    } else if (score >= 81 && score <= 88) {
      return 'Rendah';
    } else if (score >= 91 && score <= 100) {
      return 'Sedang';
    } else if (score >= 103 && score <= 110) {
      return 'Tinggi';
    } else if (score >= 113 && score <= 120) {
      return 'Sangat Tinggi';
    } else {
      return 'Tidak Terdefinisi'; // Kategori default jika score tidak sesuai dengan range yang ada
    }
  }

  void _startTest() {
    setState(() {
      _showInstructions = false;
    });
    _startTimer();
  }

  void _logInput() {
    int poin = 0;
    for (int i = 0; i < _selectedAnswers.length; i++) {
      String correctAnswer = _keyAnswers[i + 1] ?? '';
      if (_selectedAnswers[i] == correctAnswer) {
        poin++;
      }
      print(
          'Soal ${i + 1} : Jawaban ${_selectedAnswers[i]} : ${_selectedAnswers[i] == correctAnswer ? 'nilai 1' : 'nilai 0'}');
    }

    // Menentukan nilai score berdasarkan total poin
    int scoretb9 = _getScore(poin);

    // Menentukan kategori hasil berdasarkan nilai score
    String categoryTb9 = _getResultCategory(scoretb9);

    // Menampilkan hasil score dan kategori
    print('Total Poin: $poin');
    print('Nilai Score: $scoretb9');
    print('Kategori Hasil: $categoryTb9');
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Konfirmasi Keluar',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            content: Text(
              'Apakah anda yakin ingin keluar dari tes? Anda tidak akan mendapatkan hasil tes jika keluar.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Tidak',
                  style: TextStyle(fontFamily: "Poppins"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/dashboard', (route) => false);
                },
                child: Text(
                  'Ya',
                  style: TextStyle(fontFamily: "Poppins"),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget _buildOptionBox(String optionText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        optionText,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Instruksi Tes 09 - Kemampuan Daya Ingat dan Konsentrasi',
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Pada persoalan berikutnya, terdapat sejumlah pertanyaan-pertanyaan mengenai kata-kata yang telah saudara hafalkan tadi. ',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 10),
            Text(
              'Contoh 09',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Kata yang mempunyai huruf permulaan – Q – adalah suatu.......',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 10),
            _buildOptionBox('a. Bunga'),
            _buildOptionBox('b. Perkakas'),
            _buildOptionBox('c. Burung'),
            _buildOptionBox('d. Kesenian'),
            _buildOptionBox('e. Binatang'),
            SizedBox(height: 16),
            Text(
              'Quintet adalah termasuk dalam jenis kesenian. Sehingga jawaban yang benar adalah d.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 16),
            Text(
              'Contoh berikutnya :',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Kata yang mempunyai huruf permulaan –Z- adalah suatu........',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 10),
            _buildOptionBox('a. Bunga'),
            _buildOptionBox('b. Perkakas'),
            _buildOptionBox('c. Burung'),
            _buildOptionBox('d. Kesenian'),
            _buildOptionBox('e. Binatang'),
            SizedBox(height: 10),
            Text(
              'Jawabannya adalah e, karena Zebra termasuk dalam jenis binatang.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 16),
            Text(
              'WAKTU PENGERJAAN: 6 menit',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _startTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 46, 155, 233),
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Mulai Tes',
                  style: TextStyle(fontFamily: "Poppins", color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestions() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('TB Daya Ingat dan Konsentrasi')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text(''));
        }

        var docs = snapshot.data!.docs;

        // Mengurutkan dokumen berdasarkan ID
        docs.sort((a, b) {
          int idA = int.tryParse(a.id) ?? 0;
          int idB = int.tryParse(b.id) ?? 0;
          return idA.compareTo(idB);
        });

        bool allAnswered =
            _selectedAnswers.every((answer) => answer.isNotEmpty);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teks di atas
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
              child: Container(
                color: Color.fromARGB(255, 46, 155, 233),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    _formatTime(_secondsLeft),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
            // SingleChildScrollView yang berisi pertanyaan
            Container(
              height: MediaQuery.of(context).size.height -
                  200, // Adjust height as needed
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    ...List.generate(docs.length, (index) {
                      var doc = docs[index];
                      String soal = doc['soal'] ?? '';
                      List<String> opsi = [
                        doc['opsi1'] ?? '',
                        doc['opsi2'] ?? '',
                        doc['opsi3'] ?? '',
                        doc['opsi4'] ?? '',
                        doc['opsi5'] ?? '',
                      ];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                              'Soal ${index + 157}. ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text(
                              '$soal',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ...List.generate(opsi.length, (opIndex) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  String selectedOption =
                                      _getOptionLabel(opIndex + 1);
                                  _selectedAnswers[index] = selectedOption;
                                  _logInput();
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: _selectedAnswers[index] ==
                                          _getOptionLabel(opIndex + 1)
                                      ? Color.fromARGB(255, 46, 155, 233)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  '${_getOptionPrefix(opIndex + 1)} ${opsi[opIndex]}',
                                  style: TextStyle(
                                    color: _selectedAnswers[index] ==
                                            _getOptionLabel(opIndex + 1)
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 16),
                        ],
                      );
                    }),
                    SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: allAnswered ? _submitAnswers : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: allAnswered
                              ? Color.fromARGB(255, 46, 155, 233)
                              : Colors.grey,
                          minimumSize: Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Lihat Hasil Tes',
                          style: TextStyle(
                              fontFamily: "Poppins", color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _getOptionLabel(int index) {
    switch (index) {
      case 1:
        return 'A';
      case 2:
        return 'B';
      case 3:
        return 'C';
      case 4:
        return 'D';
      case 5:
        return 'E';
      default:
        return '';
    }
  }

  String _getOptionPrefix(int index) {
    switch (index) {
      case 1:
        return 'a.';
      case 2:
        return 'b.';
      case 3:
        return 'c.';
      case 4:
        return 'd.';
      case 5:
        return 'e.';
      default:
        return '';
    }
  }

  Widget showHafalan() {
    final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            color: Color.fromARGB(255, 46, 155, 233),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '$minutes:$seconds',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Dalam tes Kemampuan Daya Ingat dan Konsentrasi, silahkan hafalkan kata-kata berikut dalam waktu 3 menit.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1),
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BUNGA : Soka – Larat – Flamboyan – Yasmin – Dahlia',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'PERKAKAS : Wajan – Jarum – Kikir – Cangkul – Palu',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'BURUNG : Itik – Elang – Walet – Tekukur – Nuri',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'KESENIAN : Quintet – Arca  - Opera – Gamelan – Ukiran',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'BINATANG : Musang – Rusa – Beruang – Zebra - Harimau',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Daya Ingat dan Konsentrasi',
            style: TextStyle(fontFamily: "Poppins",fontSize: 20),
          ),
        ),
        body: Center(
          child: _showHafalan
              ? showHafalan()
              : (_showInstructions ? _buildInstructions() : _buildQuestions()),
        ),
      ),
    );
  }
}
