import 'package:akademi_id/LatihanEnterpreneur/historyLatihan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LatihanEnterpreneur extends StatefulWidget {
  const LatihanEnterpreneur({super.key});

  @override
  State<LatihanEnterpreneur> createState() => _LatihanEnterpreneurState();
}

class _LatihanEnterpreneurState extends State<LatihanEnterpreneur> {
  final TextEditingController _namaBrandController = TextEditingController();
  final TextEditingController _taglineController = TextEditingController();
  final TextEditingController _latarBelakangController =
      TextEditingController();
  final TextEditingController _produkController = TextEditingController();
  final TextEditingController _keunggulanController = TextEditingController();
  final TextEditingController _targetPasarController = TextEditingController();
  final TextEditingController _promosiController = TextEditingController();
  final TextEditingController _hargaPokokController = TextEditingController();
  final TextEditingController _hargaJualController = TextEditingController();

  Future<void> _saveData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'User not logged in',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      );
      return;
    }
    final userId = user.uid;
    final firestore = FirebaseFirestore.instance;

    final formattedDate =
        DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now());

    try {
      await firestore
          .collection('Users')
          .doc(userId)
          .collection('Latihan Enterpreneur')
          .doc(formattedDate)
          .set({
        'nama_brand': _namaBrandController.text,
        'tagline': _taglineController.text,
        'latar_belakang': _latarBelakangController.text,
        'produk': _produkController.text,
        'keunggulan': _keunggulanController.text,
        'target_pasar': _targetPasarController.text,
        'promosi': _promosiController.text,
        'harga_pokok': _hargaPokokController.text,
        'harga_jual': _hargaJualController.text,
        'tanggal': formattedDate,
      });

      // Reset all fields after successful save
      _namaBrandController.clear();
      _taglineController.clear();
      _latarBelakangController.clear();
      _produkController.clear();
      _keunggulanController.clear();
      _targetPasarController.clear();
      _promosiController.clear();
      _hargaPokokController.clear();
      _hargaJualController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data berhasil disimpan',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal menyimpan data: $e',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Latihan Enterpreneur',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
       actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HistoryLatihan(),
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
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection('Nama Brand', _namaBrandController),
            _buildSection('Tagline', _taglineController),
            _buildSection('Latar Belakang', _latarBelakangController,
                isTextArea: true),
            _buildSection('Produk', _produkController),
            _buildSection('Keunggulan', _keunggulanController,
                isTextArea: true),
            _buildSection('Target Pasar', _targetPasarController),
            _buildSection('Promosi', _promosiController),
            _buildSection('Harga Pokok', _hargaPokokController, isNumber: true),
            _buildSection('Harga Jual', _hargaJualController, isNumber: true),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 46, 155, 233),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String label, TextEditingController controller,
      {bool isTextArea = false, bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          minLines: isTextArea ? 5 : 1,
          maxLines: isTextArea ? 20 : 1,
          keyboardType: isNumber
              ? TextInputType.numberWithOptions(decimal: true)
              : isTextArea
                  ? TextInputType.multiline
                  : TextInputType.text,
          style: const TextStyle(fontFamily: 'Poppins',fontSize: 14),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF04558F)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF04558F)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF04558F)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            hintText: 'Masukkan $label',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
