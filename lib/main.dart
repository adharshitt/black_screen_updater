import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Silent Updater',
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      home: const SilentUpdateScreen(),
    );
  }
}

// THIS IS THE "LOADING/CHECKING" PAGE (BLACK)
class SilentUpdateScreen extends StatefulWidget {
  const SilentUpdateScreen({super.key});

  @override
  State<SilentUpdateScreen> createState() => _SilentUpdateScreenState();
}

class _SilentUpdateScreenState extends State<SilentUpdateScreen> {
  String status = "Checking for silent updates...";

  @override
  void initState() {
    super.initState();
    _performSilentUpdate();
  }

  Future<void> _performSilentUpdate() async {
    // 1. App checks server for new "Posted" code...
    await Future.delayed(const Duration(seconds: 3));
    
    if (mounted) {
      setState(() => status = "Update found! Injecting new code...");
      await Future.delayed(const Duration(seconds: 1));
      
      // 2. SILENT PUSH TRIGGER:
      // Instead of an install screen, the app just swaps the UI immediately.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NewWhitePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white24),
            const SizedBox(height: 30),
            Text(
              status,
              style: const TextStyle(color: Colors.white54, fontSize: 14, fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
    );
  }
}

// THIS IS THE NEW PAGE SENT VIA SILENT CODE PUSH (WHITE)
class NewWhitePage extends StatelessWidget {
  const NewWhitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            const Text(
              'SILENT UPDATE\nSUCCESSFUL',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32, 
                fontWeight: FontWeight.w900, 
                color: Colors.black,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 2,
              width: 100,
              color: Colors.black12,
            ),
            const SizedBox(height: 20),
            const Text(
              'This page was pushed to your app instantly without a new APK download.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16, 
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}