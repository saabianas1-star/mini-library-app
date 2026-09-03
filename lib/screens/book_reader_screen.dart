import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/book.dart';

class BookReaderScreen extends StatefulWidget {
  final Book book;

  const BookReaderScreen({super.key, required this.book});

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  bool _isNightMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isNightMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(widget.book.title),
        backgroundColor: _isNightMode ? Colors.black : null,
        foregroundColor: _isNightMode ? Colors.white : null,
        actions: [
          IconButton(
            icon: Icon(_isNightMode ? Icons.dark_mode : Icons.dark_mode_outlined),
            tooltip: 'الوضع الليلي',
            onPressed: () {
              setState(() {
                _isNightMode = !_isNightMode;
              });
            },
          ),
        ],
      ),
      body: SfPdfViewer.file(
        File(widget.book.pdfPath),
      ),
    );
  }
}
