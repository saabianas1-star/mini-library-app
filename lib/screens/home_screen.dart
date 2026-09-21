import 'package:flutter/material.dart';
import '../models/book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Book> books = [];

  int get shelfCount {
    final needed = (books.length / 3).ceil();
    return needed < 3 ? 3 : needed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EBDD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5EBDD),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'مكتبة الشيخ أحمد الصعبي',
          style: TextStyle(
            color: Color(0xFF4E2F1B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFC9A24D),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: shelfCount,
        itemBuilder: (context, index) => _buildShelf(),
      ),
    );
  }

  Widget _buildShelf() {
    return Column(
      children: [
        const SizedBox(height: 150),
        Container(
          height: 18,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF8B5A2B), Color(0xFF5C3A1E)],
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
