import 'package:flutter/material.dart';
import '../models/book.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descController = TextEditingController();

  void save() {
    if (titleController.text.trim().isEmpty) return;

    final book = Book(
      title: titleController.text.trim(),
      author: authorController.text.trim(),
      description: descController.text.trim(),
      price: 0,
      pdfPath: '',
    );

    Navigator.pop(context, book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة كتاب')),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'اسم الكتاب'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: 'المؤلف'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'شرح الكتاب'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: save,
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
