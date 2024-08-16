import 'package:akademi_id/tesMinat/tm_A.dart';
import 'package:flutter/material.dart';

class InstruksiTesMinat extends StatefulWidget {
  const InstruksiTesMinat({super.key});

  @override
  State<InstruksiTesMinat> createState() => _InstruksiTesMinatState();
}

class _InstruksiTesMinatState extends State<InstruksiTesMinat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Tes Minat',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Instruksi!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Berikut ini adalah daftar beberapa jenis pekerjaan yang tersusun dalam beberapa kelompok. '
                'Setiap kelompok terdiri atas 12 jenis pekerjaan yang memiliki keahlian tersendiri.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tugas anda adalah memilih pekerjaan mana yang paling anda sukai atau ingin anda lakukan, terlepas dari upah yang akan diterima atau apakah anda akan berhasil mengerjakannya atau tidak.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Caranya adalah dengan mencantumkan angka secara berturut-turut dari angka 1(satu) sampai dengan 12 (duabelas) dibelakang setiap pekerjaan dalam masing-masing kelompok.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(
                        text: 'Angka 1 menunjukan pekerjaan yang paling '),
                    TextSpan(
                      text: 'disukai',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                        text:
                            ' dan seterusnya sampai angka 12 yang menunjukan pekerjaan yang paling '),
                    TextSpan(
                      text: 'tidak disukai',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Bekerjalah dengan cepat dan tuliskan angka sesuai dengan kesan anda yang pertama muncul.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TM_A()),
                    );
                  },
                  child: const Text(
                    'Mulai Tes',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 46, 155, 233),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
