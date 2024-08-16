import 'dart:async';
import 'package:akademi_id/tesBakat/tb8_KemampuanSpasial.dart';
import 'package:flutter/material.dart';

class TB_KemampuanImajinasi extends StatefulWidget {
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
  const TB_KemampuanImajinasi({
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
  });

  @override
  State<TB_KemampuanImajinasi> createState() => _TB_KemampuanImajinasiState();
}

class _TB_KemampuanImajinasiState extends State<TB_KemampuanImajinasi> {
  bool _showInstructions = true;
  List<String> _selectedAnswers =
      List.filled(20, ''); // Untuk menyimpan jawaban sementara
  late Timer _timer;
  int _secondsLeft = 420; // 7 menit dalam detik

  final Map<int, String> _keyAnswers = {
    1: 'A',
    2: 'C',
    3: 'B',
    4: 'A',
    5: 'D',
    6: 'B',
    7: 'C',
    8: 'E',
    9: 'E',
    10: 'D',
    11: 'E',
    12: 'B',
    13: 'D',
    14: 'C',
    15: 'B',
    16: 'A',
    17: 'B',
    18: 'D',
    19: 'C',
    20: 'C',
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
        // Mengumpulkan jawaban dan menampilkan dialog waktu habis
        int poin = _calculatePoints();
        int scoretb7 = _getScore(poin);
        int scoretb1 = widget.scoretb1;
        int scoretb2 = widget.scoretb2;
        int scoretb3 = widget.scoretb3;
        int scoretb4 = widget.scoretb4;
        int scoretb5 = widget.scoretb5;
        int scoretb6 = widget.scoretb6;
        String categoryTb7 = _getResultCategory(scoretb7);
        String categoryTb1 = widget.categoryTb1;
        String categoryTb2 = widget.categoryTb2;
        String categoryTb3 = widget.categoryTb3;
        String categoryTb4 = widget.categoryTb4;
        String categoryTb5 = widget.categoryTb5;
        String categoryTb6 = widget.categoryTb6;
        print('Total Poin: $poin');
        print('Nilai Score: $scoretb7');
        print('Kategori Hasil: $categoryTb7');
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
            categoryTb7);
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
      int scoretb7 = _getScore(poin);
      String categoryTb7 = _getResultCategory(scoretb7);

      print('Total Poin: $poin');
      print('Nilai Score: $scoretb7');
      print('Kategori Hasil: $categoryTb7');
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            TB_KemampuanSpasial(
          scoretb1: widget.scoretb1,
          categoryTb1: widget.categoryTb1,
          scoretb2: widget.scoretb2,
          categoryTb2: widget.categoryTb2,
          scoretb3: widget.scoretb3,
          categoryTb3: widget.categoryTb3,
          scoretb4: widget.scoretb4,
          categoryTb4: widget.categoryTb4,
          scoretb5: widget.scoretb5,
          categoryTb5: widget.categoryTb5,
          scoretb6: widget.scoretb6,
          categoryTb6: widget.categoryTb6,
          scoretb7: scoretb7,
          categoryTb7: categoryTb7,
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
  ) {
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
                      TB_KemampuanSpasial(
                    scoretb1: widget.scoretb1,
                    categoryTb1: widget.categoryTb1,
                    scoretb2: widget.scoretb2,
                    categoryTb2: widget.categoryTb2,
                    scoretb3: widget.scoretb3,
                    categoryTb3: widget.categoryTb3,
                    scoretb4: widget.scoretb4,
                    categoryTb4: widget.categoryTb4,
                    scoretb5: widget.scoretb5,
                    categoryTb5: widget.categoryTb5,
                    scoretb6: widget.scoretb6,
                    categoryTb6: widget.categoryTb6,
                    scoretb7: scoretb7,
                    categoryTb7: categoryTb7,
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
        return 131;
      case 19:
        return 128;
      case 18:
        return 124;
      case 17:
        return 121;
      case 16:
        return 118;
      case 15:
        return 115;
      case 14:
        return 112;
      case 13:
        return 108;
      case 12:
        return 105;
      case 11:
        return 102;
      case 10:
        return 99;
      case 9:
        return 95;
      case 8:
        return 92;
      case 7:
        return 89;
      case 6:
        return 86;
      case 5:
        return 82;
      case 4:
        return 79;
      case 3:
        return 76;
      case 2:
        return 73;
      case 1:
        return 69;
      case 0:
        return 66;
      default:
        return 66; // Skor default jika poin tidak sesuai dengan range yang ada
    }
  }

