import 'dart:async';
import 'package:akademi_id/tesBakat/tb9_DayaIngatDanKonsentrasi.dart';
import 'package:flutter/material.dart';

class TB_KemampuanSpasial extends StatefulWidget {
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
  const TB_KemampuanSpasial({
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
  });

  @override
  State<TB_KemampuanSpasial> createState() => _TB_KemampuanSpasialState();
}

class _TB_KemampuanSpasialState extends State<TB_KemampuanSpasial> {
  bool _showInstructions = true;
  List<String> _selectedAnswers =
      List.filled(20, ''); // Untuk menyimpan jawaban sementara
  late Timer _timer;
  int _secondsLeft = 540; // 9 menit dalam detik

  final Map<int, String> _keyAnswers = {
    1: 'A',
    2: 'C',
    3: 'D',
    4: 'E',
    5: 'A',
    6: 'C',
    7: 'D',
    8: 'C',
    9: 'E',
    10: 'A',
    11: 'B',
    12: 'D',
    13: 'E',
    14: 'B',
    15: 'D',
    16: 'B',
    17: 'A',
    18: 'E',
    19: 'B',
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
        int scoretb8 = _getScore(poin);
        int scoretb1 = widget.scoretb1;
        int scoretb2 = widget.scoretb2;
        int scoretb3 = widget.scoretb3;
        int scoretb4 = widget.scoretb4;
        int scoretb5 = widget.scoretb5;
        int scoretb6 = widget.scoretb6;
        int scoretb7 = widget.scoretb7;
        String categoryTb8 = _getResultCategory(scoretb8);
        String categoryTb1 = widget.categoryTb1;
        String categoryTb2 = widget.categoryTb2;
        String categoryTb3 = widget.categoryTb3;
        String categoryTb4 = widget.categoryTb4;
        String categoryTb5 = widget.categoryTb5;
        String categoryTb6 = widget.categoryTb6;
        String categoryTb7 = widget.categoryTb7;
        print('Total Poin: $poin');
        print('Nilai Score: $scoretb8');
        print('Kategori Hasil: $categoryTb8');
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
            categoryTb8,);
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
      // Debug print statements
      print('Index $i: Selected Answer: ${_selectedAnswers[i]}');
      String correctAnswer = _keyAnswers[i + 1] ?? '';
      print('Key Answer: $correctAnswer');
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
      int scoretb8 = _getScore(poin);
      String categoryTb8 = _getResultCategory(scoretb8);

      print('Total Poin: $poin');
      print('Nilai Score: $scoretb8');
      print('Kategori Hasil: $categoryTb8');
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            TB_DayaIngatDanKonsentrasi(
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
          scoretb7: widget.scoretb7,
          categoryTb7: widget.categoryTb7,
          scoretb8: scoretb8,
          categoryTb8: categoryTb8,
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
    int scoretb8,
    String categoryTb8,
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
                      TB_DayaIngatDanKonsentrasi(
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
                    scoretb7: widget.scoretb7,
                    categoryTb7: widget.categoryTb7,
                    scoretb8: scoretb8,
                    categoryTb8: categoryTb8,
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
        return 133;
      case 19:
        return 130;
      case 18:
        return 127;
      case 17:
        return 124;
      case 16:
        return 121;
      case 15:
        return 118;
      case 14:
        return 115;
      case 13:
        return 112;
      case 12:
        return 109;
      case 11:
        return 106;
      case 10:
        return 103;
      case 9:
        return 100;
      case 8:
        return 97;
      case 7:
        return 94;
      case 6:
        return 91;
      case 5:
        return 88;
      case 4:
        return 85;
      case 3:
        return 82;
      case 2:
        return 79;
      case 1:
        return 76;
      case 0:
        return 74; // Perbarui nilai untuk poin 0
      default:
        return 74; // Skor default jika poin tidak sesuai dengan range yang ada
    }
  }


