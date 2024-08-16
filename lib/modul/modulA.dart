import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class ModulA extends StatefulWidget {
  const ModulA({super.key});

  @override
  State<ModulA> createState() => _ModulAState();
}

class _ModulAState extends State<ModulA> {
  late Future<String?> _pdfFilePath;

  @override
  void initState() {
    super.initState();
    _pdfFilePath = _loadFirebasePdf('modul/modul_A.pdf');
  }

  Future<String?> _loadFirebasePdf(String path) async {
    try {
      final refPDF = FirebaseStorage.instance.ref().child(path);
      final bytes = await refPDF.getData();

      if (bytes == null) {
        throw Exception('No data found');
      }

      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/${path.split('/').last}';
      final file = File(filePath);

      await file.writeAsBytes(bytes);

      return filePath;
    } catch (e) {
      print('Failed to load PDF: $e');
      return null;
    }
  }

  Future<void> _downloadPdf() async {
    try {
      final refPDF = FirebaseStorage.instance.ref().child('modul/modul_A.pdf');
      final bytes = await refPDF.getData();

      if (bytes == null) {
        throw Exception('No data found');
      }

      final directory = await getExternalStorageDirectory();
      final folderPath = '${directory?.path}/AkadamiID';
      final folder = Directory(folderPath);

      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      final filePath = '$folderPath/Modul Abdimas 2024 - Enterpreneur (Modul A).pdf';
      final file = File(filePath);

      await file.writeAsBytes(bytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF berhasil diunduh ke $filePath')),
      );
    } catch (e) {
      print('Failed to download PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengunduh PDF')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modul A', style: TextStyle(fontFamily: "Poppins")),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadPdf,
          ),
        ],
      ),
      body: FutureBuilder<String?>(
        future: _pdfFilePath,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',
                  style: TextStyle(fontFamily: "Poppins")),
            );
          } else if (snapshot.hasData) {
            final filePath = snapshot.data;
            if (filePath != null) {
              return PDFView(
                filePath: filePath,
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: false,
                pageFling: true,
                pageSnap: true,
              );
            } else {
              return const Center(
                child: Text('PDF tidak ditemukan',
                    style: TextStyle(fontFamily: "Poppins")),
              );
            }
          } else {
            return const Center(
              child: Text('PDF tidak ditemukan',
                  style: TextStyle(fontFamily: "Poppins")),
            );
          }
        },
      ),
    );
  }
}
