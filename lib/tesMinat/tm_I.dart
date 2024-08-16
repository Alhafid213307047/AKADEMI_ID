import 'package:akademi_id/tesMinat/Hasil/hasilPage.dart';
import 'package:akademi_id/tesMinat/Jawaban/data_A.dart';
import 'package:akademi_id/tesMinat/Jawaban/data_H.dart';
import 'package:akademi_id/tesMinat/Jawaban/data_I.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'Jawaban/data_B.dart';
import 'Jawaban/data_C.dart';
import 'Jawaban/data_D.dart';
import 'Jawaban/data_E.dart';
import 'Jawaban/data_F.dart';
import 'Jawaban/data_G.dart';

class TM_I extends StatefulWidget {
  final List<int> jawabanA;
  final List<int> jawabanB;
  final List<int> jawabanC;
  final List<int> jawabanD;
  final List<int> jawabanE;
  final List<int> jawabanF;
  final List<int> jawabanG;
  final List<int> jawabanH;

  TM_I({
    required this.jawabanA,
    required this.jawabanB,
    required this.jawabanC,
    required this.jawabanD,
    required this.jawabanE,
    required this.jawabanF,
    required this.jawabanG,
    required this.jawabanH,
  });

  @override
  State<TM_I> createState() => _TM_IState();
}

class _TM_IState extends State<TM_I> {
  final List<String> professions = [
    'Petugas KOMNAS HAM',
    'Pegawai Tata Usaha',
    'Koki/ Chef',
    'Dokter Anak',
    'Atlet',
    'Kontraktor',
    'Petugas pajak',
    'Laboran',
    'Manager Promosi',
    'Perancang motif tekstil',
    'Penyair',
    'Komposer',
  ];

  final List<TextEditingController> controllers =
      List.generate(12, (index) => TextEditingController());
  final List<bool> hasError = List.generate(12, (index) => false);
  bool allFilled = false;

  void _checkAllFilled() {
    setState(() {
      allFilled = controllers.every((controller) => controller.text.isNotEmpty);
    });
  }

  void _checkDuplicate(int index, String value) {
    final int? number = int.tryParse(value);
    if (number != null) {
      if (number < 1 || number > 12) {
        setState(() {
          hasError[index] = true;
        });
      } else {
        setState(() {
          hasError[index] = false;
        });

        final allNumbers = controllers
            .map((controller) => int.tryParse(controller.text))
            .where((number) => number != null)
            .toSet();

        if (allNumbers.length !=
            controllers
                .where((controller) => controller.text.isNotEmpty)
                .length) {
          setState(() {
            hasError[index] = true;
          });
        } else {
          setState(() {
            hasError[index] = false;
          });
        }
      }
      _checkAllFilled();
      _logInput(); // Log input changes
    }
  }

  void _logInput() {
    List<int?> tempAnswers = List.filled(12, null);

    for (int i = 0; i < controllers.length; i++) {
      final value = controllers[i].text;
      if (value.isNotEmpty) {
        final number = int.tryParse(value);
        if (number != null && number >= 1 && number <= 12) {
          if (i == 4) {
            tempAnswers[0] = number; // Index 0 diisi dengan nilai dari index 4
          } else if (i == 5) {
            tempAnswers[1] = number; // Index 1 diisi dengan nilai dari index 5
          } else if (i == 6) {
            tempAnswers[2] = number; // Index 2 diisi dengan nilai dari index 6
          } else if (i == 7) {
            tempAnswers[3] = number; // Index 3 diisi dengan nilai dari index 7
          } else if (i == 8) {
            tempAnswers[4] = number; // Index 4 diisi dengan nilai dari index 8
          } else if (i == 9) {
            tempAnswers[5] = number; // Index 5 diisi dengan nilai dari index 9
          } else if (i == 10) {
            tempAnswers[6] = number; // Index 6 diisi dengan nilai dari index 10
          } else if (i == 11) {
            tempAnswers[7] = number; // Index 7 diisi dengan nilai dari index 11
          } else if (i == 0) {
            tempAnswers[8] = number; // Index 8 diisi dengan nilai dari index 0
          } else if (i == 1) {
            tempAnswers[9] = number; // Index 9 diisi dengan nilai dari index 1
          } else if (i == 2) {
            tempAnswers[10] =
                number; // Index 10 diisi dengan nilai dari index 2
          } else if (i == 3) {
            tempAnswers[11] =
                number; // Index 11 diisi dengan nilai dari index 3
          }
        }
      }
    }

    print(tempAnswers);
  }

  void _handlePrevious() {
    Navigator.pop(context);
  }

