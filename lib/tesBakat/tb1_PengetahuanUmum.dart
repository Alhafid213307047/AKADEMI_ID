import 'dart:async';

import 'package:akademi_id/tesBakat/tb2_KemampuanVerbal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TBPengetahuan_Umum extends StatefulWidget {
  const TBPengetahuan_Umum({super.key});

  @override
  State<TBPengetahuan_Umum> createState() => _TBPengetahuan_UmumState();
}

class _TBPengetahuan_UmumState extends State<TBPengetahuan_Umum> {
  bool _showInstructions = true;
  List<String> _selectedAnswers =
      List.filled(20, ''); // Untuk menyimpan jawaban sementara
  late Timer _timer;
  int _secondsLeft = 360; // 6 menit dalam detik

  final Map<int, String> _keyAnswers = {
    1: 'E',
    2: 'C',
    3: 'D',
    4: 'D',
    5: 'D',
    6: 'B',
    7: 'C',
    8: 'A',
    9: 'E',
    10: 'B',
    11: 'C',
    12: 'D',
    13: 'D',
    14: 'E',
    15: 'C',
    16: 'A',
    17: 'B',
    18: 'B',
    19: 'C',
    20: 'B',
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
        int scoretb1 = _getScore(poin);
        String categoryTb1 = _getResultCategory(scoretb1);
        print('Total Poin: $poin');
        print('Nilai Score: $scoretb1');
        print('Kategori Hasil: $categoryTb1');
        _showTimeUpDialog(scoretb1, categoryTb1);
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
      int scoretb1 = _getScore(poin);
      String categoryTb1 = _getResultCategory(scoretb1);

      print('Total Poin: $poin');
      print('Nilai Score: $scoretb1');
      print('Kategori Hasil: $categoryTb1');
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            TBKemampuan_Verbal(
          scoretb1: scoretb1,
          categoryTb1: categoryTb1,
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


  void _showTimeUpDialog(int scoretb1, String categoryTb1) {
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
                      TBKemampuan_Verbal(
                    scoretb1: scoretb1,
                    categoryTb1: categoryTb1,
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
        return 151;
      case 19:
        return 147;
      case 18:
        return 143;
      case 17:
        return 139;
      case 16:
        return 134;
      case 15:
        return 130;
      case 14:
        return 126;
      case 13:
        return 122;
      case 12:
        return 118;
      case 11:
        return 114;
      case 10:
        return 110;
      case 9:
        return 106;
      case 8:
        return 102;
      case 7:
        return 98;
      case 6:
        return 94;
      case 5:
        return 90;
      case 4:
        return 86;
      case 3:
        return 82;
      case 2:
        return 77;
      case 1:
        return 73;
      case 0:
        return 69;
      default:
        return 0; // Skor default jika poin tidak sesuai dengan range yang ada
    }
  }

  String _getResultCategory(int score) {
    // Menentukan kategori hasil berdasarkan nilai score
    if (score >= 69 && score <= 82) {
      return 'Sangat Rendah';
    } else if (score >= 86 && score <= 98) {
      return 'Rendah';
    } else if (score >= 102 && score <= 118) {
      return 'Sedang';
    } else if (score >= 122 && score <= 134) {
      return 'Tinggi';
    } else if (score >= 139 && score <= 151) {
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
    int scoretb1 = _getScore(poin);

    // Menentukan kategori hasil berdasarkan nilai score
    String categoryTb1 = _getResultCategory(scoretb1);

    // Menampilkan hasil score dan kategori
    print('Total Poin: $poin');
    print('Nilai Score: $scoretb1');
    print('Kategori Hasil: $categoryTb1');
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
            'Pengetahuan Umum',
            style: TextStyle(fontFamily: "Poppins",
            fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: _showInstructions ? _buildInstructions() : _buildQuestions(),
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
                'Instruksi Tes 01 - Pengetahuan Umum',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Soal-soal 01-20 terdiri atas kalimat-kalimat.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pada setiap kalimat satu kata hilang dan disediakan 5 (lima) kata pilihan sebagai penggantinya.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pilihlah kata yang tepat menyempurnakan kalimat itu!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Contoh 1',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Seekor kuda mempunyai kesamaan terbanyak dengan seekor..............',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            _buildOptionBox('a. Kucing'),
            _buildOptionBox('b. Bajing'),
            _buildOptionBox('c. Keledai'),
            _buildOptionBox('d. Lembu'),
            _buildOptionBox('e. Anjing'),
            const SizedBox(height: 8),
            Text(
              'Jawaban yang benar ialah : c) keledai',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Contoh berikutnya:',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'lawannya “harapan” ialah..............',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            _buildOptionBox('a. Duka'),
            _buildOptionBox('b. Putus asa'),
            _buildOptionBox('c. Sengsara'),
            _buildOptionBox('d. Cinta'),
            _buildOptionBox('e. Benci'),
            const SizedBox(height: 8),
            Text(
              'Jawabannya ialah : b) putus asa',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'WAKTU PENGERJAAN: 6 menit',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
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

Widget _buildQuestions() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('TB Pengetahuan Umum')
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
              height: MediaQuery.of(context).size.height -200, // Adjust height as needed
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
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              'Soal ${index + 1}.',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 6),
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
                          'Lanjut ke Tes 02',
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
