import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:akademi_id/tesMinat/Jawaban/data_B.dart';
import 'package:akademi_id/tesMinat/tm_C.dart';

class TM_B extends StatefulWidget {
  final List<int> jawabanA;
  TM_B({required this.jawabanA});

  @override
  State<TM_B> createState() => _TM_BState();
}

class _TM_BState extends State<TM_B> {
  final List<String> professions = [
    'Perakit Komputer',
    'Personalia',
    'Insinyur Kimia Industri',
    'Penyiar Radio',
    'Artis profesional',
    'Pengarang',
    'Pemain musik orkestra',
    'Psikolog Pendidikan',
    'Pegawai Administrasi',
    'Seniman pot keramik',
    'Ahli bedah',
    'Guru olahraga'
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
          if (i == 11) {
            tempAnswers[0] = number; // Baris terakhir ke indeks 0
          } else if (i == 10) {
            tempAnswers[11] = number; // Baris sebelum terakhir ke indeks 11
          } else {
            tempAnswers[i + 1] = number; // Baris pertama ke indeks 1, dst.
          }
        }
      }
    }
    // Mengisi nilai default jika kosong
    tempAnswers[11] =
        tempAnswers[11] ?? 12; // Mengisi nilai default jika kosong
    print(tempAnswers);
    
  }

   void _handlePrevious() {
    
    Navigator.pop(context, controllers.map((c) => c.text).toList());
  }

  void _handleNext() {
    if (allFilled) {
      List<int?> answers = List.generate(12, (i) {
        final value = controllers[i].text;
        final number = int.tryParse(value);
        return number;
      });

      // Menyusun nilai dengan benar sesuai dengan urutan
      List<int> finalAnswersB = List.filled(12, 0);
      finalAnswersB[0] =
          answers[11] ?? 0; // Index 0 diisi dengan nilai dari index 11
      for (int i = 1; i < 11; i++) {
        finalAnswersB[i] = answers[i - 1] ?? 0;
      }
      finalAnswersB[11] =
          answers[10] ?? 0; // Index 11 diisi dengan nilai dari index 10

      // Data B
      Data_B data_b = Data_B(answers: finalAnswersB);
      print(data_b.answers);

      // Navigasi ke TM_C dengan jawabanA dan jawabanB
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TM_C(
            jawabanA: widget.jawabanA,
            jawabanB: finalAnswersB,
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
          'Kelompok B',
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
                      'B',
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
                                      fontFamily:
                                          'Poppins', 
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
            child:Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                   onPressed: (allFilled && !hasError.contains(true))? _handleNext : null,
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: (allFilled && !hasError.contains(true))
                        ? const Color.fromARGB(255, 46, 155, 233)
                        : Colors.grey,
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),),)
              ],
            ),
          );
  }
}
