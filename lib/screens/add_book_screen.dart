import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';
import 'package:file_picker/file_picker.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descController = TextEditingController();
String? coverPath;
  String? pdfPath;

Future<void> pickCover() async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: ImageSource.gallery);
  if (picked != null) {
    setState(() {
      coverPath = picked.path;
    });
  }
}
  Future<void> pickPdf() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );
  if (result != null && result.files.single.path != null) {
    setState(() {
      pdfPath = result.files.single.path;
    });
  }
  }
  void save() {
    if (titleController.text.trim().isEmpty) return;

    final book = Book(
      title: titleController.text.trim(),
      author: authorController.text.trim(),
      description: descController.text.trim(),
      price: 0,
      pdfPath: pdfPath ?? '',
      coverPath: coverPath,
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
            GestureDetector(
  onTap: pickCover,
  child: Container(
    height: 180,
    decoration: BoxDecoration(
      color: const Color(0xFFF3E6CC),
      border: Border.all(color: const Color(0xFFC9A24D)),
      borderRadius: BorderRadius.circular(8),
      image: coverPath != null
          ? DecorationImage(
              image: FileImage(File(coverPath!)),
              fit: BoxFit.cover,
            )
          : null,
    ),
    child: coverPath == null
        ? const Center(child: Text('اضغط لاختيار صورة الغلاف'))
        : null,
  ),
),
            const SizedBox(height: 12),
GestureDetector(
  onTap: pickPdf,
  child: Container(
    height: 60,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xFFF3E6CC),
      border: Border.all(color: const Color(0xFFC9A24D)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      pdfPath == null ? 'اضغط لاختيار ملف PDF' : 'تم اختيار الملف ✓',
    ),
  ),
),
const SizedBox(height: 16),
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
