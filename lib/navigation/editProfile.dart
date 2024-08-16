import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  final VoidCallback onProfileUpdated;

  const EditProfile({Key? key, required this.onProfileUpdated})
      : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _usernameController;
  late TextEditingController _namalengkapController;
  late TextEditingController _emailController;
  late TextEditingController _tanggallahirController;
  late TextEditingController _asalsekolahController;
  late TextEditingController _nomorteleponController;
  late TextEditingController _alamatController;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _namalengkapController = TextEditingController();
    _emailController = TextEditingController();
    _tanggallahirController = TextEditingController();
    _asalsekolahController = TextEditingController();
    _nomorteleponController = TextEditingController();
    _alamatController = TextEditingController();
    _loadUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _namalengkapController.dispose();
    _emailController.dispose();
    _tanggallahirController.dispose();
    _asalsekolahController.dispose();
    _nomorteleponController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          var data = userDoc.data() as Map<String, dynamic>;
          setState(() {
            _usernameController.text = data['username'] ?? '';
            _namalengkapController.text = data['namalengkap'] ?? '';
            _emailController.text = data['email'] ?? '';
            _tanggallahirController.text = data['tanggallahir'] ?? '';
            _asalsekolahController.text = data['asalsekolah'] ?? '';
            _nomorteleponController.text = data['nomortelepon'] ?? '';
            _alamatController.text = data['alamat'] ?? '';
            profileImageUrl = data['image'];
          });
        }
      } catch (e) {
        // Handle errors here
        print("Error loading user data: $e");
      }
    }
  }

  Future<void> _updateUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          'username': _usernameController.text,
          'namalengkap': _namalengkapController.text,
          'email': _emailController.text,
          'tanggallahir': _tanggallahirController.text,
          'asalsekolah': _asalsekolahController.text,
          'nomortelepon': _nomorteleponController.text,
          'alamat': _alamatController.text,
        });
        widget.onProfileUpdated(); // Notify ProfilePage of the update
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Profil berhasil diperbarui',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors
                    .white, 
              ),
            ),
            backgroundColor: Colors.green, 

          ),
        );

      } catch (e) {
        // Handle errors here
        print("Error updating user data: $e");
      }
    }
  }

  String _monthName(int month) {
    const months = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];
    return months[month - 1];
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(pickedDate);
      setState(() {
        _tanggallahirController.text = formattedDate;
      });
    }
  }

  void viewPhotoProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 500,
              height: 500,
              child: profileImageUrl != null && profileImageUrl!.isNotEmpty
                  ? Image.network(
                      profileImageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'images/profil.jpg',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Menyesuaikan ukuran bottom sheet
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Menyesuaikan ukuran dengan konten
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, size: 20),
                title: Text(
                  'Ambil dari kamera',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),
                onTap: () async {
                  final picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    _uploadImage(File(image.path));
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, size: 20),
                title: Text(
                  'Ambil dari galeri',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),
                onTap: () async {
                  final picker = ImagePicker();
                  final XFile? imageFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (imageFile != null) {
                    _uploadImage(File(imageFile.path));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _uploadImage(File imageFile) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Ambil data pengguna dari koleksi 'Users'
        final docSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();

        if (!docSnapshot.exists) {
          print('User document does not exist.');
          return;
        }

        final userData = docSnapshot.data() as Map<String, dynamic>?;
        String fileName = imageFile.path.split('/').last;

        // Membuat referensi Firebase Storage
        final ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('profile_pictures')
            .child(user.uid)
            .child(fileName);

        // Mendapatkan URL gambar lama
        String? oldImageUrl;
        if (userData != null && userData.containsKey('image')) {
          oldImageUrl = userData['image'] as String?;
        }

        // Mengunggah gambar ke Firebase Storage
        await ref.putFile(imageFile);

        // Mendapatkan URL gambar yang telah diunggah
        final imageUrl = await ref.getDownloadURL();

        // Memperbarui URL gambar di Firestore
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set(
          {
            'image': imageUrl,
          },
          SetOptions(merge: true),
        );

        // Menghapus gambar lama dari Firebase Storage
        if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
          try {
            final oldRef = firebase_storage.FirebaseStorage.instance
                .refFromURL(oldImageUrl);
            await oldRef.delete();
          } catch (e) {
            print('Error deleting old image: $e');
          }
        }

        setState(() {
          // Update profileImageUrl dengan URL gambar baru
          profileImageUrl = imageUrl;
        });

        Navigator.pop(context, imageUrl);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gambar berhasil diunggah',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        widget.onProfileUpdated(); 
      }
    } catch (error) {
      print('Error uploading image: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Gagal mengunggah gambar',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildFormTextField({
    required String hintText,
    required IconData icon,
    required TextInputType keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    required TextEditingController controller,
    GestureTapCallback? onTap, // Added onTap callback
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(
          fontFamily: 'Poppins',
        ),
        controller: controller,
        onTap: onTap, // Set onTap callback
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profil',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Wadah foto profil
            GestureDetector(
              onTap: () {
                // Implement your logic to update profile picture here
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: () {
                      viewPhotoProfile();
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade600,
                          width: 2.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: profileImageUrl != null &&
                                profileImageUrl!.isNotEmpty
                            ? Image.network(
                                profileImageUrl!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/profil.png',
                                fit: BoxFit.cover,
                              ),
                      ),

                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5, bottom: 4),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade600,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        _showBottomSheet();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            _buildFormTextField(
              hintText: 'Username',
              icon: Icons.person,
              keyboardType: TextInputType.text,
              controller: _usernameController,
            ),
            SizedBox(height: 15),
            _buildFormTextField(
              hintText: 'Nama Lengkap',
              icon: Icons.person,
              keyboardType: TextInputType.text,
              controller: _namalengkapController,
            ),
            SizedBox(height: 15),
            _buildFormTextField(
              hintText: 'Email',
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            SizedBox(height: 15),
            _buildFormTextField(
              hintText: 'Tanggal Lahir',
              icon: Icons.date_range,
              keyboardType: TextInputType.none,
              controller: _tanggallahirController,
              onTap: _selectDate,
            ),
            SizedBox(height: 15),
            _buildFormTextField(
              hintText: 'Asal Sekolah',
              icon: Icons.school,
              keyboardType: TextInputType.text,
              controller: _asalsekolahController,
            ),
            SizedBox(height: 15),
            _buildFormTextField(
              hintText: 'Nomor Telepon',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              controller: _nomorteleponController,
            ),
            SizedBox(height: 15),
            _buildFormTextField(
              hintText: 'Alamat',
              icon: Icons.home,
              keyboardType: TextInputType.text,
              controller: _alamatController,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Lebar penuh
              child: ElevatedButton(
                onPressed: () {
                  _updateUserData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 46, 155, 233),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Perbarui',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