  String _getResultCategory(int score) {
    // Menentukan kategori hasil berdasarkan nilai score
    if (score >= 66 && score <= 76) {
      return 'Sangat Rendah';
    } else if (score >= 79 && score <= 89) {
      return 'Rendah';
    } else if (score >= 92 && score <= 105) {
      return 'Sedang';
    } else if (score >= 108 && score <= 118) {
      return 'Tinggi';
    } else if (score >= 121 && score <= 131) {
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Kemampuan Imajinasi',
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
                'Instruksi Tes 07 - Kemampuan Imajinasi',
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Pada persoalan berikutnya, setiap soal memperlihatkan sesuatu bentuk tertentu yang terpotong menjadi beberapa bagian. ',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'Carilah di antara bentuk-bentuk yang ditentukan (a, b, c, d, e) bentuk yang dapat dibangun dengan cara menyusun potongan-potongan itu sedemikian rupa sehingga tidak ada kelebihan sudut atau ruang di antaranya.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'Carilah bentuk-bentuk itu dan pilihlah jawabannya.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/images/tb07/contoh_soal.png',
              fit: BoxFit
                  .cover, // Menyesuaikan ukuran gambar dengan area tampilan
            ),
            SizedBox(height: 16),
            Text(
              'Contoh 07',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Jika potongan-potongan pada contoh 07 di atas disusun (digabungkan), maka akan menghasilkan bentuk a.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Contoh berikutnya :',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Potongan-potongan contoh kedua setelah disusun (digabungkan) menghasilkan bentuk e.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Contoh ketiga menjadi bentuk b.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Contoh keempat ialah bentuk d.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
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
    bool allAnswered = _selectedAnswers.every((answer) => answer.isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Teks di atas
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
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
        SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian A
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Bagian A',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Gambar Bagian A
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/tb07/soal_A.png'),
                ),
                // Daftar nomor untuk Bagian A
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(12, (index) {
                      int number = 117 + index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Soal $number. ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 16), // Jarak antara nomor dan tombol
                            Row(
                              children: List.generate(5, (opIndex) {
                                String optionLabel =
                                    _getOptionLabel(opIndex + 1);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      String selectedOption = optionLabel;
                                      _selectedAnswers[index] = selectedOption;
                                      _calculatePoints(); // Fungsi ini untuk logging jika diperlukan
                                    });
                                  },
                                  child: Container(
                                    width: 50, // Lebar tombol lingkaran
                                    height: 50, // Tinggi tombol lingkaran
                                    margin: const EdgeInsets.only(
                                        right: 16.0), // Jarak antar tombol
                                    decoration: BoxDecoration(
                                      color: _selectedAnswers[index] ==
                                              optionLabel
                                          ? Color.fromARGB(255, 46, 155, 233)
                                          : Colors.grey[300],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        optionLabel,
                                        style: TextStyle(
                                          color: _selectedAnswers[index] ==
                                                  optionLabel
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: 20),
                // Bagian B
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Bagian B',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Gambar Bagian B
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/tb07/soal_B.png'),
                ),
                SizedBox(height: 10),
                // Daftar nomor untuk Bagian B
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(8, (index) {
                      int number = 129 + index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Soal $number.',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 16), // Jarak antara nomor dan tombol
                            Row(
                              children: List.generate(5, (opIndex) {
                                String optionLabel =
                                    _getOptionLabel(opIndex + 1);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      String selectedOption = optionLabel;
                                      _selectedAnswers[index + 12] =
                                          selectedOption; // Offset index untuk Bagian B
                                      _calculatePoints(); // Fungsi ini untuk logging jika diperlukan
                                    });
                                  },
                                  child: Container(
                                    width: 50, // Lebar tombol lingkaran
                                    height: 50, // Tinggi tombol lingkaran
                                    margin: const EdgeInsets.only(
                                        right: 16.0), // Jarak antar tombol
                                    decoration: BoxDecoration(
                                      color: _selectedAnswers[index + 12] ==
                                              optionLabel
                                          ? Color.fromARGB(255, 46, 155, 233)
                                          : Colors.grey[300],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        optionLabel,
                                        style: TextStyle(
                                          color: _selectedAnswers[index + 12] ==
                                                  optionLabel
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 20),
                // Button Lanjut
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
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
                        'Lanjut ke Tes 08',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
}
