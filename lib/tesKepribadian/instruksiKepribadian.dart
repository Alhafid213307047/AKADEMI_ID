import 'package:akademi_id/tesKepribadian/kepribadian1-3.dart';
import 'package:flutter/material.dart';

class InstruksiKepribadian extends StatefulWidget {
  const InstruksiKepribadian({super.key});

  @override
  State<InstruksiKepribadian> createState() => _InstruksiKepribadianState();
}

class _InstruksiKepribadianState extends State<InstruksiKepribadian> {
  int? _selectedValueP = 0; // Default ke index 0 untuk P
  int? _selectedValueK = 2; // Default ke index 2 untuk K

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
          'Tes Kepribadian',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Instruksi!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Setiap nomor di bawah ini memuat 4 (empat) kalimat. Tugas anda adalah :',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '1. Beri tanda/cek pada kolom di bawah huruf [P] di samping kalimat yang PALING menggambarkan diri anda',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '2. Beri tanda/cek pada kolom di bawah huruf [K] di samping kalimat yang PALING TIDAK menggambarkan diri anda',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Contoh :',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              // Tabel dengan Radio Button
              Table(
                columnWidths: {
                  0: FixedColumnWidth(40),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(50),
                  3: FixedColumnWidth(50),
                },
                border: TableBorder.all(
                  color: Colors.black,
                  width: 1,
                ),
                children: [
                  // Header Row
                  TableRow(
                    children: [
                      Container(
                        color: Colors.green, // Warna hijau
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('No',
                                  style: TextStyle(
                                      color: Colors
                                          .white, // Warna teks putih untuk kontras
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"))),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna hijau
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('Gambaran Diri',
                                  style: TextStyle(
                                      color: Colors
                                          .white, // Warna teks putih untuk kontras
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"))),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna hijau
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('P',
                                  style: TextStyle(
                                      color: Colors
                                          .white, // Warna teks putih untuk kontras
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"))),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna hijau
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text('K',
                                  style: TextStyle(
                                      color: Colors
                                          .white, // Warna teks putih untuk kontras
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"))),
                        ),
                      ),
                    ],
                  ),
        
                  // Row 1
                  TableRow(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child:
                              Text('1', style: TextStyle(fontFamily: "Poppins")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text('Gampangan, Mudah setuju',
                            style: TextStyle(fontFamily: "Poppins")),
                      ),
                      Radio<int>(
                        value: 0,
                        groupValue: _selectedValueP,
                        onChanged: (value) {
                          setState(() {
                            if (_selectedValueK != value) {
                              _selectedValueP = value;
                            }
                          });
                        },
                        activeColor: _selectedValueP == 0 ? Colors.blue : null,
                      ),
                      Radio<int>(
                        value: 0,
                        groupValue: _selectedValueK,
                        onChanged: (value) {
                          setState(() {
                            if (_selectedValueP != value) {
                              _selectedValueK = value;
                            }
                          });
                        },
                        activeColor: _selectedValueK == 0 ? Colors.blue : null,
                      ),
                    ],
                  ),
                  // Row 2
                  TableRow(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child:
                              Text('', style: TextStyle(fontFamily: "Poppins")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text('Percaya, Mudah percaya pada orang',
                            style: TextStyle(fontFamily: "Poppins")),
                      ),
                      Radio<int>(
                        value: 1,
                        groupValue: _selectedValueP,
                        onChanged: (value) {
                          setState(() {
                            if (_selectedValueK != value) {
                              _selectedValueP = value;
                            }
                          });
                        },
                        activeColor: _selectedValueP == 1 ? Colors.blue : null,
                      ),
                      Radio<int>(
                        value: 1,
                        groupValue: _selectedValueK,
                        onChanged: (value) {
                          setState(() {
                            if (_selectedValueP != value) {
                              _selectedValueK = value;
                            }
                          });
                        },
                        activeColor: _selectedValueK == 1 ? Colors.blue : null,
                      ),
                    ],
                  ),
                  // Row 3
                  TableRow(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child:
                              Text('', style: TextStyle(fontFamily: "Poppins")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text('Petualang, Mengambil risiko',
                            style: TextStyle(fontFamily: "Poppins")),
                      ),
                      Radio<int>(
                        value: 2,
                        groupValue: _selectedValueP,
                        onChanged: (value) {
                          setState(() {
                            if (_selectedValueK != value) {
                              _selectedValueP = value;
                            }
                          });
                        },
                        activeColor: _selectedValueP == 2 ? Colors.blue : null,
                      ),
                      Radio<int>(
                        value: 2,
                        groupValue: _selectedValueK,
                        onChanged: (value) {
                          setState(() {
                            if (_selectedValueP != value) {
                              _selectedValueK = value;
                            }
                          });
                        },
                        activeColor: _selectedValueK == 2 ? Colors.blue : null,
                      ),
                    ],
                  ),
                  // Row 4
                  TableRow(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child:
                              Text('', style: TextStyle(fontFamily: "Poppins")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text('Toleran, Menghormati',
                            style: TextStyle(fontFamily: "Poppins")),
                      ),
                      Radio<int>(
                        value: 3,
                        groupValue: _selectedValueP,
                        onChanged: (value) {
                          setState(() {
                            if (_selectedValueK != value) {
                              _selectedValueP = value;
                            }
                          });
                        },
                        activeColor: _selectedValueP == 3 ? Colors.blue : null,
                      ),
                      Radio<int>(
                        value: 3,
                        groupValue: _selectedValueK,
                        onChanged: (value) {
                          setState(() {
                            if (_selectedValueP != value) {
                              _selectedValueK = value;
                            }
                          });
                        },
                        activeColor: _selectedValueK == 3 ? Colors.blue : null,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
               Text(
                'Pada contoh diatas terlihat kepribadian "Gampangan" adalah yang paling menggambarkan, sedangkan "Petualang" adalah yang paling tidak menggambarkan diri anda.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '*Catatan',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red
                ),
              ),
               Text(
                'Anda tidak bisa memilih pilihan "P" dan "K" pada kepribadian yang sama!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Kepribadian1sd3(),
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
                  child: const Text(
                    'Mulai Tes',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 46, 155, 233),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