  String _getResultCategory(int score) {
    // Menentukan kategori hasil berdasarkan nilai score
    if (score >= 74 && score <= 82) {
      return 'Sangat Rendah';
    } else if (score >= 85 && score <= 94) {
      return 'Rendah';
    } else if (score >= 97 && score <= 109) {
      return 'Sedang';
    } else if (score >= 112 && score <= 121) {
      return 'Tinggi';
    } else if (score >= 124 && score <= 133) {
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
            'Kemampuan Spasial',
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
                'Instruksi Tes 08 - Kemampuan Spasial',
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Ditentukan 5(lima) buah kubus a, b, c, d, e. Pada tiap-tiap kubus terdapat enam tanda yang berlainan pada setiap sisinya. Tiga dari tanda itu dapat dilihat.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'Kubus-kubus yang ditentukan itu (a, b, c, d, e) ialah kubus-kubus yang berbeda, artinya kubus-kubus itu dapat mempunyai tanda-tanda yang sama, akan tetapi susunannya berlainan. Setiap soal memperlihatkan salah satu kubus yang ditentukan di dalam kedudukan yang berbeda.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'Carilah kubus yang dimaksudkan itu dan pilihlah jawaban saudara pada nomor soal yang sesuai.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'Kubus itu dapat diputar, dapat digulingkan atau dapat diputar digulingkan dalam pikiran saudara.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'Oleh karena itu mungkin akan terlihat suatu tanda yang baru.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/images/tb08/contoh_soal.png',
              fit: BoxFit
                  .cover, // Menyesuaikan ukuran gambar dengan area tampilan
            ),
            SizedBox(height: 16),
            Text(
              'Contoh 08',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Contoh ini memperlihatkan kubus a dengan kedudukan yang berbeda.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Mendapatkannya adalah dengan cara menggulingkan lebih dahulu kubus itu ke kiri satu kali dan kemudian diputar ke kiri satu kali, sehingga sisi kubus yang bertanda dua segi empat hitam terletak di depan, seperti kubus a.',
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
              'Contoh kedua adalah kubus e.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cara mendapatkannya adalalah dengan digulingkan ke kiri satu kali dan diputar ke kiri satu kali, Sehingga sisi kubus yang bertanda garis silang terletak di depan, seperti kubus e.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Contoh ketiga adalah kubus b.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cara mendapatkannya adalah dengan menggulingkannya ke kiri satu kali, sehingga dasar kubus yang tadinya tidak terlihat memunculkan tanda baru (dalam hal ini adalah tanda dua segi empat hitam) dan tanda silang pada sisi atas kubus itu menjadi tidak terlihat lagi.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Contoh keempat menunjukkan kubus c.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              'Contoh kelima adalah kubus d.',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'WAKTU PENGERJAAN: 9 menit',
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
      SizedBox(height: 10), // Jarak antara teks dan gambar
      Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 6,
                right: 6,
              ),
              child: Text(
                'Opsi Jawaban',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset(
              'assets/images/tb08/jawaban.png',
            ),
          ],
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
              // Gambar Bagian A
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/tb08/soal_A.png'),
              ),
              // Daftar nomor untuk Bagian A
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(10, (index) {
                    int number = 137 + index;
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
                          SizedBox(width: 16), // Jarak antara nomor dan tombol
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
                child: Image.asset('assets/images/tb08/soal_B.png'),
              ),
              SizedBox(height: 10),
              // Daftar nomor untuk Bagian B
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(10, (index) {
                    int number = 147 + index;
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
                          SizedBox(width: 16), // Jarak antara nomor dan tombol
                          Row(
                            children: List.generate(5, (opIndex) {
                              String optionLabel =
                                  _getOptionLabel(opIndex + 1);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    String selectedOption = optionLabel;
                                    _selectedAnswers[index + 10] =
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
                                    color: _selectedAnswers[index + 10] ==
                                            optionLabel
                                        ? Color.fromARGB(255, 46, 155, 233)
                                        : Colors.grey[300],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      optionLabel,
                                      style: TextStyle(
                                        color: _selectedAnswers[index + 10] ==
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
                      'Lanjut ke Tes 09',
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
        ),)
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
