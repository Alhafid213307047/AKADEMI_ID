import 'package:akademi_id/tesMinat/Jawaban/data_F.dart';
import 'package:akademi_id/tesMinat/tm_G.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TM_F extends StatefulWidget {
  final List<int> jawabanA;
  final List<int> jawabanB;
  final List<int> jawabanC;
  final List<int> jawabanD;
  final List<int> jawabanE;

  TM_F({
    required this.jawabanA,
    required this.jawabanB,
    required this.jawabanC,
    required this.jawabanD,
    required this.jawabanE,
  });

  @override
  State<TM_F> createState() => _TM_FState();
}

class _TM_FState extends State<TM_F> {
  final List<String> professions = [
    'Fotografer',
    'Penulis majalah',
    'Pemain orgel (organ)',
    'Relawan Palang Merah',
    'Pegawai bank',
    'Desainer Grafis',
    'Perawat',
    'Peternak',
    'Ahli Farmasi',
    'Analis Sistem Komputer',
    'Ahli botani',
    'Eksportir & Importir',
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
          // Menyusun nilai dengan benar sesuai dengan urutan
          if (i == 7) {
            tempAnswers[0] = number; // Index 0 diisi dengan nilai dari index 7
          } else if (i == 8) {
            tempAnswers[1] = number; // Index 1 diisi dengan nilai dari index 8
          } else if (i == 9) {
            tempAnswers[2] = number; // Index 2 diisi dengan nilai dari index 9
          } else if (i == 10) {
            tempAnswers[3] = number; // Index 3 diisi dengan nilai dari index 10
          } else if (i == 11) {
            tempAnswers[4] = number; // Index 4 diisi dengan nilai dari index 11
          } else {
            tempAnswers[i + 5] = number; // Baris lainnya mengikuti urutan
          }
        }
      }
    }

    // Mengisi nilai default jika kosong
    print(tempAnswers);
  }

  void _handlePrevious() {
    Navigator.pop(context);
  }

  void _handleNext() {
    if (allFilled) {
      List<int?> answers = List.generate(12, (i) {
        final value = controllers[i].text;
        final number = int.tryParse(value);
        return number;
      });

      // Menyusun nilai dengan benar sesuai dengan urutan
      List<int> finalAnswersF = List.filled(12, 0);
      finalAnswersF[0] =
          answers[7] ?? 0; // Index 0 diisi dengan nilai dari index 7
      finalAnswersF[1] =
          answers[8] ?? 0; // Index 1 diisi dengan nilai dari index 8
      finalAnswersF[2] =
          answers[9] ?? 0; // Index 2 diisi dengan nilai dari index 9
      finalAnswersF[3] =
          answers[10] ?? 0; // Index 3 diisi dengan nilai dari index 10
      finalAnswersF[4] =
          answers[11] ?? 0; // Index 4 diisi dengan nilai dari index 11
      for (int i = 5; i < 12; i++) {
        finalAnswersF[i] = answers[i - 5] ?? 0; // Baris lainnya mengikuti urutan
      }

      Data_F dataF = Data_F(answers: finalAnswersF);
      print(dataF.answers);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TM_G(
            jawabanA: widget.jawabanA,
            jawabanB: widget.jawabanB,
            jawabanC: widget.jawabanC,
            jawabanD: widget.jawabanD,
            jawabanE: widget.jawabanE,
            jawabanF: finalAnswersF
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelompok F',
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
                      'F',
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
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: (allFilled && !hasError.contains(true))
                    ? _handleNext
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: (allFilled && !hasError.contains(true))
                      ? const Color.fromARGB(255, 46, 155, 233)
                      : Colors.grey,
                  padding: EdgeInsets.all(16.0),
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