  Future<void> _handleNext() async {
    if (allFilled) {
      // Mengambil dan menyusun jawaban
      List<int?> answers = List.generate(12, (i) {
        final value = controllers[i].text;
        final number = int.tryParse(value);
        return number;
      });

      List<int> finalAnswers = List.filled(12, 0);
      finalAnswers[0] = answers[4] ?? 0;
      finalAnswers[1] = answers[5] ?? 0;
      finalAnswers[2] = answers[6] ?? 0;
      finalAnswers[3] = answers[7] ?? 0;
      finalAnswers[4] = answers[8] ?? 0;
      finalAnswers[5] = answers[9] ?? 0;
      finalAnswers[6] = answers[10] ?? 0;
      finalAnswers[7] = answers[11] ?? 0;
      finalAnswers[8] = answers[0] ?? 0;
      finalAnswers[9] = answers[1] ?? 0;
      finalAnswers[10] = answers[2] ?? 0;
      finalAnswers[11] = answers[3] ?? 0;

      Data_I dataI = Data_I(answers: finalAnswers);

      // Inisialisasi data A hingga H dengan data dinamis
      Data_A dataA = Data_A(answers: widget.jawabanA);
      Data_B dataB = Data_B(answers: widget.jawabanB);
      Data_C dataC = Data_C(answers: widget.jawabanC);
      Data_D dataD = Data_D(answers: widget.jawabanD);
      Data_E dataE = Data_E(answers: widget.jawabanE);
      Data_F dataF = Data_F(answers: widget.jawabanF);
      Data_G dataG = Data_G(answers: widget.jawabanG);
      Data_H dataH = Data_H(answers: widget.jawabanH);

      // Menghitung jumlah untuk setiap baris
      List<List<int>> allAnswers = [
        dataA.answers,
        dataB.answers,
        dataC.answers,
        dataD.answers,
        dataE.answers,
        dataF.answers,
        dataG.answers,
        dataH.answers,
        dataI.answers
      ];

      List<int> rowTotals = List.generate(12, (i) {
        return allAnswers.fold<int>(
            0, (acc, answersList) => acc + (answersList[i]));
      });

      // Mendapatkan total dari semua baris
      int totalSum = rowTotals.fold<int>(0, (acc, rowTotal) => acc + rowTotal);

      // Menyimpan hasil ke Firestore
      final User? user = FirebaseAuth.instance.currentUser;
      final String uid = user?.uid ?? '';
      final String formattedDate =
          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now());

      final Map<String, int> rows = {
        'out': rowTotals[0],
        'me': rowTotals[1],
        'comp': rowTotals[2],
        'sci': rowTotals[3],
        'pers': rowTotals[4],
        'aesth': rowTotals[5],
        'lit': rowTotals[6],
        'mus': rowTotals[7],
        'sos': rowTotals[8],
        'cler': rowTotals[9],
        'prac': rowTotals[10],
        'med': rowTotals[11],
      };

      final List<MapEntry<String, int>> sortedRows = rows.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));

      final List<String> rank = sortedRows.map((entry) => entry.key).toList();

      final Map<String, dynamic> data = {
        'tanggal': formattedDate,
        'out': rowTotals[0],
        'me': rowTotals[1],
        'comp': rowTotals[2],
        'sci': rowTotals[3],
        'pers': rowTotals[4],
        'aesth': rowTotals[5],
        'lit': rowTotals[6],
        'mus': rowTotals[7],
        'sos': rowTotals[8],
        'cler': rowTotals[9],
        'prac': rowTotals[10],
        'med': rowTotals[11],
        'total': totalSum,
        'baris1': dataA.answers,
        'baris2': dataB.answers,
        'baris3': dataC.answers,
        'baris4': dataD.answers,
        'baris5': dataE.answers,
        'baris6': dataF.answers,
        'baris7': dataG.answers,
        'baris8': dataH.answers,
        'baris9': dataI.answers,
        'rank': rank,
      };

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('HistoryTesMinat')
          .add(data);

      // Navigasi ke halaman hasil
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HasilPage(),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelompok I',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.green,
                    child: Text(
                      'I',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Table(
                    border: TableBorder.all(color: Colors.grey),
                    columnWidths: const {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(1),
                    },
                    children: [
                      for (int i = 0; i < professions.length; i++)
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                professions[i],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                if (hasError[i])
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                Expanded(
                                  child: TextField(
                                    controller: controllers[i],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        _checkDuplicate(i, value);
                                      }
                                      _checkAllFilled(); // Ensure button color updates
                                    },
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: 
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: (allFilled && !hasError.contains(true))
                          ? _handleNext
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (allFilled && !hasError.contains(true))
                            ? Colors.green
                            : Colors.grey,
                        padding: EdgeInsets.all(16.0),
                      ),
                      child: const Text(
                        "Lihat Hasil",
                        style:
                            TextStyle(fontFamily: "Poppins", color: Colors.white),
                      )),
                ),
          ),
        ],
      ),
    );
  }
}
