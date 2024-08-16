
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EditLatihan extends StatefulWidget {
  final String documentId;

  const EditLatihan({super.key, required this.documentId});

  @override
  State<EditLatihan> createState() => _EditLatihanState();
}

class _EditLatihanState extends State<EditLatihan> {
  late final TextEditingController _namaBrandController;
  late final TextEditingController _taglineController;
  late final TextEditingController _latarBelakangController;
  late final TextEditingController _produkController;
  late final TextEditingController _keunggulanController;
  late final TextEditingController _targetPasarController;
  late final TextEditingController _promosiController;
  late final TextEditingController _hargaPokokController;
  late final TextEditingController _hargaJualController;

  @override
  void initState() {
    super.initState();
    _namaBrandController = TextEditingController();
    _taglineController = TextEditingController();
    _latarBelakangController = TextEditingController();
    _produkController = TextEditingController();
    _keunggulanController = TextEditingController();
    _targetPasarController = TextEditingController();
    _promosiController = TextEditingController();
    _hargaPokokController = TextEditingController();
    _hargaJualController = TextEditingController();
    _loadData();
  }

  Future<void> _loadData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userId = user.uid;
    final firestore = FirebaseFirestore.instance;
    final doc = await firestore
        .collection('Users')
        .doc(userId)
        .collection('Latihan Enterpreneur')
        .doc(widget.documentId)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      _namaBrandController.text = data['nama_brand'] ?? '';
      _taglineController.text = data['tagline'] ?? '';
      _latarBelakangController.text = data['latar_belakang'] ?? '';
      _produkController.text = data['produk'] ?? '';
      _keunggulanController.text = data['keunggulan'] ?? '';
      _targetPasarController.text = data['target_pasar'] ?? '';
      _promosiController.text = data['promosi'] ?? '';
      _hargaPokokController.text = data['harga_pokok']?.toString() ?? '';
      _hargaJualController.text = data['harga_jual']?.toString() ?? '';
    }
  }

  Future<void> _saveData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userId = user.uid;
    final firestore = FirebaseFirestore.instance;

    await firestore
        .collection('Users')
        .doc(userId)
        .collection('Latihan Enterpreneur')
        .doc(widget.documentId)
        .set({
      'nama_brand': _namaBrandController.text,
      'tagline': _taglineController.text,
      'latar_belakang': _latarBelakangController.text,
      'produk': _produkController.text,
      'keunggulan': _keunggulanController.text,
      'target_pasar': _targetPasarController.text,
      'promosi': _promosiController.text,
      'harga_pokok': double.tryParse(_hargaPokokController.text) ?? 0.0,
      'harga_jual': double.tryParse(_hargaJualController.text) ?? 0.0,
      'tanggal':
          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now()),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Data berhasil disimpan',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );

    // Mereset form
    setState(() {
      _namaBrandController.clear();
      _taglineController.clear();
      _latarBelakangController.clear();
      _produkController.clear();
      _keunggulanController.clear();
      _targetPasarController.clear();
      _promosiController.clear();
      _hargaPokokController.clear();
      _hargaJualController.clear();
    });

    // Kembali ke halaman sebelumnya dengan data yang diperbarui
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _namaBrandController.dispose();
    _taglineController.dispose();
    _latarBelakangController.dispose();
    _produkController.dispose();
    _keunggulanController.dispose();
    _targetPasarController.dispose();
    _promosiController.dispose();
    _hargaPokokController.dispose();
    _hargaJualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Latihan',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
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
                    fontSize: 16,
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
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
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
