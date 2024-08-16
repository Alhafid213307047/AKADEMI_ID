import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActionPlan extends StatefulWidget {
  const ActionPlan({super.key});

  @override
  State<ActionPlan> createState() => _ActionPlanState();
}

class _ActionPlanState extends State<ActionPlan> {
  final TextEditingController _tahun1Controller = TextEditingController();
  final TextEditingController _tahun2Controller = TextEditingController();
  final TextEditingController _tahun3Controller = TextEditingController();
  final TextEditingController _tahun4Controller = TextEditingController();
  final TextEditingController _tahun5Controller = TextEditingController();
  final TextEditingController _tahun6Controller = TextEditingController();
  final TextEditingController _tahun7Controller = TextEditingController();
  final TextEditingController _tahun8Controller = TextEditingController();
  final TextEditingController _tahun9Controller = TextEditingController();
  final TextEditingController _tahun10Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDataFromFirestore();
  }

  Future<void> _loadDataFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    final userId = user.uid;
    final firestore = FirebaseFirestore.instance;

    try {
      final doc = await firestore
          .collection('Users')
          .doc(userId)
          .collection('Karir Impian')
          .doc('action_plan')
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;

        _tahun1Controller.text = data['tahun_1'] ?? '';
        _tahun2Controller.text = data['tahun_2'] ?? '';
        _tahun3Controller.text = data['tahun_3'] ?? '';
        _tahun4Controller.text = data['tahun_4'] ?? '';
        _tahun5Controller.text = data['tahun_5'] ?? '';
        _tahun6Controller.text = data['tahun_6'] ?? '';
        _tahun7Controller.text = data['tahun_7'] ?? '';
        _tahun8Controller.text = data['tahun_8'] ?? '';
        _tahun9Controller.text = data['tahun_9'] ?? '';
        _tahun10Controller.text = data['tahun_10'] ?? '';
      } else {
        // Data tidak ditemukan, inisialisasi dengan kosong
        _tahun1Controller.text = '';
        _tahun2Controller.text = '';
        _tahun3Controller.text = '';
        _tahun4Controller.text = '';
        _tahun5Controller.text = '';
        _tahun6Controller.text = '';
        _tahun7Controller.text = '';
        _tahun8Controller.text = '';
        _tahun9Controller.text = '';
        _tahun10Controller.text = '';
      }
    } catch (e) {
      // Menampilkan Snackbar jika terjadi error saat memuat data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal memuat data',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveDataToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    final userId = user.uid;
    final firestore = FirebaseFirestore.instance;

    try {
      // Menyimpan data untuk masing-masing tahun
      await firestore
          .collection('Users')
          .doc(userId)
          .collection('Karir Impian')
          .doc('action_plan')
          .set({
        'tahun_1': _tahun1Controller.text,
        'tahun_2': _tahun2Controller.text,
        'tahun_3': _tahun3Controller.text,
        'tahun_4': _tahun4Controller.text,
        'tahun_5': _tahun5Controller.text,
        'tahun_6': _tahun6Controller.text,
        'tahun_7': _tahun7Controller.text,
        'tahun_8': _tahun8Controller.text,
        'tahun_9': _tahun9Controller.text,
        'tahun_10': _tahun10Controller.text,
      });

      // Menampilkan Snackbar dengan font Poppins
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data berhasil disimpan',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      // Menampilkan Snackbar jika terjadi error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal menyimpan data',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Action Plan',
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
            _buildYearSection('Tahun ke-1', _tahun1Controller),
            _buildYearSection('Tahun ke-2', _tahun2Controller),
            _buildYearSection('Tahun ke-3', _tahun3Controller),
            _buildYearSection('Tahun ke-4', _tahun4Controller),
            _buildYearSection('Tahun ke-5', _tahun5Controller),
            _buildYearSection('Tahun ke-6', _tahun6Controller),
            _buildYearSection('Tahun ke-7', _tahun7Controller),
            _buildYearSection('Tahun ke-8', _tahun8Controller),
            _buildYearSection('Tahun ke-9', _tahun9Controller),
            _buildYearSection('Tahun ke-10', _tahun10Controller),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: ElevatedButton(
                   onPressed: () async {
                    await _saveDataToFirestore();
                  },
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearSection(String yearLabel, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          yearLabel,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          minLines: 5,
          maxLines: 20,
          keyboardType: TextInputType.multiline,
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
            hintText: 'Masukkan rencana untuk $yearLabel',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
