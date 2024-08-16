import 'dart:async';
import 'package:akademi_id/tesBakat/tb7_KemampuanImajinasi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TB_KemampuanTheoricNumeric extends StatefulWidget {
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

  const TB_KemampuanTheoricNumeric({
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
  });

  @override
  State<TB_KemampuanTheoricNumeric> createState() =>
      _TB_KemampuanTheoricNumericState();
}

class _TB_KemampuanTheoricNumericState
    extends State<TB_KemampuanTheoricNumeric> {
  bool _showInstructions = true;
  List<String> _selectedAnswers =
      List.filled(20, ''); // Untuk menyimpan jawaban sementara
  late Timer _timer;
  int _secondsLeft = 600; // 10 menit dalam detik

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (_secondsLeft == 0) {
        timer.cancel();
        // Mengumpulkan jawaban dan menampilkan dialog waktu habis
        int poin = await _calculatePoints();
        int scoretb6 = _getScore(poin);
        int scoretb1 = widget.scoretb1;
        int scoretb2 = widget.scoretb2;
        int scoretb3 = widget.scoretb3;
        int scoretb4 = widget.scoretb4;
        int scoretb5 = widget.scoretb5;
        String categoryTb6 = _getResultCategory(scoretb6);
        String categoryTb1 = widget.categoryTb1;
        String categoryTb2 = widget.categoryTb2;
        String categoryTb3 = widget.categoryTb3;
        String categoryTb4 = widget.categoryTb4;
        String categoryTb5 = widget.categoryTb5;
        print('Total Poin: $poin');
        print('Nilai Score: $scoretb6');
        print('Kategori Hasil: $categoryTb6');
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
            categoryTb6);
      } else {
        setState(() {
          _secondsLeft--;
        });
      }
    });
  }

  Future<int> _calculatePoints() async {
    int totalPoints = 0;

    // Ambil koleksi 'TB Kemampuan Practice-Numeric'
    var collection =
        FirebaseFirestore.instance.collection('TB Kemampuan Theoretic-Numeric');
    var snapshot = await collection.get();

    for (var doc in snapshot.docs) {
      // Ambil ID dokumen dan jawaban yang benar dari dokumen
      String docId = doc.id;
      int correctAnswer =
          doc['jawaban'] ?? 0; // Misalkan jawaban benar bertipe int

      // Ambil jawaban pengguna berdasarkan ID dokumen
      int index = int.parse(docId) - 97; // Sesuaikan dengan nomor pertanyaan
      int userAnswer;

      // Cek apakah jawaban pengguna bisa dikonversi menjadi int
      try {
        userAnswer = int.parse(_selectedAnswers[index]);
      } catch (e) {
        userAnswer = 0; // Nilai default jika konversi gagal
      }

      // Periksa apakah jawaban pengguna sesuai dengan jawaban yang benar
      if (userAnswer == correctAnswer) {
        totalPoints += 1;
      }

      // Print ID dokumen, jawaban pengguna, dan total poin saat ini dalam satu baris
      print(
          'Doc ID: $docId, Jawaban Pengguna: $userAnswer, Total Poin: $totalPoints');
    }

    return totalPoints;
  }

  void _submitAnswers() async {
    // Menunggu hasil dari _calculatePoints() dan mengubahnya menjadi integer
    int poin = await _calculatePoints();
    int scoretb6 = _getScore(poin);
    String categoryTb6 = _getResultCategory(scoretb6);

    // Menampilkan hasil di konsol
    print('Total Poin: $poin');
    print('Nilai Score: $scoretb6');
    print('Kategori Hasil: $categoryTb6');

    // Navigasi ke halaman berikutnya dengan transisi animasi
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          TB_KemampuanImajinasi(
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
        scoretb6: scoretb6,
        categoryTb6: categoryTb6,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Posisi awal animasi
        const end = Offset.zero; // Posisi akhir animasi
        const curve = Curves.easeInOut; // Kurva animasi
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
                      TB_KemampuanImajinasi(
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
                    scoretb6: scoretb6,
                    categoryTb6: categoryTb6,
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
    // Mendefinisikan nilai skor dan kategori berdasarkan total poin
    switch (poin) {
      case 20:
        return 126;
      case 19:
        return 123;
      case 18:
        return 121;
      case 17:
        return 119;
      case 16:
        return 116;
      case 15:
        return 114;
      case 14:
        return 112;
      case 13:
        return 109;
      case 12:
        return 107;
      case 11:
        return 105;
      case 10:
        return 103;
      case 9:
        return 100;
      case 8:
        return 98;
      case 7:
        return 95;
      case 6:
        return 93;
      case 5:
        return 91;
      case 4:
        return 88;
      case 3:
        return 86;
      case 2:
        return 84;
      case 1:
        return 81;
      case 0:
        return 79;
      default:
        return 79; // Skor default jika poin tidak sesuai dengan range yang ada
    }
  }

  String _getResultCategory(int score) {
    // Menentukan kategori hasil berdasarkan nilai score
    if (score >= 79 && score <= 86) {
      return 'Sangat Rendah';
    } else if (score >= 88 && score <= 95) {
      return 'Rendah';
    } else if (score >= 98 && score <= 107) {
      return 'Sedang';
    } else if (score >= 109 && score <= 116) {
      return 'Tinggi';
    } else if (score >= 119 && score <= 126) {
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
            'Kemampuan Theoretic Numeric',
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
                'Instruksi Tes 06 - Kemampuan Theoretic Numeric',
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Pada persoalan berikut akan diberikan deret angka.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 10),
            Text(
              'Setiap deret tersusun menurut suatu aturan yang tertentu dan dapat dilanjutkan menurut aturan itu.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 10),
            Text(
              'Carilah untuk setiap deret, angka berikutnya dan pilihlah angka sesuai jawaban anda.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 10),
            Text(
              'Contoh 06',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '2 , 4 , 6 , 8 , 10 , 12 , 14 , ? ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: '16',
              style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color(0xFF04558F)), // Warna border saat fokus
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color(
                          0xFF04558F)), // Warna border saat tidak bisa diedit
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Jawaban',
                labelStyle: TextStyle(
                    fontFamily: 'Poppins', fontSize: 16, color: Colors.black),
              ),
              enabled: false, // Menetapkan TextFormField tidak dapat diedit
            ),
            SizedBox(height: 8),
            Text(
              'Pada deret angka berikutnya selalu didapat jika angka di depannya ditambah dengan 2.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Maka jawabannya ialah 16 ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Contoh Berikutnya :',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '9 , 7 , 10 ,	8 ,	11 , 9 , 12 ,	? ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue: '10',
              style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color(0xFF04558F)), // Warna border saat fokus
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color(
                          0xFF04558F)), // Warna border saat tidak bisa diedit
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Jawaban',
                labelStyle: TextStyle(
                    fontFamily: 'Poppins', fontSize: 16, color: Colors.black),
              ),
              enabled: false, // Menetapkan TextFormField tidak dapat diedit
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Pada deret ini selalu berganti-ganti harus dikurangi dengan 2 dan setelahitu ditambah dengan 3. ',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'jawaban contoh ini ialah : 10',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 8),
            Text(
              'Kadang-kadang pada beberapa soal harus pula dikalikan atau dibagi.',
              style: TextStyle(fontFamily: "Poppins"),
            ),
            SizedBox(height: 16),
            Text(
              'WAKTU PENGERJAAN: 10 menit',
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
          .collection('TB Kemampuan Theoretic-Numeric')
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

        // Inisialisasi _selectedAnswers jika panjangnya tidak sesuai
        if (_selectedAnswers.length != docs.length) {
          _selectedAnswers = List<String>.filled(docs.length, '');
        }

        // Periksa apakah semua jawaban sudah diisi
        bool allAnswered = _selectedAnswers.length == docs.length &&
            _selectedAnswers.every((answer) => answer.isNotEmpty);

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
            // SingleChildScrollView yang berisi pertanyaan
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(docs.length, (index) {
                      var doc = docs[index];
                      String soal = doc['soal'] ?? '';
                      int questionNumber = 97 + index;

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
                          TextFormField(
                            initialValue: _selectedAnswers[index],
                            decoration: InputDecoration(
                              labelText: 'jawab disini',
                              labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.grey.shade400),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Jawaban tidak boleh kosong';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _selectedAnswers[index] = value;
                                // Perbarui allAnswered berdasarkan jawaban yang diisi
                                allAnswered = _selectedAnswers.length ==
                                        docs.length &&
                                    _selectedAnswers
                                        .every((answer) => answer.isNotEmpty);
                                _calculatePoints();
                              });
                            },
                          ),
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
                          'Lanjut ke Tes 07',
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
