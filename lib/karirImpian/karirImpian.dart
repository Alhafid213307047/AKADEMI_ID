import 'package:akademi_id/karirImpian/pengenalanDiri.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class KarirImpian extends StatefulWidget {
  const KarirImpian({super.key});

  @override
  State<KarirImpian> createState() => _KarirImpianState();
}

class _KarirImpianState extends State<KarirImpian> {
  // Controllers untuk TextFormField
  final TextEditingController _pekerjaanImpianController1 =
      TextEditingController();
  final TextEditingController _jurusanKuliahController1 =
      TextEditingController();
  final TextEditingController _jurusanSMAController1 = TextEditingController();
  final TextEditingController _keterampilanController1 =
      TextEditingController();

  final TextEditingController _pekerjaanImpianController2 =
      TextEditingController();
  final TextEditingController _jurusanKuliahController2 =
      TextEditingController();
  final TextEditingController _jurusanSMAController2 = TextEditingController();
  final TextEditingController _keterampilanController2 =
      TextEditingController();

  final TextEditingController _pekerjaanImpianController3 =
      TextEditingController();
  final TextEditingController _jurusanKuliahController3 =
      TextEditingController();
  final TextEditingController _jurusanSMAController3 = TextEditingController();
  final TextEditingController _keterampilanController3 =
      TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    final userId = user.uid;

    final karirImpianRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Karir Impian');

    try {
      final doc1 = await karirImpianRef.doc('pilihan1').get();
      final doc2 = await karirImpianRef.doc('pilihan2').get();
      final doc3 = await karirImpianRef.doc('pilihan3').get();

      if (doc1.exists) {
        _pekerjaanImpianController1.text = doc1['pekerjaan_impian'] ?? '';
        _jurusanKuliahController1.text = doc1['jurusan_kuliah'] ?? '';
        _jurusanSMAController1.text = doc1['jurusan_sma_k'] ?? '';
        _keterampilanController1.text = doc1['keterampilan'] ?? '';
      }

      if (doc2.exists) {
        _pekerjaanImpianController2.text = doc2['pekerjaan_impian'] ?? '';
        _jurusanKuliahController2.text = doc2['jurusan_kuliah'] ?? '';
        _jurusanSMAController2.text = doc2['jurusan_sma_k'] ?? '';
        _keterampilanController2.text = doc2['keterampilan'] ?? '';
      }

      if (doc3.exists) {
        _pekerjaanImpianController3.text = doc3['pekerjaan_impian'] ?? '';
        _jurusanKuliahController3.text = doc3['jurusan_kuliah'] ?? '';
        _jurusanSMAController3.text = doc3['jurusan_sma_k'] ?? '';
        _keterampilanController3.text = doc3['keterampilan'] ?? '';
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi
      print('Error loading data: $e');
    }
  }
  
  Future<void> _saveData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    final userId = user.uid;
    // Ambil referensi ke koleksi "Karir Impian"
    final karirImpianRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Karir Impian');

    try {
      // Simpan data ke Firestore
      await karirImpianRef.doc('pilihan1').set({
        'pekerjaan_impian': _pekerjaanImpianController1.text,
        'jurusan_kuliah': _jurusanKuliahController1.text,
        'jurusan_sma_k': _jurusanSMAController1.text,
        'keterampilan': _keterampilanController1.text,
      });

      await karirImpianRef.doc('pilihan2').set({
        'pekerjaan_impian': _pekerjaanImpianController2.text,
        'jurusan_kuliah': _jurusanKuliahController2.text,
        'jurusan_sma_k': _jurusanSMAController2.text,
        'keterampilan': _keterampilanController2.text,
      });

      await karirImpianRef.doc('pilihan3').set({
        'pekerjaan_impian': _pekerjaanImpianController3.text,
        'jurusan_kuliah': _jurusanKuliahController3.text,
        'jurusan_sma_k': _jurusanSMAController3.text,
        'keterampilan': _keterampilanController3.text,
      });

      // Navigasi ke halaman PengenalanDiri
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              PengenalanDiri(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    } catch (e) {
      // Tangani kesalahan
      print('Error saving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Karir Impian',
          style: const TextStyle(
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
            Text(
              'Pilihan 1',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Pekerjaan Impian',
              icon: Icons.work,
              keyboardType: TextInputType.text,
              controller: _pekerjaanImpianController1,
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Jurusan Kuliah',
              icon: Icons.school,
              keyboardType: TextInputType.text,
              controller: _jurusanKuliahController1,
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Jurusan SMA/K',
              icon: Icons.school,
              keyboardType: TextInputType.text,
              controller: _jurusanSMAController1,
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Keterampilan yang harus dikuasai',
              icon: Icons.build,
              keyboardType: TextInputType.text,
              controller: _keterampilanController1,
            ),
            const SizedBox(height: 20),
            Text(
              'Pilihan 2',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Pekerjaan Impian',
              icon: Icons.work,
              keyboardType: TextInputType.text,
              controller: _pekerjaanImpianController2,
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Jurusan Kuliah',
              icon: Icons.school,
              keyboardType: TextInputType.text,
              controller: _jurusanKuliahController2,
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Jurusan SMA/K',
              icon: Icons.school,
              keyboardType: TextInputType.text,
              controller: _jurusanSMAController2,
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Keterampilan yang harus dikuasai',
              icon: Icons.build,
              keyboardType: TextInputType.text,
              controller: _keterampilanController2,
            ),
            const SizedBox(height: 20),
            Text(
              'Pilihan 3',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Pekerjaan Impian',
              icon: Icons.work,
              keyboardType: TextInputType.text,
              controller: _pekerjaanImpianController3,
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Jurusan Kuliah',
              icon: Icons.school,
              keyboardType: TextInputType.text,
              controller: _jurusanKuliahController3,
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Jurusan SMA/K',
              icon: Icons.school,
              keyboardType: TextInputType.text,
              controller: _jurusanSMAController3,
            ),
            const SizedBox(height: 10),
            _buildFormTextField(
              hintText: 'Keterampilan yang harus dikuasai',
              icon: Icons.build,
              keyboardType: TextInputType.text,
              controller: _keterampilanController3,
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 8),
                child: FloatingActionButton(
                  onPressed: _saveData,
                  backgroundColor: const Color.fromARGB(255, 46, 155, 233),
                  child: const Icon(Icons.arrow_forward,
                  color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat TextFormField
  Widget _buildFormTextField({
    required String hintText,
    required IconData icon,
    required TextInputType keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    required TextEditingController controller,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF04558F)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF04558F)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.red,
        ),
      ),
    );
  }

}
