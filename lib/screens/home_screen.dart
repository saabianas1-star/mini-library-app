import 'package:flutter/material.dart';
import '../models/book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Book> books = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EBDD),
      appBar: AppBar(
        title: const Text('مكتبة الشيخ أحمد الصعبي'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5EBDD),
        foregroundColor: const Color(0xFF4E342E),
        elevation: 0,
      ),
      body: const Center(
        child: Text('ما في كتب لسا'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8D6E3F),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
