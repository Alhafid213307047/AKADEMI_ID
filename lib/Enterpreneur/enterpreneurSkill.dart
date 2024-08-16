import 'package:akademi_id/Enterpreneur/detailEnterpreneur.dart';
import 'package:flutter/material.dart';

class EnterpreneurSkill extends StatefulWidget {
  const EnterpreneurSkill({super.key});

  @override
  State<EnterpreneurSkill> createState() => _EnterpreneurSkillState();
}

class _EnterpreneurSkillState extends State<EnterpreneurSkill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enterpreneur Skill',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: List.generate(12, (index) {
          final skillName = _getSkillText(index);
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      DetailEnterpreneur(skillName: skillName),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end);
                    var offsetAnimation = animation.drive(
                      tween.chain(CurveTween(curve: curve)),
                    );
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                ),
              );
            },
            child: _buildSkillBox(index + 1, skillName),
          );
        }),
      ),
    );
  }

  Widget _buildSkillBox(int number, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[300], // Warna abu-abu untuk box
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getSkillText(int index) {
    const skills = [
      'Kepemimpinan (Leadership)',
      'Manajemen Keuangan',
      'Manajemen Waktu',
      'Pemecahan Masalah (Problem-Solving)',
      'Inovasi dan Kreativitas',
      'Keterampilan Komunikasi',
      'Negosiasi',
      'Pemahaman Pasar',
      'Networking',
      'Ketekunan (Perseverance)',
      'Kemampuan Analitis',
      'Digital Literacy',
    ];

    return skills[index];
  }
}
