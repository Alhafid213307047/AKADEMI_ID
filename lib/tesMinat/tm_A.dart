import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:akademi_id/tesMinat/Jawaban/data_A.dart';
import 'package:akademi_id/tesMinat/tm_B.dart';

class TM_A extends StatefulWidget {
  const TM_A({super.key});

  @override
  State<TM_A> createState() => _KelompokAState();
}

class _KelompokAState extends State<TM_A> {
  final List<String> professions = [
    'Polisi Lalu Lintas',
    'Insinyur Sipil',
    'Akuntan',
    'Ilmuwati',
    'Penjual hasil mode',
    'Seniman',
    'Wartawati',
    'Pianis Konser',
    'Guru Sekolah Dasar',
    'Sekretaris Dasar',
    'Penata Busana',
    'Dokter'
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
        // Clear previous errors for this index
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
      _checkAllFilled(); // Call this to update button color
      _logInput(); // Log input changes
    }
  }

  void _logInput() {
    for (int i = 0; i < controllers.length; i++) {
      final value = controllers[i].text;
      if (value.isNotEmpty) {
        print('Index $i = $value');
      }
    }
  }

  void _navigateToKelompokB() {
    // Mengonversi jawaban menjadi List<int>
    List<int> jawabanAList =
        controllers.map((c) => int.tryParse(c.text) ?? 0).toList();

    // Simpan data di Data_A
    Data_A(answers: jawabanAList);
    print(jawabanAList);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TM_B(jawabanA: jawabanAList), // Kirimkan List<int> ke TM_B
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Kelompok A',
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
                      'A',
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
                                      _checkAllFilled();
                                      
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
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: (allFilled && !hasError.contains(true))
                    ? _navigateToKelompokB
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: (allFilled && !hasError.contains(true))
                      ? Color.fromARGB(255, 46, 155, 233)
                      : Colors.grey,
                  padding: EdgeInsets.all(16.0),
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
