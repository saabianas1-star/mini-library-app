import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B1D14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A2A1C),
        title: const Text(
          'الرئيسية',
          style: TextStyle(color: Color(0xFFD4AF37)),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'مرحبًا بك في المكتبة 📚\n(هاي الشاشة رح نبنيها لاحقًا)',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}
