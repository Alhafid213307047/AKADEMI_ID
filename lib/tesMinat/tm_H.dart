import 'package:akademi_id/tesMinat/Jawaban/data_H.dart';
import 'package:akademi_id/tesMinat/tm_I.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TM_H extends StatefulWidget {
  final List<int> jawabanA;
  final List<int> jawabanB;
  final List<int> jawabanC;
  final List<int> jawabanD;
  final List<int> jawabanE;
  final List<int> jawabanF;
  final List<int> jawabanG;

  TM_H({
    required this.jawabanA,
    required this.jawabanB,
    required this.jawabanC,
    required this.jawabanD,
    required this.jawabanE,
    required this.jawabanF,
    required this.jawabanG,
  });

  @override
  State<TM_H> createState() => _TM_HState();
}

class _TM_HState extends State<TM_H> {
  final List<String> professions = [
    'Vokalis band',
    'Konsultan',
    'Ahli Tata Negara',
    'Trainer',
    'Bidan',
    'Tour Guide',
    'Instalator Listrik',
    'Developer Multimedia',
    'Ahli geologi',
    'Petugas Hubungan Masyarakat',
    'Pelukis',
    'Penulis sandiwara radio',
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
          if (i == 5) {
            tempAnswers[0] = number; // Index 0 diisi dengan nilai dari index 5
          } else if (i == 6) {
            tempAnswers[1] = number; // Index 1 diisi dengan nilai dari index 6
          } else if (i == 7) {
            tempAnswers[2] = number; // Index 2 diisi dengan nilai dari index 7
          } else if (i == 8) {
            tempAnswers[3] = number; // Index 3 diisi dengan nilai dari index 8
          } else if (i == 9) {
            tempAnswers[4] = number; // Index 4 diisi dengan nilai dari index 9
          } else if (i == 10) {
            tempAnswers[5] = number; // Index 5 diisi dengan nilai dari index 10
          } else if (i == 11) {
            tempAnswers[6] = number; // Index 6 diisi dengan nilai dari index 11
          } else if (i == 0) {
            tempAnswers[7] = number; // Index 7 diisi dengan nilai dari index 0
          } else if (i == 1) {
            tempAnswers[8] = number; // Index 8 diisi dengan nilai dari index 1
          } else if (i == 2) {
            tempAnswers[9] = number; // Index 9 diisi dengan nilai dari index 2
          } else if (i == 3) {
            tempAnswers[10] =
                number; // Index 10 diisi dengan nilai dari index 3
          } else if (i == 4) {
            tempAnswers[11] =
                number; // Index 11 diisi dengan nilai dari index 4
          }
        }
      }
    }

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
      List<int> finalAnswersH = List.filled(12, 0);
      finalAnswersH[0] = answers[5] ?? 0;
      finalAnswersH[1] = answers[6] ?? 0;
      finalAnswersH[2] = answers[7] ?? 0;
      finalAnswersH[3] = answers[8] ?? 0;
      finalAnswersH[4] = answers[9] ?? 0;
      finalAnswersH[5] = answers[10] ?? 0;
      finalAnswersH[6] = answers[11] ?? 0;
      finalAnswersH[7] = answers[0] ?? 0;
      finalAnswersH[8] = answers[1] ?? 0;
      finalAnswersH[9] = answers[2] ?? 0;
      finalAnswersH[10] = answers[3] ?? 0;
      finalAnswersH[11] = answers[4] ?? 0;

      Data_H dataH = Data_H(answers: finalAnswersH);
      print(dataH.answers);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TM_I(
              jawabanA: widget.jawabanA,
              jawabanB: widget.jawabanB,
              jawabanC: widget.jawabanC,
              jawabanD: widget.jawabanD,
              jawabanE: widget.jawabanE,
              jawabanF: widget.jawabanF,
              jawabanG: widget.jawabanG,
              jawabanH: finalAnswersH
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
          'Kelompok H',
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
                      'H',
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
