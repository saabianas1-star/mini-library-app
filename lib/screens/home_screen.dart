import 'package:flutter/material.dart';
import '../models/book.dart';
import 'add_book_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // قائمة كتب تجريبية مبدئياً (بعدين رح نخليها تتحمل من التخزين الفعلي)
  final List<Book> books = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مكتبة الشيخ أحمد الصعبي'),
        centerTitle: true,
      ),
      body: books.isEmpty
          ? const Center(
              child: Text(
                'لا يوجد كتب بعد\nاضغط + لإضافة كتاب',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.file(
                          // مسار صورة الغلاف
                          // (لاحقاً منربطها بمسار فعلي)
                          File(book.coverPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          book.title,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6B4226),
        onPressed: () async {
          final newBook = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookScreen()),
          );
          if (newBook != null) {
            setState(() {
              books.add(newBook);
            });
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
