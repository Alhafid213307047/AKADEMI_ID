import 'package:akademi_id/tesKepribadian/Hasil/hasilKepribadian.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Kepribadian22sd24 extends StatefulWidget {
  final String answerp1;
  final String answerk1;
  final String answerp2;
  final String answerk2;
  final String answerp3;
  final String answerk3;
  final String answerp4;
  final String answerk4;
  final String answerp5;
  final String answerk5;
  final String answerp6;
  final String answerk6;
  final String answerp7;
  final String answerk7;
  final String answerp8;
  final String answerk8;
  final String answerp9;
  final String answerk9;
  final String answerp10;
  final String answerk10;
  final String answerp11;
  final String answerk11;
  final String answerp12;
  final String answerk12;
  final String answerp13;
  final String answerk13;
  final String answerp14;
  final String answerk14;
  final String answerp15;
  final String answerk15;
  final String answerp16;
  final String answerk16;
  final String answerp17;
  final String answerk17;
  final String answerp18;
  final String answerk18;
  final String answerp19;
  final String answerk19;
  final String answerp20;
  final String answerk20;
  final String answerp21;
  final String answerk21;
  const Kepribadian22sd24(
      {super.key,
      required this.answerp1,
      required this.answerk1,
      required this.answerp2,
      required this.answerk2,
      required this.answerp3,
      required this.answerk3,
      required this.answerp4,
      required this.answerk4,
      required this.answerp5,
      required this.answerk5,
      required this.answerp6,
      required this.answerk6,
      required this.answerp7,
      required this.answerk7,
      required this.answerp8,
      required this.answerk8,
      required this.answerp9,
      required this.answerk9,
      required this.answerp10,
      required this.answerk10,
      required this.answerp11,
      required this.answerk11,
      required this.answerp12,
      required this.answerk12,
      required this.answerp13,
      required this.answerk13,
      required this.answerp14,
      required this.answerk14,
      required this.answerp15,
      required this.answerk15,
      required this.answerp16,
      required this.answerk16,
      required this.answerp17,
      required this.answerk17,
      required this.answerp18,
      required this.answerk18,
      required this.answerp19,
      required this.answerk19,
      required this.answerp20,
      required this.answerk20,
      required this.answerp21,
      required this.answerk21});

  @override
  State<Kepribadian22sd24> createState() => _Kepribadian22sd24State();
}

class _Kepribadian22sd24State extends State<Kepribadian22sd24> {
  int? _selectedValueP22;
  int? _selectedValueK22;
  final List<String> _indexP22 = ['S', 'I', 'D', 'C'];
  final List<String> _indexK22 = ['S', 'I', 'D', 'C'];
  String? p22;
  String? k22;

  int? _selectedValueP23;
  int? _selectedValueK23;
  final List<String> _indexP23 = ['D', 'I', 'S', 'C'];
  final List<String> _indexK23 = ['D', 'I', 'S', 'C'];
  String? p23;
  String? k23;

  int? _selectedValueP24;
  int? _selectedValueK24;
  final List<String> _indexP24 = ['S', 'I', 'D', 'C'];
  final List<String> _indexK24 = ['S', 'I', 'D', 'C'];
  String? p24;
  String? k24;

