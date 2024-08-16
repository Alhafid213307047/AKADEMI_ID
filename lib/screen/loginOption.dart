import 'package:akademi_id/Admin/dashboardAdmin.dart';
import 'package:akademi_id/navigation/dashboard.dart';
import 'package:akademi_id/screen/forgotPassword.dart';
import 'package:akademi_id/screen/registerPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginOption extends StatefulWidget {
  const LoginOption({super.key});

  @override
  State<LoginOption> createState() => _LoginOptionState();
}

class _LoginOptionState extends State<LoginOption> {
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

   @override
  void initState() {
    super.initState();
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        User? user = userCredential.user;
        if (user != null) {
          // Cek apakah pengguna adalah admin
          final adminDoc = await FirebaseFirestore.instance
              .collection('Admin')
              .doc(user.uid)
              .get();

          if (adminDoc.exists) {
           showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              },
            );

            await Future.delayed(const Duration(seconds: 3));

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const DashboardAdmin()),
            );
          } else {
            // Jika bukan admin, cek verifikasi email
            if (user.emailVerified) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                },
              );

              await Future.delayed(const Duration(seconds: 3));

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Dashboard()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Email anda belum terverifikasi! Silahkan cek pada inbox untuk melakukan verifikasi',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Email/Password yang anda masukkan salah! Coba lagi.',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> signInWithGoogle() async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    );

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Sign out the current user to force account selection
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Navigator.of(context).pop(); // Close loading dialog
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .set({
            'namalengkap': '',
            'username': user.displayName ?? '',
            'asalsekolah': '',
            'email': user.email ?? '',
            'alamat': '',
            'notelepon': '',
            'tanggallahir': '',
            'image': '',
          });
        }

        // Wait for 2 seconds to show loading indicator
        await Future.delayed(const Duration(seconds: 2));

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      }
    } catch (error) {
      Navigator.of(context).pop(); // Close loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Gagal! Mohon periksa kembali jaringan internet anda.',
          style: TextStyle(fontFamily: "Poppins"),),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 35, bottom: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo_ukwms.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    'UKWMS Kampus Madiun',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 150,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 46, 155, 233),
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'AKADEMI.ID',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Let's begin your dream career journey",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildFormTextField(
                hintText: 'Masukkan email anda',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildFormTextField(
                hintText: 'Masukan password anda',
                icon: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                controller: _passwordController,
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    child: const Text(
                      'Lupa Password?',
                      style: TextStyle(
                        color: Color(0xFF2682C5),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Belum punya akun?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Daftar',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2682C5),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  signIn();
                },
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 46, 155, 233),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Atau",
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  signInWithGoogle();
                },
                icon: Image.asset(
                  'assets/images/icon_google.png',
                  width: 24,
                  height: 24,
                ),
                label: const Text(
                  'Masuk dengan Google',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey.shade300,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
      style: const TextStyle(fontFamily: 'Poppins'),
      controller: controller,
      onChanged: (value) {
        // Memanggil validate untuk menghilangkan error saat teks diubah
        setState(() {
          _formKey.currentState?.validate();
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Kolom ini harus diisi';
        }
        if (hintText == 'Masukkan email anda' &&
            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Format email tidak valid';
        }
        if (hintText == 'Masukan password anda' && value.length < 8) {
          return 'Password minimal 8 karakter';
        }
        if (hintText == 'Masukan password anda' &&
            !RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
          return 'Password harus menggunakan kombinasi huruf dan angka';
        }
        return null;
      },
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
