import 'package:akademi_id/tesKepribadian/kepribadian7-9.dart';
import 'package:flutter/material.dart';

class Kepribadian4sd6 extends StatefulWidget {
  final String answerp1;
  final String answerk1;
  final String answerp2;
  final String answerk2;
  final String answerp3;
  final String answerk3;

  Kepribadian4sd6({
    required this.answerp1,
    required this.answerk1,
    required this.answerp2,
    required this.answerk2,
    required this.answerp3,
    required this.answerk3,
  });

  @override
  _Kepribadian4sd6State createState() => _Kepribadian4sd6State();
}

class _Kepribadian4sd6State extends State<Kepribadian4sd6> {
  int? _selectedValueP4;
  int? _selectedValueK4;
  final List<String> _indexP4 = ['C', 'S', 'I', 'D'];
  final List<String> _indexK4 = ['C', 'S', 'I', 'D'];
  String? p4;
  String? k4;

  int? _selectedValueP5;
  int? _selectedValueK5;
  final List<String> _indexP5 = ['I', 'D', 'S', 'C'];
  final List<String> _indexK5 = ['I', 'D', 'S', 'C'];
  String? p5;
  String? k5;

  int? _selectedValueP6;
  int? _selectedValueK6;
  final List<String> _indexP6 = ['C', 'D', 'I', 'S'];
  final List<String> _indexK6 = ['C', 'D', 'I', 'S'];
  String? p6;
  String? k6;

  void _checkSelection(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK4 == value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Anda tidak dapat memilih P dan K dalam kepribadian yang sama',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _selectedValueP4 = null;
          p4 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP4 = value;
        p4 = _indexP4[index];
        print("$p4");
      });
    } else if (column == 'K') {
      if (_selectedValueP4 == value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Anda tidak dapat memilih P dan K dalam kepribadian yang sama',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _selectedValueK4 = null;
          k4 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK4 = value;
        k4 = _indexK4[index];
        print("$k4");
      });
    }

    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP4[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK4[index]}, Nilai 1');
    }
  }

  void _checkSelection2(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK5 == value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Anda tidak dapat memilih P dan K dalam kepribadian yang sama',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _selectedValueP5 = null;
          p5 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP5 = value;
        p5 = _indexP5[index];
        print("$p5");
      });
    } else if (column == 'K') {
      if (_selectedValueP5 == value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Anda tidak dapat memilih P dan K dalam kepribadian yang sama',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _selectedValueK5 = null;
          k5 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK5 = value;
        k5 = _indexK5[index];
        print("$k5");
      });
    }

    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP5[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK5[index]}, Nilai 1');
    }
  }

  void _checkSelection3(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK6 == value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Anda tidak dapat memilih P dan K dalam kepribadian yang sama',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _selectedValueP6 = null;
          p6 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP6 = value;
        p6 = _indexP6[index];
        print("$p6");
      });
    } else if (column == 'K') {
      if (_selectedValueP6 == value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Anda tidak dapat memilih P dan K dalam kepribadian yang sama',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _selectedValueK6 = null;
          k6 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK6 = value;
        k6 = _indexK6[index];
        print("$k6");
      });
    }
    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP6[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK6[index]}, Nilai 1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tes Kepribadian 4-6',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Tabel 1
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
                            child: Text(
                              'No',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna hijau
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Gambaran Diri',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna hijau
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'P',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna hijau
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'K',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('4', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Menjadi frustasi',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP4,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection(value, 'P', 0);
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueK4,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection(value, 'K', 0);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text(
                          'Menyimpan perasaan saya',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP4,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection(value, 'P', 1);
                            });
                          },
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueK4,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection(value, 'K', 1);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text(
                          'Menceritakan sisi saya',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP4,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection(value, 'P', 2);
                            });
                          },
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueK4,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection(value, 'K', 2);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text(
                          'Siap beroposisi',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP4,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection(value, 'P', 3);
                            });
                          },
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueK4,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection(value, 'K', 3);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              //Tabel 2
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
                  // Header Row for second table
                  TableRow(
                    children: [
                      Container(
                        color: Colors.green, // Warna biru
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna biru
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Gambaran Diri',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna biru
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'P',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna biru
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'K',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('5', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Hidup, Suka bicara',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP5,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection2(value, 'P', 0);
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueK5,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection2(value, 'K', 0);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text(
                          'Gerak cepat, Tekun',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP5,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection2(value, 'P', 1);
                            });
                          },
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueK5,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection2(value, 'K', 1);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text(
                          'Usaha menjaga keseimbangan',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP5,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection2(value, 'P', 2);
                            });
                          },
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueK5,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection2(value, 'K', 2);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text(
                          'Usaha mengikuti aturan',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP5,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection2(value, 'P', 3);
                            });
                          },
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueK5,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection2(value, 'K', 3);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              //Tabel 3
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
                  // Header Row for second table
                  TableRow(
                    children: [
                      Container(
                        color: Colors.green, // Warna biru
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna biru
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Gambaran Diri',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna biru
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'P',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.green, // Warna biru
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'K',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('6', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Kelola waktu secara efisien',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP6,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection3(value, 'P', 0);
                            });
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueK6,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection3(value, 'K', 0);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text(
                          'Sering terburu-buru, Merasa tertekan',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP6,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection3(value, 'P', 1);
                            });
                          },
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueK6,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection3(value, 'K', 1);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text(
                          'Masalah sosial itu penting',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP6,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection3(value, 'P', 2);
                            });
                          },
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueK6,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection3(value, 'K', 2);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 3),
                        child: Text(
                          'Suka selesaikan apa yang saya mulai',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP6,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection3(value, 'P', 3);
                            });
                          },
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueK6,
                          onChanged: (value) {
                            setState(() {
                              _checkSelection3(value, 'K', 3);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Kepribadian7sd9(
                          answerp1: widget.answerp1,
                          answerk1: widget.answerk1,
                          answerp2: widget.answerp2,
                          answerk2: widget.answerk2,
                          answerp3: widget.answerp3,
                          answerk3: widget.answerk3,
                          answerp4: p4 ?? '',
                          answerk4: k4 ?? '',
                          answerp5: p5 ?? '',
                          answerk5: k5 ?? '',
                          answerp6: p6 ?? '',
                          answerk6: k6 ?? '',
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 46, 155, 233),
                      minimumSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Lanjutkan',
                      style:
                          TextStyle(fontFamily: "Poppins", color: Colors.white),
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
