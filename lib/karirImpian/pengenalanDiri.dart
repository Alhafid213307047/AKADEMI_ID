import 'package:akademi_id/karirImpian/actionPlan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PengenalanDiri extends StatefulWidget {
  const PengenalanDiri({super.key});

  @override
  State<PengenalanDiri> createState() => _PengenalanDiriState();
}

class _PengenalanDiriState extends State<PengenalanDiri> {
  final TextEditingController _skillDimilikiController =
      TextEditingController();
  final TextEditingController _skillBelumDimilikiController =
      TextEditingController();

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

    final docRef =
        firestore.collection('Users').doc(userId).collection('Karir Impian');

    // Ambil data skill_dimiliki
    final skillDimilikiDoc = await docRef.doc('skill_dimiliki').get();
    if (skillDimilikiDoc.exists) {
      _skillDimilikiController.text = skillDimilikiDoc['skill_dimiliki'] ?? '';
    } else {
      _skillDimilikiController.text = '';
    }

    // Ambil data skill_belum_dimiliki
    final skillBelumDimilikiDoc =
        await docRef.doc('skill_belum_dimiliki').get();
    if (skillBelumDimilikiDoc.exists) {
      _skillBelumDimilikiController.text =
          skillBelumDimilikiDoc['skill_belum_dimiliki'] ?? '';
    } else {
      _skillBelumDimilikiController.text = '';
    }

   
  }

  Future<void> _saveDataToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    final userId = user.uid;
    final firestore = FirebaseFirestore.instance;

    // Simpan skill_dimiliki
    await firestore
        .collection('Users')
        .doc(userId)
        .collection('Karir Impian')
        .doc('skill_dimiliki')
        .set({
      'skill_dimiliki': _skillDimilikiController.text,
    });

    // Simpan skill_belum_dimiliki
    await firestore
        .collection('Users')
        .doc(userId)
        .collection('Karir Impian')
        .doc('skill_belum_dimiliki')
        .set({
      'skill_belum_dimiliki': _skillBelumDimilikiController.text,
    });

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Menangani tombol kembali perangkat
        Navigator.pop(context);
        return false; // Mencegah pop default
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Pengenalan Diri',
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
                'Skill yang sudah dimiliki',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              _buildTextArea(
                controller: _skillDimilikiController,
                hintText: 'Saran inputan :\n- Mengetik\n- Komputer dll.',
              ),
              const SizedBox(height: 20),
              Text(
                'Skill yang belum dimiliki',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              _buildTextArea(
                controller: _skillBelumDimilikiController,
                hintText: 'Saran inputan :\n- Mengetik\n- Komputer dll.',
              ),
              const SizedBox(height: 20),
             
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: FloatingActionButton(
                    onPressed: () async {
                      await _saveDataToFirestore();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation,
                                  secondaryAnimation) =>
                              ActionPlan(), 
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
      ),
    );
  }

  Widget _buildTextArea({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextFormField(
      controller: controller,
      minLines: 10, // Jumlah baris minimal
      maxLines: 20,
      keyboardType: TextInputType.multiline,
      style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }
}
