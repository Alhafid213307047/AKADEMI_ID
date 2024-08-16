import 'dart:async';

import 'package:akademi_id/tesBakat/tb4_KemampuanBerpikirLogis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TB_KemampuanAnalisisSintesis extends StatefulWidget {
  final int scoretb1;
  final String categoryTb1;
  final int scoretb2;
  final String categoryTb2;


  const TB_KemampuanAnalisisSintesis({
    super.key,
    required this.scoretb1,
    required this.categoryTb1,
    required this.scoretb2,
    required this.categoryTb2,
  });

  @override
  State<TB_KemampuanAnalisisSintesis> createState() =>
      _TB_KemampuanAnalisisSintesisState();
}

class _TB_KemampuanAnalisisSintesisState
    extends State<TB_KemampuanAnalisisSintesis> {
  bool _showInstructions = true;
  List<String> _selectedAnswers =
      List.filled(20, ''); // Untuk menyimpan jawaban sementara
  late Timer _timer;
  int _secondsLeft = 420; // 7 menit dalam detik

  final Map<int, String> _keyAnswers = {
    1: 'C',
    2: 'C',
    3: 'D',
    4: 'D',
    5: 'D',
    6: 'B',
    7: 'D',
    8: 'B',
    9: 'E',
    10: 'D',
    11: 'C',
    12: 'C',
    13: 'C',
    14: 'C',
    15: 'D',
    16: 'C',
    17: 'C',
    18: 'D',
    19: 'E',
    20: 'E',
  };

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
        // Mengumpulkan jawaban dan menampilkan dialog waktu habis
        int poin = _calculatePoints();
        int scoretb3 = _getScore(poin);
        int scoretb1 = widget.scoretb1;
        int scoretb2 = widget.scoretb2;
        String categoryTb3 = _getResultCategory(scoretb3);
        String categoryTb1 = widget.categoryTb1;
        String categoryTb2 = widget.categoryTb2;
        print('Total Poin: $poin');
        print('Nilai Score: $scoretb3');
        print('Kategori Hasil: $categoryTb3');
        _showTimeUpDialog(scoretb1, categoryTb1, scoretb2, categoryTb2,
            scoretb3, categoryTb3);
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

  void _submitAnswers() {
    if (_secondsLeft > 0) {
      // Hanya menghitung poin dan menampilkan hasil jika timer masih berjalan
      int poin = _calculatePoints();
      int scoretb3 = _getScore(poin);
      String categoryTb3 = _getResultCategory(scoretb3);

      print('Total Poin: $poin');
      print('Nilai Score: $scoretb3');
      print('Kategori Hasil: $categoryTb3');
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            TB_KemampuanBerpikirLogis(
          scoretb1: widget.scoretb1,
          categoryTb1: widget.categoryTb1,
          scoretb2: widget.scoretb2,
          categoryTb2: widget.categoryTb2,
          scoretb3: scoretb3,
          categoryTb3: categoryTb3,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ));
    }
  }

  void _showTimeUpDialog(
      int scoretb1, String categoryTb1, int scoretb2, String categoryTb2, int scoretb3, String categoryTb3) {
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
              onPressed: () {
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      TB_KemampuanBerpikirLogis(
                    scoretb1: widget.scoretb1,
                    categoryTb1: widget.categoryTb1,
                    scoretb2: widget.scoretb2,
                    categoryTb2: widget.categoryTb2,
                    scoretb3: scoretb3,
                    categoryTb3: categoryTb3,
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    final tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    final offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ));
              },
              child: Text(
                'Lanjut ke Tes Selanjutnya',
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
        return 147;
      case 19:
        return 144;
      case 18:
        return 140;
      case 17:
        return 137;
      case 16:
        return 133;
      case 15:
        return 130;
      case 14:
        return 126;
      case 13:
        return 122;
      case 12:
        return 119;
      case 11:
        return 115;
      case 10:
        return 112;
      case 9:
        return 108;
      case 8:
        return 105;
      case 7:
        return 101;
      case 6:
        return 98;
      case 5:
        return 94;
      case 4:
        return 90;
      case 3:
        return 87;
      case 2:
        return 83;
      case 1:
        return 80;
      case 0:
        return 76;
      default:
        return 76; // Skor default jika poin tidak sesuai dengan range yang ada
    }
  }

  String _getResultCategory(int score) {
    // Menentukan kategori hasil berdasarkan nilai score
    if (score >= 76 && score <= 87) {
      return 'Sangat Rendah';
    } else if (score >= 90 && score <= 101) {
      return 'Rendah';
    } else if (score >= 105 && score <= 119) {
      return 'Sedang';
    } else if (score >= 122 && score <= 133) {
      return 'Tinggi';
    } else if (score >= 137 && score <= 147) {
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
    int scoretb3 = _getScore(poin);

    // Menentukan kategori hasil berdasarkan nilai score
    String categoryTb3 = _getResultCategory(scoretb3);

    // Menampilkan hasil score dan kategori
    print('Total Poin: $poin');
    print('Nilai Score: $scoretb3');
    print('Kategori Hasil: $categoryTb3');
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
                  Navigator.of(context).pushNamedAndRemoveUntil('/dashboard', (route) => false);
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Kemampuan Analisis Sintesis',
            style: TextStyle(fontFamily: "Poppins",fontSize: 20),
          ),
        ),
        body: Center(
          child: _showInstructions ? _buildInstructions() : _buildQuestions(),
        ),
      ),
    );
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
                'Instruksi Tes 03 - Kemampuan Analisis Sintesis',
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                    textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Ditentukan 3 (tiga) kata.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'Antara kata pertama dan kata kedua terdapat suatu hubungan yang tertentu.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'Antara kata ketiga dan salah satu diantara lima kata pilihan harus pula terdapat hubungan yang sama itu.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'Carilah kata itu.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 10),
            Text(
              'Contoh 03',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Hutan   :   pohon   =   Tembok   :   ?',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            _buildOptionBox('a. Batu bata'),
            _buildOptionBox('b. Rumah'),
            _buildOptionBox('c. Semen'),
            _buildOptionBox('d. Putih'),
            _buildOptionBox('e. Dinding'),
            SizedBox(height: 16),
            Text(
              'Hubungan antara hutan dan pohon ialah bahwa hutan terdiri atas pohon-pohon, maka hubungan antara tembok ',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'dan salah satu kata pilihan ialah bahwa tembok terdiri atas batu-batu bata. ',
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
            const SizedBox(height: 8),
            Text(
              'Gelap   :   terang   =   Basah   :   ?',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            _buildOptionBox('a. Hujan'),
            _buildOptionBox('b. Hari'),
            _buildOptionBox('c. Lembab'),
            _buildOptionBox('d. Angin'),
            _buildOptionBox('e. Kering'),
            SizedBox(height: 10),
            Text(
              'Gelap ialah lawannya dari terang, maka untuk basah lawannya ialah kering.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'Maka jawaban yang benar ialah : e) kering',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 16),
            Text(
              'WAKTU PENGERJAAN: 7 menit',
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
          .collection('TB Kemampuan Analisis Sintesis')
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

                      int questionNumber = 41 + index;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(
                               'Soal $questionNumber.',
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
                          'Lanjut ke Tes 04',
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
