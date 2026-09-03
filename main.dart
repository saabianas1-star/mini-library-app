import 'package:flutter/material.dart';

void main() {
  runApp(const MiniLibraryApp());
}

class MiniLibraryApp extends StatelessWidget {
  const MiniLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مكتبة الشيخ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6B4226), // بني
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B4226),
          secondary: const Color(0xFFD4AF37), // ذهبي
        ),
        fontFamily: 'Cairo',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المكتبة الإلكترونية'),
      ),
      body: const Center(
        child: Text('أهلاً بك في المكتبة'),
      ),
    );
  }
}
