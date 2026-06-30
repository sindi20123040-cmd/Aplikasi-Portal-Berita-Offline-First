import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const _platform = MethodChannel('com.sindi.uas/native');
  int _clickCount = 0;
  bool _showEasterEgg = false;
  DateTime? _lastClickTime;

  void _handleProfileClick() {
    final now = DateTime.now();

    if (_lastClickTime != null &&
        now.difference(_lastClickTime!).inMilliseconds > 1500) {
      _clickCount = 0;
    }

    _lastClickTime = now;
    _clickCount++;

    if (_clickCount == 5) {
      setState(() {
        _showEasterEgg = true;
      });

      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showEasterEgg = false;
            _clickCount = 0;
          });
        }
      });
    }
  }

  Future<void> _triggerNativeReverseNIM() async {
    try {
      await _platform.invokeMethod('reverseNIM', {'nim': '20123040'});
    } on PlatformException catch (_) {
      // Handle error jika platform tidak mendukung
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profil Pengembang',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 29, 59),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _triggerNativeReverseNIM,
                    icon: const Icon(Icons.code),
                    label: const Text('Balik NIM (Native Kotlin)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.orangeAccent, // <-- UBAH KE ORANGE
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.blue[50],
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Padding(
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
          if (_showEasterEgg)
            Container(
              color: Colors.black.withOpacity(0.8),
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Lottie.asset(
                  'assets/lottie/easter_egg.json',
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
