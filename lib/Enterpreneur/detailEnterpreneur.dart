import 'package:flutter/material.dart';

class DetailEnterpreneur extends StatelessWidget {
  final String skillName;

  const DetailEnterpreneur({super.key, required this.skillName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Enterpreneur',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    switch (skillName) {
      case 'Manajemen Keuangan':
        return _buildFinancialManagementContent();
      case 'Kepemimpinan (Leadership)':
        return _buildLeadershipContent();
      case 'Manajemen Waktu':
        return _buildTimeManagementContent();
      case 'Keterampilan Komunikasi':
        return _buildCommunicationSkillsContent();
      case 'Inovasi dan Kreativitas':
        return _buildInnovationContent();
      case 'Pemecahan Masalah (Problem-Solving)':
        return _buildProblemSolvingContent();
      case 'Negosiasi':
        return _buildNegotiationContent();
      case 'Pemahaman Pasar':
        return _buildMarketUnderstandingContent();
      case 'Networking':
        return _buildNetworkingContent();
      case 'Ketekunan (Perseverance)':
        return _buildPerseveranceContent();
      case 'Kemampuan Analitis':
        return _buildAnalyticalSkillsContent();
      case 'Digital Literacy':
        return _buildDigitalLiteracyContent();
      default:
        return Center(child: Text('Detail not found'));
    }
  }

  Widget _buildFinancialManagementContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Manajemen Keuangan',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pemahaman tentang cara mengelola keuangan, anggaran, dan pengendalian biaya adalah kunci untuk menjaga kesehatan bisnis.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/2_keuangan.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Memahami keuangan akan membantumu memulai bisnis kecil-kecilan atau mengelola uang saku dengan baik.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Buat anggaran bulanan.\n'
            '• Simpan sebagian uang saku.\n'
            '• Pelajari cara berinvestasi sederhana.\n'
            '• Bantu orang tua mengelola keuangan keluarga (jika memungkinkan).',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildLeadershipContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Kepemimpinan (Leadership)',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kemampuan untuk memimpin tim, menginspirasi, dan memotivasi orang lain untuk mencapai tujuan bersama.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
               
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/1_leadership.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
         Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Seorang pemimpin yang baik bisa mengatur tim, membuat keputusan, dan memotivasi orang lain.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Jadi ketua kelas atau organisasi sekolah.\n'
            '• Inisiasi proyek bersama teman-teman.\n'
            '• Belajar dari pemimpin yang kamu kagumi.\n'
            '• Latih kemampuan berbicara di depan umum.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeManagementContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Manajemen Waktu',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keterampilan dalam mengatur waktu dengan efektif untuk meningkatkan produktivitas dan memastikan semua aspek bisnis berjalan dengan baik.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/3_waktu.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Dengan manajemen waktu yang baik, kamu bisa menyelesaikan tugas dengan lebih cepat dan efisien.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Buat jadwal harian atau mingguan.\n'
            '• Prioritaskan tugas yang penting.\n'
            '• Hindari menunda-nunda pekerjaan.\n'
            '• Gunakan aplikasi pengingat atau kalender.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildCommunicationSkillsContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Keterampilan Komunikasi',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kemampuan berkomunikasi dengan jelas dan efektif, baik secara lisan maupun tulisan, dengan berbagai pemangku kepentingan, termasuk karyawan, pelanggan, dan investor.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/4_komunikasi.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Komunikasi yang baik akan membantumu membangun hubungan yang baik dengan orang lain.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Latih berbicara di depan umum.\n'
            '• Tulis diary atau blog.\n'
            '• Dengarkan orang lain dengan seksama.\n'
            '• Berlatih presentasi.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInnovationContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Inovasi dan Kreativitas',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mampu menciptakan ide-ide baru dan inovatif untuk produk atau layanan yang ditawarkan.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/5_inovasi.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Inovasi adalah kunci sukses dalam bisnis.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Baca buku atau artikel yang inspiratif.\n'
            '• Ikuti kelas seni atau musik.\n'
            '• Bermain game yang melatih kreativitas.\n'
            '• Habiskan waktu di alam untuk mendapatkan inspirasi.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProblemSolvingContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Pemecahan Masalah (Problem-Solving)',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kemampuan untuk mengidentifikasi masalah, menganalisis situasi, dan menemukan solusi yang efektif.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/6_problem.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Setiap masalah adalah peluang untuk belajar dan tumbuh.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Latih diri untuk berpikir kritis.\n'
            '• Cari berbagai sudut pandang.\n'
            '• Jangan takut mencoba hal baru.\n'
            '• Jangan menyerah ketika menghadapi kesulitan.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNegotiationContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Negosiasi',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kemampuan untuk bernegosiasi dengan baik dapat membantu dalam mendapatkan kesepakatan yang menguntungkan dengan pemasok, pelanggan, atau investor.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/7_negosiasi.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Negosiasi akan membantumu mendapatkan apa yang kamu inginkan.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Berlatih menegosiasi dengan orang tua atau teman.\n'
            '• Pelajari teknik negosiasi yang efektif.\n'
            '• Jadilah pendengar yang baik.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildMarketUnderstandingContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Pemahaman Pasar',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mengerti dinamika pasar, kebutuhan pelanggan, dan tren industri adalah penting untuk mengembangkan strategi bisnis yang efektif.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/8_pasar.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Dengan memahami pasar, kamu bisa menawarkan produk atau jasa yang dibutuhkan.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Lakukan riset pasar sederhana.\n'
            '• Perhatikan tren yang sedang berkembang.\n'
            '• Bicaralah dengan orang-orang di sekitarmu.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

Widget _buildNetworkingContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Networking',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Membangun dan memelihara hubungan yang kuat dengan orang lain dalam industri atau komunitas bisnis untuk mendapatkan dukungan dan kesempatan baru.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/9_networking.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Networking akan membuka banyak peluang.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Bergabung dengan klub atau organisasi.\n'
            '• Hadiri acara-acara yang relevan.\n'
            '• Gunakan media sosial untuk berinteraksi dengan orang lain.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerseveranceContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Ketekunan (Perseverance)',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kemampuan untuk tetap gigih dan tidak mudah menyerah dalam menghadapi tantangan dan kegagalan.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/10_ketekunan.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Ketekunan adalah kunci kesuksesan.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Tetapkan tujuan yang realistis.\n'
            '• Rayakan setiap pencapaian kecil.\n'
            '• Jangan takut gagal.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildAnalyticalSkillsContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Kemampuan Analitis',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menganalisis data dan informasi untuk membuat keputusan bisnis yang tepat.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/11_analitis.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Kemampuan analitis akan membantumu membuat keputusan yang tepat.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Latih diri untuk berpikir logis.\n'
            '• Cari pola dalam data.\n'
            '• Gunakan alat bantu seperti spreadsheet atau grafik.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitalLiteracyContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Digital Literacy',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keterampilan dalam menggunakan teknologi dan alat digital untuk mengoptimalkan operasi bisnis dan pemasaran.',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/Eskill/12_digital.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Text(
            'Kenapa penting:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Di era digital, kemampuan ini sangat penting.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Cara mengasah:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '• Belajar menggunakan berbagai aplikasi.\n'
            '• Buat konten di media sosial.\n'
            '• Ikuti kursus online tentang digital marketing atau pemrograman.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailWidget(String title) {
    return Center(
      child: Text(
        'Detail for $title',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
