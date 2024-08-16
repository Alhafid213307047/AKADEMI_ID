import 'package:akademi_id/navigation/editProfile.dart';
import 'package:akademi_id/screen/loginOption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final String userId;
  Map<String, dynamic> userData = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    userId = user.uid;
    _fetchUserData();
  }

  Future<void> _confirmLogout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi Keluar',
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Apakah Anda yakin ingin keluar akun?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Tidak',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Ya',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await _handleLogout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleLogout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 2));

    Navigator.pop(context);
    await _auth.signOut();
    await googleSignIn.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginOption()),
    );
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();
      setState(() {
        userData = doc.data() as Map<String, dynamic>;
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  void _navigateToEditProfile() {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          EditProfile(
        onProfileUpdated: _fetchUserData,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    ));
    _fetchUserData();
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
              child: Center(
                child:
                    userData['image'] != null && userData['image']!.isNotEmpty
                        ? Image.network(
                            userData['image']!,
                            fit: BoxFit.cover, // Menambahkan fit: BoxFit.cover
                          )
                        : Image.asset(
                            'assets/images/profil.png',
                            fit: BoxFit.cover, // Menambahkan fit: BoxFit.cover
                          ), // Gambar default
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 46, 155, 233),
        title: Text(
          'Profil',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: userData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 46, 155, 233),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                     GestureDetector(
                        onTap: viewPhotoProfile,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: userData['image'] != null &&
                                  userData['image']!.isNotEmpty
                              ? NetworkImage(userData['image']!)
                              : AssetImage('assets/images/profil.png')
                                  as ImageProvider, // Gambar default
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        userData['username'] != null &&
                                userData['username']!.isNotEmpty
                            ? userData['username']!
                            : '-', // Tampilkan '-' jika data kosong atau null
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: _navigateToEditProfile,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Edit Profil',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          'Nama Lengkap',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        subtitle: Text(
                          userData['namalengkap'] != null &&
                                  userData['namalengkap']!.isNotEmpty
                              ? userData['namalengkap']!
                              : '-', // Tampilkan '-' jika data kosong atau null
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text(
                          'Email',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        subtitle: Text(
                          userData['email'] != null &&
                                  userData['email']!.isNotEmpty
                              ? userData['email']!
                              : '-', // Tampilkan '-' jika data kosong atau null
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.cake),
                        title: Text(
                          'Tanggal Lahir',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        subtitle: Text(
                          userData['tanggallahir'] != null &&
                                  userData['tanggallahir']!.isNotEmpty
                              ? userData['tanggallahir']!
                              : '-', // Tampilkan '-' jika data kosong atau null
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.school),
                        title: Text(
                          'Asal Sekolah',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        subtitle: Text(
                          userData['asalsekolah'] != null &&
                                  userData['asalsekolah']!.isNotEmpty
                              ? userData['asalsekolah']!
                              : '-', // Tampilkan '-' jika data kosong atau null
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text(
                          'Nomor Telepon',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        subtitle: Text(
                          userData['notelepon'] != null &&
                                  userData['notelepon']!.isNotEmpty
                              ? userData['notelepon']!
                              : '-', // Tampilkan '-' jika data kosong atau null
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text(
                          'Alamat',
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        subtitle: Text(
                          userData['alamat'] != null &&
                                  userData['alamat']!.isNotEmpty
                              ? userData['alamat']!
                              : '-', // Tampilkan '-' jika data kosong atau null
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.red, // Warna merah untuk ikon
                        ),
                        title: Text(
                          'Keluar',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.red, // Warna merah untuk teks
                          ),
                        ),
                        onTap: _confirmLogout,
                      ),

                    ],
                  ),

                ),
              ],
            ),
    );
  }
}
