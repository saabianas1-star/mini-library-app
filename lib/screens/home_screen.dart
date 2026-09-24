import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/book.dart';
import 'add_book_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Book> books = [
    Book(
      title: 'صحيح البخاري',
      author: 'الإمام البخاري',
      description: 'كتاب تجريبي',
      price: 10,
      pdfPath: '',
    ),
  ];
  @override
void initState() {
  super.initState();
  loadBooks();
}
  Future<void> saveBooks() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = books.map((b) => jsonEncode(b.toMap())).toList();
  await prefs.setStringList('books', jsonList);
}

Future<void> loadBooks() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = prefs.getStringList('books');
  if (jsonList != null) {
    setState(() {
      books.addAll(
        jsonList.map((s) => Book.fromMap(jsonDecode(s))).toList(),
      );
    });
  }
}
void deleteBook(int index) {
  setState(() {
    books.removeAt(index);
  });
  saveBooks();
}
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
        onPressed: () async {
  final newBook = await Navigator.push<Book>(
    context,
    MaterialPageRoute(builder: (context) => const AddBookScreen()),
  );
  if (newBook != null) {
    setState(() {
      books.add(newBook);
    });
    saveBooks();
  }
},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: shelfCount,
          itemBuilder: (context, index) => _buildShelf(index),
        ),
      ),
    );
  }

  Widget _buildShelf(int index) {
    final shelfBooks = books.skip(index * 3).take(3).toList();
    return Column(
      children: [
        SizedBox(
          height: 210,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(3, (i) {
              return Expanded(
                child: i < shelfBooks.length
                    ? _buildBookCard(shelfBooks[i], index * 3 + i)
                    : const SizedBox(),
              );
            }),
          ),
        ),
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

  Widget _buildBookCard(Book book, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
      children: [
  Expanded(child: _buildCover(book)),
  const SizedBox(height: 8),
  _buildOpenButton(),
  const SizedBox(height: 6),
  GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('حذف الكتاب'),
          content: const Text('متأكد إنك بدك تحذف هذا الكتاب؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                deleteBook(index);
                Navigator.pop(context);
              },
              child: const Text('حذف', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    },
    child: const Icon(Icons.delete, color: Colors.red, size: 20),
  ),
],
      ),
    );
  }

  Widget _buildCover(Book book) {
    final path = book.coverPath;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF14213D),
        border: Border.all(color: const Color(0xFFC9A24D), width: 2),
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 6, offset: Offset(2, 3)),
        ],
        image: path != null
            ? DecorationImage(image: FileImage(File(path)), fit: BoxFit.cover)
            : null,
      ),
      child: path == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  book.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFC9A24D),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildOpenButton() {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF3E6CC),
          foregroundColor: const Color(0xFF4E2F1B),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'افتح الكتاب',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
