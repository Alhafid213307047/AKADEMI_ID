import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:akademi_id/LatihanEnterpreneur/editLatihan.dart';

class HistoryLatihan extends StatefulWidget {
  const HistoryLatihan({super.key});

  @override
  State<HistoryLatihan> createState() => _HistoryLatihanState();
}

class _HistoryLatihanState extends State<HistoryLatihan> {
  late Future<List<DocumentSnapshot>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchData(); 
  }

  Future<List<DocumentSnapshot>> _fetchData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userId = user.uid;
    final firestore = FirebaseFirestore.instance;

    final querySnapshot = await firestore
        .collection('Users')
        .doc(userId)
        .collection('Latihan Enterpreneur')
        .get();

    return querySnapshot.docs;
  }

  Future<void> _deleteData(String documentId, String namaBrand) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Latihan Enterpreneur')
          .doc(documentId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Data "$namaBrand" berhasil dihapus',
            style: const TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        _futureData = _fetchData();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal menghapus data: $e',
            style: const TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _showDeleteConfirmationDialog(
      String documentId, String namaBrand) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Penghapusan',
            style: TextStyle(fontFamily: "Poppins"),
          ),
          content: Text('Apakah Anda yakin ingin menghapus data "$namaBrand"?',
            style: TextStyle(fontFamily: "Poppins"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: const Text('Batal',
                style: TextStyle(fontFamily: "Poppins"),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                _deleteData(documentId, namaBrand);
              },
              child: const Text('Hapus',style: TextStyle(fontFamily: "Poppins"),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Latihan',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data riwayat',style: TextStyle(fontFamily: "Poppins"),));
          }

          final docs = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;

              return Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['tanggal']?.toString().isNotEmpty == true
                              ? data['tanggal'].toString()
                              : 'Belum ditambahkan',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildDataRow('Nama Brand', data['nama_brand']),
                        _buildDataRow('Tagline', data['tagline']),
                        _buildDataRow('Latar Belakang', data['latar_belakang']),
                        _buildDataRow('Produk', data['produk']),
                        _buildDataRow('Keunggulan', data['keunggulan']),
                        _buildDataRow('Target Pasar', data['target_pasar']),
                        _buildDataRow('Promosi', data['promosi']),
                        _buildDataRow('Harga Pokok', data['harga_pokok']),
                        _buildDataRow('Harga Jual', data['harga_jual']),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Colors.blue,
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditLatihan(
                                    documentId: doc.id,
                                  ),
                                ),
                              );
                              if (result == true) {
                                setState(() {
                                  _futureData = _fetchData();
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              _showDeleteConfirmationDialog(
                                  doc.id, data['nama_brand'] ?? 'Data');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDataRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value?.toString().isNotEmpty == true
                ? value.toString()
                : 'Belum ditambahkan',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
