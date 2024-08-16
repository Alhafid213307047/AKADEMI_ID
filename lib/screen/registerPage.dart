import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'loginoption.dart'; // Ganti ini dengan import halaman LoginOption Anda yang sebenarnya

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

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


  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Simpan data ke Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user?.uid)
            .set({
          'namalengkap': _fullNameController.text,
          'username': _usernameController.text,
          'asalsekolah': _schoolController.text,
          'email': _emailController.text,
          'alamat': '',
          'notelepon': '',
          'tanggallahir': '',
          'image': '',
        });

        userCredential.user?.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Tautan verifikasi telah dikirim ke email Anda',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
             backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginOption()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Email ini telah terdaftar! Silahkan gunakan email lain',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
               backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Terjadi kesalahan: ${e.message}',
                style: const TextStyle(fontFamily: 'Poppins'),
              ),
               backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Terjadi kesalahan: ${e.toString()}',
              style: const TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        );
      }
    }
  }

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
          'Daftar Akun',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
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
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nama Lengkap',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildFormTextField(
                  hintText: 'Masukkan nama lengkap',
                  icon: Icons.person,
                  keyboardType: TextInputType.name,
                  controller: _fullNameController,
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildFormTextField(
                  hintText: 'Masukkan username',
                  icon: Icons.person,
                  keyboardType: TextInputType.text,
                  controller: _usernameController,
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Asal Sekolah',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildFormTextField(
                  hintText: 'Contoh format : SMPN 1 Madiun',
                  icon: Icons.school,
                  keyboardType: TextInputType.text,
                  controller: _schoolController,
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    child: const Text(
                      'Daftar',
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
      ),
    );
  }
}
