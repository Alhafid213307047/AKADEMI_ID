import 'package:akademi_id/tesKepribadian/kepribadian13-15.dart';
import 'package:flutter/material.dart';

class Kepribadian10sd12 extends StatefulWidget {
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
  const Kepribadian10sd12({
    super.key, 
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
    required this.answerk9});

  @override
  State<Kepribadian10sd12> createState() => _Kepribadian10sd12State();
}

class _Kepribadian10sd12State extends State<Kepribadian10sd12> {
  int? _selectedValueP10;
  int? _selectedValueK10;
  final List<String> _indexP10 = ['C', 'D', 'S', 'I'];
  final List<String> _indexK10 = ['C', 'D', 'S', 'I'];
  String? p10;
  String? k10;

  int? _selectedValueP11;
  int? _selectedValueK11;
  final List<String> _indexP11 = ['S', 'I', 'D', 'C'];
  final List<String> _indexK11 = ['S', 'I', 'D', 'C'];
  String? p11;
  String? k11;

  int? _selectedValueP12;
  int? _selectedValueK12;
  final List<String> _indexP12 = ['S', 'C', 'I', 'D'];
  final List<String> _indexK12 = ['S', 'C', 'I', 'D'];
  String? p12;
  String? k12;

  void _checkSelection(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK10 == value) {
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
          _selectedValueP10 = null;
          p10 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP10 = value;
        p10 = _indexP10[index];
        print("$p10");
      });
    } else if (column == 'K') {
      if (_selectedValueP10 == value) {
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
          _selectedValueK10 = null;
          k10 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK10 = value;
        k10 = _indexK10[index];
        print("$k10");
      });
    }

    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP10[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK10[index]}, Nilai 1');
    }
  }

  void _checkSelection2(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK11 == value) {
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
          _selectedValueP11 = null;
          p11 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP11 = value;
        p11 = _indexP11[index];
        print("$p11");
      });
    } else if (column == 'K') {
      if (_selectedValueP11 == value) {
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
          _selectedValueK11 = null;
          k11 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK11 = value;
        k11 = _indexK11[index];
        print("$k11");
      });
    }

    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP11[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK11[index]}, Nilai 1');
    }
  }

  void _checkSelection3(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK12 == value) {
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
          _selectedValueP12 = null;
          p12 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP12 = value;
        p12 = _indexP12[index];
        print("$p12");
      });
    } else if (column == 'K') {
      if (_selectedValueP12 == value) {
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
          _selectedValueK12 = null;
          k12 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK12 = value;
        k12 = _indexK12[index];
        print("$k12");
      });
    }
    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP12[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK12[index]}, Nilai 1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tes Kepribadian 10-12',
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
                          child: Text('10', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Akan berjalan terus tanpa kontrol diri',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP10,
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
                          groupValue: _selectedValueK10,
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
                          'Akan membeli sesuai dorongan hati',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP10,
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
                          groupValue: _selectedValueK10,
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
                          'Akan menunggu, Tanpa tekanan',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP10,
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
                          groupValue: _selectedValueK10,
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
                          'Akan mengusahakan  yang kuinginkan',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP10,
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
                          groupValue: _selectedValueK10,
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
                          child: Text('11', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Ramah, Mudah bergabung',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP11,
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
                          groupValue: _selectedValueK11,
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
                          'Unik, Bosan rutinitas',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP11,
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
                          groupValue: _selectedValueK11,
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
                          'Aktif mengubah sesuatu',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP11,
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
                          groupValue: _selectedValueK11,
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
                          'ngin hal-hal yang pasti',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP11,
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
                          groupValue: _selectedValueK11,
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
                          child: Text('12', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Non-konfrontasi, Menyerah',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP12,
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
                          groupValue: _selectedValueK12,
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
                          'Dipenuhi hal detail',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP12,
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
                          groupValue: _selectedValueK12,
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
                          'Perubahan pada menit terakhir',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP12,
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
                          groupValue: _selectedValueK12,
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
                          'Menuntut, Kasar',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP12,
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
                          groupValue: _selectedValueK12,
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
                            Kepribadian13sd15(
                          answerp1: widget.answerp1,
                          answerk1: widget.answerk1,
                          answerp2: widget.answerp2,
                          answerk2: widget.answerk2,
                          answerp3: widget.answerp3,
                          answerk3: widget.answerk3,
                          answerp4: widget.answerp4,
                          answerk4: widget.answerk4,
                          answerp5: widget.answerp5,
                          answerk5: widget.answerk5,
                          answerp6: widget.answerp6,
                          answerk6: widget.answerk6,
                          answerp7: widget.answerp7,
                          answerk7: widget.answerk7,
                          answerp8: widget.answerp8,
                          answerk8: widget.answerk8,
                          answerp9: widget.answerp9,
                          answerk9: widget.answerk9,
                          answerp10: p10 ?? '',
                          answerk10: k10 ?? '',
                          answerp11: p11 ?? '',
                          answerk11: k11 ?? '',
                          answerp12: p12 ?? '',
                          answerk12: k12 ?? '',
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
