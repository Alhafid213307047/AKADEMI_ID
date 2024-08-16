import 'package:akademi_id/tesKepribadian/kepribadian4-6.dart';
import 'package:flutter/material.dart';

class Kepribadian1sd3 extends StatefulWidget {
  const Kepribadian1sd3({super.key});

  @override
  State<Kepribadian1sd3> createState() => _Kepribadian1sd3State();
}

class _Kepribadian1sd3State extends State<Kepribadian1sd3> {
  int? _selectedValueP1;
  int? _selectedValueK1;
  final List<String> _indexP = ['S', 'I', 'D', 'C'];
  final List<String> _indexK = ['S', 'I', 'D', 'C'];
  String? p1;
  String? k1;

  int? _selectedValueP2;
  int? _selectedValueK2;
  final List<String> _indexP2 = ['C', 'D', 'I', 'S'];
  final List<String> _indexK2 = ['C', 'D', 'I', 'S'];
  String? p2;
  String? k2;

  int? _selectedValueP3;
  int? _selectedValueK3;
  final List<String> _indexP3 = ['I', 'C', 'S', 'D'];
  final List<String> _indexK3 = ['I', 'C', 'S', 'D'];
  String? p3;
  String? k3;

  void _checkSelection(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK1 == value) {
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
          _selectedValueP1 = null;
          p1 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP1 = value;
        p1 = _indexP[index];
        print("$p1");
      });
    } else if (column == 'K') {
      if (_selectedValueP1 == value) {
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
          _selectedValueK1 = null;
          k1 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK1 = value;
        k1 = _indexK[index];
        print("$k1");
      });
    }

    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK[index]}, Nilai 1');
    }
  }

  void _checkSelection2(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK2 == value) {
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
          _selectedValueP2 = null;
          p2 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP2 = value;
        p2 = _indexP2[index];
        print("$p2");
      });
    } else if (column == 'K') {
      if (_selectedValueP2 == value) {
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
          _selectedValueK2 = null;
          k2 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK2 = value;
        k2 = _indexK2[index];
        print("$k2");
      });
    }

    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP2[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK2[index]}, Nilai 1');
    }
  }

  void _checkSelection3(int? value, String column, int index) {
    if (column == 'P') {
      if (_selectedValueK3 == value) {
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
          _selectedValueP3 = null;
          p3 = null;
        });
        return;
      }
      setState(() {
        _selectedValueP3 = value;
        p3 = _indexP3[index];
        print("$p3");
      });
    } else if (column == 'K') {
      if (_selectedValueP3 == value) {
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
          _selectedValueK3 = null;
          k3 = null;
        });
        return;
      }
      setState(() {
        _selectedValueK3 = value;
        k3 = _indexK3[index];
        print("$k3");
      });
    }
    // Print log based on selection
    if (column == 'P') {
      print('Kolom=P$index, Kategori=${_indexP3[index]}, Nilai 1');
    } else if (column == 'K') {
      print('Kolom=K$index, Kategori=${_indexK3[index]}, Nilai 1');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tes Kepribadian 1-3',
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
                          child: Text('1', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Gampangan, Mudah setuju',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP1,
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
                          groupValue: _selectedValueK1,
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
                          'Percaya, Mudah percaya pada orang',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP1,
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
                          groupValue: _selectedValueK1,
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
                      'Petualang, Mengambil risiko',
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                  ),
                  Center(
                    child: Radio<int>(
                      value: 3,
                      groupValue: _selectedValueP1,
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
                      groupValue: _selectedValueK1,
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
                      'Toleran, Menghormati',
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                  ),
                  Center(
                    child: Radio<int>(
                      value: 4,
                      groupValue: _selectedValueP1,
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
                      groupValue: _selectedValueK1,
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
                          child: Text('2', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Lembut suara, Pendiam',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP2,
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
                          groupValue: _selectedValueK2,
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
                          'Optimistik, Visioner',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP2,
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
                          groupValue: _selectedValueK2,
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
                          'Pusat Perhatian, Suka gaul',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP2,
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
                          groupValue: _selectedValueK2,
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
                          'Pendamai, Membawa Harmoni',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP2,
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
                          groupValue: _selectedValueK2,
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
                          child: Text('3', style: TextStyle(fontSize: 14)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 3),
                          child: Text(
                            'Menyemangati orang',
                            style: TextStyle(fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Radio<int>(
                          value: 1,
                          groupValue: _selectedValueP3,
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
                          groupValue: _selectedValueK3,
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
                          'Berusaha sempurna',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 2,
                          groupValue: _selectedValueP3,
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
                          groupValue: _selectedValueK3,
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
                          'Bagian dari kelompok',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 3,
                          groupValue: _selectedValueP3,
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
                          groupValue: _selectedValueK3,
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
                          'Ingin membuat tujuan',
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                      ),
                      Center(
                        child: Radio<int>(
                          value: 4,
                          groupValue: _selectedValueP3,
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
                          groupValue: _selectedValueK3,
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
                    onPressed: (){
                       Navigator.of(context).pushReplacement(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Kepribadian4sd6(
                          answerp1: p1 ?? '',
                          answerk1: k1 ?? '',
                          answerp2: p2 ?? '',
                          answerk2: k2 ?? '',
                          answerp3: p3 ?? '',
                          answerk3: k3 ?? '',
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
