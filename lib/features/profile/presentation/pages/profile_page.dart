import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _clickCount = 0;
  bool _showEasterEgg = false;
  DateTime? _lastClickTime;

  void _handleProfileClick() {
    final now = DateTime.now();

    // Jika ketukan terlalu lama jedanya (lebih dari 1.5 detik), reset hitungan dari awal
    if (_lastClickTime != null &&
        now.difference(_lastClickTime!).inMilliseconds > 1500) {
      _clickCount = 0;
    }

    _lastClickTime = now;
    _clickCount++;

    // TANTANGAN ANTI-AI NIM Akhiran 0 -> Memicu rahasia setelah 5 kali klik cepat
    if (_clickCount == 5) {
      setState(() {
        _showEasterEgg = true;
      });

      // Sembunyikan kembali animasi secara otomatis setelah 3 detik sesuai soal UAS
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showEasterEgg = false;
            _clickCount = 0; // Reset kembali hitungan
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light Mode permanen sesuai NIM Genap
      appBar: AppBar(
        title: const Text(
          'Profil Pengembang',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // TAMPILAN UTAMA PROFIL
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Detektor ketukan foto profil
                  GestureDetector(
                    onTap: _handleProfileClick,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blueAccent, width: 4),
                      ),
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey,
                        // Kamu bisa mengganti ikon ini dengan file aset foto aslimu nanti
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Sindi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'NIM: 20123040',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Card(
                    color: Colors.blueIndexed,
                    elevation: 0,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Petunjuk: Klik foto profil sebanyak 5 kali secara cepat untuk memicu Easter Egg!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // EASTER EGG LOTTIE (Memenuhi layar selama 3 detik)
          if (_showEasterEgg)
            Container(
              color: Colors.black.withOpacity(0.8),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Lottie.network(
                  // Menggunakan URL JSON Lottie publik yang ringan agar hemat penyimpanan 6GB kamu!
                  'https://assets2.lottiefiles.com/packages/lf20_tou91b10.json', // Animasi perayaan/congrats
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
