import 'dart:io';

import 'package:akademi_id/Enterpreneur/enterpreneurSkill.dart';
import 'package:akademi_id/LatihanEnterpreneur/latihanEnterpreneur.dart';
import 'package:akademi_id/karirImpian/karirImpian.dart';
import 'package:akademi_id/modul/modulA.dart';
import 'package:akademi_id/modul/modulB.dart';
import 'package:akademi_id/navigation/profilPage.dart';
import 'package:akademi_id/navigation/riwayatPage.dart';
import 'package:akademi_id/tesBakat/tb1_PengetahuanUmum.dart';
import 'package:akademi_id/tesKepribadian/instruksiKepribadian.dart';
import 'package:akademi_id/tesMinat/instruksiTesMinat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  DateTime? _lastBackPressed;

  late final Connectivity _connectivity; // Add this field

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
  }

  Future<String> fetchUsername() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tidak terhubung ke Internet',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.black,
        ),
      );
      return 'User';
    }
    try {
      // Check if the connection is active
      final isConnected = await _checkInternetConnection();
      if (!isConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Request Timeout',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: Colors.black,
          ),
        );
        return 'User';
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          final data = userDoc.data() as Map<String, dynamic>;
          return data['username'] ?? 'User';
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Request Timeout',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.black,
        ),
      );
      return 'User';
    }
    return 'User';
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (_lastBackPressed == null ||
        DateTime.now().difference(_lastBackPressed!) >
            const Duration(seconds: 2)) {
      _lastBackPressed = DateTime.now();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tekan sekali lagi untuk keluar aplikasi',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: Colors.black,
        ),
      );
      return Future.value(false);
    } else {
      // Exit the app
      SystemNavigator.pop();
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: _selectedIndex == 0
            ? AppBar(
                title: FutureBuilder<String>(
                  future: fetchUsername(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        'Loading...',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final username = snapshot.data ?? 'User';
                      return Text(
                        'Halo, $username',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    } else {
                      return const Text(
                        'Halo, User',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    }
                  },
                ),
                automaticallyImplyLeading: false,
              )
            : null,
        body: _selectedIndex == 0
            ? Padding(
                padding: const EdgeInsets.only(right: 12, left: 12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Selamat Datang di AKADEMI.ID',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Kami hadir untuk membantu Anda menemukan bakat serta minat Anda.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/halo.png',
                                    height: 120, // adjust height as needed
                                    width: 120, // adjust width as needed
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildCircleButton(
                                    'Tes Minat',
                                    () => Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InstruksiTesMinat(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.easeInOut;
                                          final tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          final offsetAnimation =
                                              animation.drive(tween);

                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    ),
                                  ),
                                  _buildCircleButton(
                                    'Tes Bakat',
                                    () => Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            TBPengetahuan_Umum(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.easeInOut;
                                          final tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          final offsetAnimation =
                                              animation.drive(tween);

                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    ),
                                  ),
                                  _buildCircleButton(
                                    'Tes Kepribadian',
                                    () => Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            InstruksiKepribadian(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.easeInOut;
                                          final tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          final offsetAnimation =
                                              animation.drive(tween);

                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              _buildElevatedButtonWithImage(
                                imagePath: 'assets/images/karir_impian.png',
                                text: 'Karir Impian',
                                page: KarirImpian(),
                              ),
                              const SizedBox(height: 15),
                              _buildElevatedButtonWithImage(
                                imagePath:
                                    'assets/images/enterpreneur_skill.png',
                                text: 'Enterpreneur Skill',
                                page: EnterpreneurSkill(),
                              ),
                              const SizedBox(height: 15),
                              _buildElevatedButtonWithImage(
                                imagePath:
                                    'assets/images/latihan_enterpreneur.png',
                                text: 'Latihan Enterpreneur',
                                page: LatihanEnterpreneur(),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      // Place the image-text buttons at the bottom
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Tambahkan halaman ModulA dan ModulB
                            Expanded(
                              child: _buildImageTextButton(
                                imagePath: 'assets/images/modulA.png',
                                text: 'Modul A',
                                page:
                                    ModulA(), // Ganti dengan halaman ModulA yang sesuai
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildImageTextButton(
                                imagePath: 'assets/images/modulB.png',
                                text: 'Modul B',
                                page:
                                    ModulB(), // Ganti dengan halaman ModulB yang sesuai
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : _selectedIndex == 1
                ? const RiwayatPage()
                : const ProfilePage(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0
                    ? const Color(0xFF04558F)
                    : Colors.black,
              ),
              label: 'Dashboard',
              backgroundColor: _selectedIndex == 0
                  ? const Color(0xFF04558F)
                  : Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: _selectedIndex == 1
                    ? const Color(0xFF04558F)
                    : Colors.black,
              ),
              label: 'Riwayat',
              backgroundColor: _selectedIndex == 1
                  ? const Color(0xFF04558F)
                  : Colors.transparent,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _selectedIndex == 2
                    ? const Color(0xFF04558F)
                    : Colors.black,
              ),
              label: 'Profil',
              backgroundColor: _selectedIndex == 2
                  ? const Color(0xFF04558F)
                  : Colors.transparent,
            ),
          ],
          selectedLabelStyle: TextStyle(
            fontFamily: 'Poppins',
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 85,
          width: 90, // Pastikan width sama dengan height untuk lingkaran
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 46, 155, 233),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(
                  8.0), // Padding tambahan untuk menghindari teks terpotong
              child: Text(
                text,
                textAlign: TextAlign.center, // Pusatkan teks
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildElevatedButtonWithImage({
    required String imagePath,
    required String text,
    required Widget page, // Parameter untuk halaman tujuan
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => page,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(2.0, 0.0);
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
              transitionDuration: const Duration(milliseconds: 600),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 46, 155, 233),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 75, // Sesuaikan lebar sesuai kebutuhan
              height: 75, // Sesuaikan tinggi sesuai kebutuhan
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageTextButton({
    required String imagePath,
    required String text,
    required Widget page, // Parameter untuk halaman tujuan
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => page,
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
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.grey.shade300, // Set button background color to grey
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0), // Add vertical padding
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center align content horizontally
          children: [
            Image.asset(
              imagePath,
              height: 24, // adjust height as needed
              width: 24, // adjust width as needed
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
