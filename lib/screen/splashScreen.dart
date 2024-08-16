import 'package:akademi_id/Admin/dashboardAdmin.dart';
import 'package:akademi_id/navigation/dashboard.dart';
import 'package:akademi_id/screen/loginOption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _zoomAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.0,
        0.5,
        curve: Curves.easeInOut,
      ),
    ));

    _zoomAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));

    _controller.forward().then((value) async {
      // Check if user is already logged in
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Check if user is admin
        final userDoc = await FirebaseFirestore.instance
            .collection('Admin')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          // User is admin, navigate to DashboardAdmin
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardAdmin()),
          );
        } else {
          // User is not admin, navigate to Dashboard
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        }
      } else {
        // User is not logged in, navigate to LoginOption
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginOption()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _offsetAnimation,
              child: const Text(
                'AKADEMI.ID',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2682C5),
                ),
              ),
            ),
            const SizedBox(height: 4),
            ScaleTransition(
              scale: _zoomAnimation,
              child: const Text(
                "Let's begin your dream career journey",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF2682C5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