  void _checkSelection(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK22 == value) {
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
          _selectedValueP22 = null;
          p22 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP22 = value;
        p22 = _indexP22[index];
        print("$p22");
      });
    } else if (column == 'K') {
      if (_selectedValueP22 == value) {
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
          _selectedValueK22 = null;
          k22 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK22 = value;
        k22 = _indexK22[index];
        print("$k22");
      });
    }

    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP22[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK22[index]}, Nilai 1');
    }
  }

  void _checkSelection2(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK23 == value) {
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
          _selectedValueP23 = null;
          p23 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP23 = value;
        p23 = _indexP23[index];
        print("$p23");
      });
    } else if (column == 'K') {
      if (_selectedValueP23 == value) {
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
          _selectedValueK23 = null;
          k23 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK23 = value;
        k23 = _indexK23[index];
        print("$k23");
      });
    }

    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP23[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK23[index]}, Nilai 1');
    }
  }

  void _checkSelection3(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK24 == value) {
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
          _selectedValueP24 = null;
          p24 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP24 = value;
        p24 = _indexP24[index];
        print("$p24");
      });
    } else if (column == 'K') {
      if (_selectedValueP24 == value) {
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
          _selectedValueK24 = null;
          k24 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK24 = value;
        k24 = _indexK24[index];
        print("$k24");
      });
    }
    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP24[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK24[index]}, Nilai 1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tes Kepribadian 22-24',
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
                          child: Text('22', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Menyenangkan orang, Mudah setuju',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP22,
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
                          groupValue: _selectedValueK22,
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
                          'Tertawa lepas, Hidup',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP22,
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
                          groupValue: _selectedValueK22,
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
                          'Berani, Tak gentar',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP22,
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
                          groupValue: _selectedValueK22,
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
                          'Tenang, Pendiam',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP22,
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
                          groupValue: _selectedValueK22,
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
                          child: Text('23', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Ingin otoritas lebih',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP23,
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
                          groupValue: _selectedValueK23,
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
                          'Ingin kesempatan baru',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP23,
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
                          groupValue: _selectedValueK23,
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
                          'Menghindari konflik',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP23,
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
                          groupValue: _selectedValueK23,
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
                          'Ingin petunjuk yang jelas',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP23,
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
                          groupValue: _selectedValueK23,
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
                          child: Text('24', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Dapat diandalkan, Dapat dipercaya',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP24,
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
                          groupValue: _selectedValueK24,
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
                          'Kreatif, Unik',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP24,
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
                          groupValue: _selectedValueK24,
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
                          'Garis dasar, Orientasi hasil',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP24,
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
                          groupValue: _selectedValueK24,
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
                          'Jalankan standar yang tinggi, Akurat',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP24,
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
                          groupValue: _selectedValueK24,
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
                      _calculateScores();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Lihat Hasil Tes',
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

 void _calculateScores() {
    // Collect all answers for P and K
    List<String> allAnswersP = [
      widget.answerp1,
      widget.answerp2,
      widget.answerp3,
      widget.answerp4,
      widget.answerp5,
      widget.answerp6,
      widget.answerp7,
      widget.answerp8,
      widget.answerp9,
      widget.answerp10,
      widget.answerp11,
      widget.answerp12,
      widget.answerp13,
      widget.answerp14,
      widget.answerp15,
      widget.answerp16,
      widget.answerp17,
      widget.answerp18,
      widget.answerp19,
      widget.answerp20,
      widget.answerp21,
      p22 ?? '',
      p23 ?? '',
      p24 ?? ''
    ];

    List<String> allAnswersK = [
      widget.answerk1,
      widget.answerk2,
      widget.answerk3,
      widget.answerk4,
      widget.answerk5,
      widget.answerk6,
      widget.answerk7,
      widget.answerk8,
      widget.answerk9,
      widget.answerk10,
      widget.answerk11,
      widget.answerk12,
      widget.answerk13,
      widget.answerk14,
      widget.answerk15,
      widget.answerk16,
      widget.answerk17,
      widget.answerk18,
      widget.answerk19,
      widget.answerk20,
      widget.answerk21,
      k22 ?? '',
      k23 ?? '',
      k24 ?? ''
    ];

    // Calculate scores for P
    Map<String, int> scoreP = {'D': 0, 'I': 0, 'S': 0, 'C': 0};
    for (var answer in allAnswersP) {
      if (scoreP.containsKey(answer)) {
        scoreP[answer] = scoreP[answer]! + 1;
      }
    }

    // Calculate scores for K
    Map<String, int> scoreK = {'D': 0, 'I': 0, 'S': 0, 'C': 0};
    for (var answer in allAnswersK) {
      if (scoreK.containsKey(answer)) {
        scoreK[answer] = scoreK[answer]! + 1;
      }
    }

    // Determine highest scores for P
    List<String> highestP = [];
    int maxP = scoreP.values.reduce((a, b) => a > b ? a : b);
    scoreP.forEach((key, value) {
      if (value == maxP) {
        highestP.add(key);
      }
    });
    String categoryP = highestP.join('-');

    // Determine highest scores for K
    List<String> highestK = [];
    int maxK = scoreK.values.reduce((a, b) => a > b ? a : b);
    scoreK.forEach((key, value) {
      if (value == maxK) {
        highestK.add(key);
      }
    });
    String categoryK = highestK.join('-');

    // Define descriptions
    Map<String, String> descriptions = {
      'C': 'Seorang yang praktis, cakap dan unik. Ia orang yang mampu menilai diri sendiri dan kritis terhadap dirinya dan orang lain. Ia menyukai hal yang detail dan logis; secara alamiah ia sangat analitis. Karena menyimpan informasi, ia meneliti isu berulang-ulang kali. Ia cenderung malu dan tertutup; ia hati-hati dalam membuat keputusan yang berdasarkan pada logika, bukan emosi, selalu menggunakan pertanyaan "bagaimana dan mengapa". Ia mengerjakan sesuatu dengan sistematis dan akurat. Ia rapi dan terorganisir sebab ia merasa bahwa keadaan berantakan sama dengan mutu yang rendah; demikian juga, rapi dan teratur merupakan mutu yang tinggi. Sangat teliti dalam segala sesuatu seperti halnya dalam pekerjaan dan penggunaan waktunya. Ia merencanakan dan mengorganisir semua sisi kehidupannya. Kelambanan sangat mengganggunya dan tak dapat ditolerir.',
      'D': 'Memiliki rasa ego yang tinggi dan cenderung individualis dengan standard yang sangat tinggi. Ia lebih suka menganalisa masalah sendirian daripada bersama orang lain. Rasa egoisnya yang kuat membuatnya tidak nyaman di bawah kendali orang lain; ia lebih suka menjadi "boss" dan menetapkan standar tinggi baik untuk dirinya maupun orang lain. Ia menghindari sesuatu yang biasa-biasa dan cenderung mencari tantangan yang baru. Ia menyukai petualangan dan kadang-kadang beralih ke dalam petualangan baru sebelum mempertimbangkannya secara menyeluruh. Mampu memimpin situasi dan orang lain dalam rangka mencapai sasarannya; ia ingin selalu unggul dalam persaingan dengan taruhan apapun.',
      'S': 'Merupakan individu konsisten yang berusaha menjaga lingkungan/suasana yang tidak berubah.  Ia bekerja dengan baik bersama orang-orang dengan berbagai kepribadian karena perilakunya yang terkendali dan rendah hati.  Sabar, loyal dan suka menolong.  Persahabatan dikembangkannya dengan lambat dan selektif.  Ia tidak bosan dengan rutinitas dan sangat baik bekerja dengan petunjuk dan peraturan yang jelas. Ia mengharapkan bantuan dan supervisi pada saat mengawali proyek baru.  Ia butuh waktu untuk menyesuaikan diri dengan perubahan dan sungkan menjalankan "cara-cara lama mengerjakan sesuatu".  Ia akan menghindari konfrontasi dan berusaha sekuat tenaga memendam perasaannya.',
      'I': 'Merupakan seorang yang antusias dan optimistik, ia lebih suka mencapai sasarannya melalui orang lain. Ia suka berhubungan dengan sesamanya - ia bahkan suka mengadakan “pesta” atau kegiatan untuk berkumpul, dan ini menunjukkan kepribadiannya yang ramah. Ia tidak suka bekerja sendirian dan cenderung bersama dengan orang lain dalam menyelesaikan proyek.  Perhatian dan fokusnya tidak sebaik apa yang dia inginkan -  maka ia membutuhkan energi yang besar untuk mampu bergerak cepat dari satu hal ke hal berikutnya tanpa penundaan.  Ia sangat menonjol dalam keterampilan berkomunikasi, dan ini merupakan salah satu kekuatan yang paling sering digunakan.  Ia memiliki kemampuan untuk memotivasi dan memberi semangat dengan kata-katanya, dan ia dikenal sebagai individu yang inspirasional. Ketika ia harus memusatkan perhatiannya pada tugas, Ia akan menjadi tidak akurat dan bahkan tidak terorganisir.  Tetapi ia akan memusatkan perhatian kepada yang harus ia senangkan, karena ia enggan sekali untuk menolak.  Ia menginginkan pengakuan sosial dan takut akan penolakan.  Ia mudah menemukan teman dan berusaha menciptakan suasana yang menyenangkan.  Ia membutuhkan seorang manajer atau supervisor untuk menentukan batas waktu yang jelas dalam pekerjaannya, ia lebih suka menggunakan gaya manajemen partisipatif yang dibangun berdasarkan hubungan yang kuat.',
      'D-I': 'Merupakan seorang pemimpin integratif yang bekerja dengan dan melalui orang lain.  Ia ramah, memiliki perhatian yang tinggi akan orang dan juga mempunyai kemampuan untuk memperoleh hormat dan penghargaan dari berbagai tipe orang.  Melakukan pekerjaannya dengan cara yang bersahabat, baik dalam mencapai sasarannya maupun meyakinkan pandangannya kepada orang lain.  Ia tidak begitu memperhatikan hal-hal kecil.  Kadang bertindak sesuai dengan kata hati/impulsif, terlalu antusias dan sangat banyak bicara.  Ia terlalu berlebihan menilai kemampuannya dalam memotivasi atau mengubah perilaku orang lain.  Mencari kebebasan dari rutinitas, menginginkan otoritas/wewenang dan juga prestise.  Ia menginginkan aktivitas yang bervariasi dan bekerja lebih efisien jika data-data analitis disediakan oleh orang lain.  Menginginkan penugasan yang mengutamakan mobilitas dan tantangan.',
      'D-S': 'Merupakan seorang yang obyektif dan analitis.  Ia ingin terlibat dalam situasi, dan juga ingin memberikan bantuan dan dukungan.  Secara internal termotivasi oleh target pribadi, Ia menyukai orang-orang, tetapi juga mempunyai kemampuan untuk berorientasi pada pekerjaannya pada saat dibutuhkan.  Karena determinasinya yang kuat, ia sering berhasil dalam berbagai hal; karakternya yang tenang, stabil dan daya tahannya memiliki kontribusi akan keberhasilannya.  Keuletannya setelah memulai pekerjaan, ia akan berusaha keras untuk mendapatkan sasarannya.  Seorang yang bebas, ia orang yang cermat dan memiliki tindak lanjut yang baik.  Ia bisa menjadi tidak ramah walaupun ia pada dasarnya ia yang berorientasi pada orang; dan pada situasi yang tidak membuatnya nyaman, ia lebih suka mendukung pemimpinnya dari pada keterlibatannya dengan situasi.',
      'D-C': 'Seorang yang sangat berorientasi pada tugas dan sensitif pada permasalahan. Ia lebih mempedulikan tugas yang ada dibanding orang-orang di sekitarnya, termasuk perasaan mereka. Sangat kukuh/keras dan mempunyai pendekatan yang efektif dalam pemecahan masalah. Oleh karena sifat alamiah dan keinginannya akan hasil yang terukur, Akan tampak dingin, tidak berperasaan dan menjaga jarak. Ia membuat keputusan berdasar pada fakta, bukan emosi. Cenderung pendiam dan tidak mudah percaya.',
      'I-S': 'Seorang yang mengesankan orang akan kehangatan, simpati dan pengertiannya.  Ia memiliki ketenangan dalam sebagian besar situasi sosial dan jarang tidak menyenangkan orang lain.  Faktanya, banyak orang datang padanya karena ia kelihatan sebagai pendengar yang baik.  Ia cenderung sangat demonstratif dan emosinya biasanya tampak jelas bagi orang di sekitarnya.  Ia tidak akan memaksakan idenya pada orang lain; ia tidak tegas dalam mengekspresikan atau memberi perintah.  Jika ia sangat kuat merasakan sesuatu, Ia akan bicara secara terbuka dan terus terang tentang pendiriannya.  Ia cenderung menerima kritik atas pekerjaannya sebagai serangan pribadi.  Ia dapat menjadi sangat toleran dan sabar kepada mereka yang tidak produktif di pekerjaan.  Ia merupakan "penjaga damai" dan akan bekerja untuk menjaga kedamaian dalam setiap keadaan.',
      'I-C': 'Merupakan seseorang yang analitis, berwatak hati-hati dan ramah pada saat merasa nyaman. Ia sangat biasa dengan orang asing, karena ia dapat menilai dan menyesuaikan diri dalam hubungan mereka. Ia dapat mengembangkan hubungan baru dengan mudah ketika ia ingin melakukannya, dan pada umumnya dapat mengendalikan diri sampai pada tingkat di mana ia jarang menimbulkan rasa benci pada orang lain dengan sengaja. Ia menampilkan sikap peduli dan ramah, namun mampu memusatkan perhatian pada penyelesaian tugas yang ada. Ia cenderung perfeksionis secara alami, dan akan mengisolasi dirinya jika diperlukan untuk melaksanakan pekerjaan. Ia suka berada pada situasi yang dapat diramalkan dan tidak ada kejutan. Ia sangat berorientasi pada kualitas dan akan bekerja dengan keras untuk menyelesaikan pekerjaan dengan benar. Ia ingin orang-orang berkenan akan pekerjaan yang sudah ia selesaikan dengan baik.',
      'S-C': 'Ia adalah orang yang baik secara alamiah dan sangat berorientasi detail.  Ia peduli dengan orang-orang di sekitarnya dan mempunyai kualitas yang membuatnya sangat teliti dalam penyelesaian tugas.  Ia mempertimbangkan sekelilingnya dengan hati-hati sebelum membuat keputusan untuk melihat pengaruhnya pada mereka; saat tertentu ia terlalu hati-hati.  Jika ia merasa seseorang memanfaatkan situasi, ia akan memperlambat kerjanya sehingga dapat mengamati apa yang sedang berlangsung di sekitarnya.'
    };

    // Set descriptions based on highest scores
    String descriptionP =
        descriptions[categoryP] ?? 'Deskripsi tidak tersedia.';
    String descriptionK =
        descriptions[categoryK] ?? 'Deskripsi tidak tersedia.';

    saveToFirestore(
        categoryP, descriptionP, categoryK, descriptionK, scoreP, scoreK);

    // Navigate to HasilKepribadian with scores, descriptions, and custom transition
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        // Define the page to navigate to
        return HasilKepribadian(
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define the transition animation
        const begin = Offset(1.0, 0.0); // Slide in from the right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween<Offset>(begin: begin, end: end)
            .chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    ));
  }

 Future<void> saveToFirestore(
      String categoryP,
      String descriptionP,
      String categoryK,
      String descriptionK,
      Map<String, int> scoreP,
      Map<String, int> scoreK) async {
    final formattedDate =
        DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now());
        User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Pengguna tidak ditemukan, pastikan pengguna sudah login.');
      return;
    }
    String userId = user.uid;

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('HistoryKepribadian')
          .add({
        'tanggal': formattedDate,
        'highscoreP': categoryP,
        'deskripsiP': descriptionP,
        'highscoreK': categoryK,
        'deskripsiK': descriptionK,
        'scoreP (D)': scoreP['D']!,
        'scoreP (I)': scoreP['I']!,
        'scoreP (S)': scoreP['S']!,
        'scoreP (C)': scoreP['C']!,
        'scoreK (D)': scoreK['D']!,
        'scoreK (I)': scoreK['I']!,
        'scoreK (S)': scoreK['S']!,
        'scoreK (C)': scoreK['C']!,
      });
    } catch (e) {
      print("Error saving to Firestore: $e");
    }
  }
}
