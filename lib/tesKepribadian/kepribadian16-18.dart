import 'package:akademi_id/tesKepribadian/kepribadian19-21.dart';
import 'package:flutter/material.dart';

class Kepribadian16sd18 extends StatefulWidget {
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

  const Kepribadian16sd18({
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
  });

  @override
  State<Kepribadian16sd18> createState() => _Kepribadian16sd18State();
}

class _Kepribadian16sd18State extends State<Kepribadian16sd18> {
  int? _selectedValueP16;
  int? _selectedValueK16;
  final List<String> _indexP16 = ['D', 'C', 'I', 'S'];
  final List<String> _indexK16 = ['D', 'C', 'I', 'S'];
  String? p16;
  String? k16;

  int? _selectedValueP17;
  int? _selectedValueK17;
  final List<String> _indexP17 = ['C', 'D', 'S', 'I'];
  final List<String> _indexK17 = ['C', 'D', 'S', 'I'];
  String? p17;
  String? k17;

  int? _selectedValueP18;
  int? _selectedValueK18;
  final List<String> _indexP18 = ['D', 'I', 'S', 'C'];
  final List<String> _indexK18 = ['D', 'I', 'S', 'C'];
  String? p18;
  String? k18;

  void _checkSelection(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK16 == value) {
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
          _selectedValueP16 = null;
          p16 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP16 = value;
        p16 = _indexP16[index];
        print("$p16");
      });
    } else if (column == 'K') {
      if (_selectedValueP16 == value) {
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
          _selectedValueK16 = null;
          k16 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK16 = value;
        k16 = _indexK16[index];
        print("$k16");
      });
    }

    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP16[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK16[index]}, Nilai 1');
    }
  }

  void _checkSelection2(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK17 == value) {
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
          _selectedValueP17 = null;
          p17 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP17 = value;
        p17 = _indexP17[index];
        print("$p17");
      });
    } else if (column == 'K') {
      if (_selectedValueP17 == value) {
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
          _selectedValueK17 = null;
          k17 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK17 = value;
        k17 = _indexK17[index];
        print("$k17");
      });
    }

    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP17[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK17[index]}, Nilai 1');
    }
  }

  void _checkSelection3(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK18 == value) {
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
          _selectedValueP18 = null;
          p18 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP18 = value;
        p18 = _indexP18[index];
        print("$p18");
      });
    } else if (column == 'K') {
      if (_selectedValueP18 == value) {
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
          _selectedValueK18 = null;
          k18 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK18 = value;
        k18 = _indexK18[index];
        print("$k18");
      });
    }
    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP18[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK18[index]}, Nilai 1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tes Kepribadian 16-18',
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
                          child: Text('16', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Aturan perlu dipertanyakan',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP16,
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
                          groupValue: _selectedValueK16,
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
                          'Aturan membuat adil',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP16,
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
                          groupValue: _selectedValueK16,
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
                          'Aturan membuat bosan',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP16,
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
                          groupValue: _selectedValueK16,
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
                          'Aturan membuat aman',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP16,
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
                          groupValue: _selectedValueK16,
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
                          child: Text('17', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Pendidikan, Kebudayaan',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP17,
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
                          groupValue: _selectedValueK17,
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
                          'Prestasi, Ganjaran',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP17,
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
                          groupValue: _selectedValueK17,
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
                          'Keselamatan, keamanan',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP17,
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
                          groupValue: _selectedValueK17,
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
                          'Sosial, Perkumpulan kelompok',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP17,
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
                          groupValue: _selectedValueK17,
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
                          child: Text('18', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Memimpin, Pendekatan langsung',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP18,
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
                          groupValue: _selectedValueK18,
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
                          'Suka bergaul, Antusias',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP18,
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
                          groupValue: _selectedValueK18,
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
                          'Dapat diramal, Konsisten',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP18,
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
                          groupValue: _selectedValueK18,
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
                          'Waspada, Hati-hati',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP18,
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
                          groupValue: _selectedValueK18,
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
                            Kepribadian19sd21(
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
                          answerp10: widget.answerp10,
                          answerk10: widget.answerk10,
                          answerp11: widget.answerp11,
                          answerk11: widget.answerk11,
                          answerp12: widget.answerp12,
                          answerk12: widget.answerk12,
                          answerp13: widget.answerp13,
                          answerk13: widget.answerk13,
                          answerp14: widget.answerp14,
                          answerk14: widget.answerk14,
                          answerp15: widget.answerp15,
                          answerk15: widget.answerk15,
                          answerp16: p16 ?? '',
                          answerk16: k16 ?? '',
                          answerp17: p17 ?? '',
                          answerk17: k17 ?? '',
                          answerp18: p18 ?? '',
                          answerk18: k18 ?? '',
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

