import 'dart:io';
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
  bool isNightMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        actions: [
          IconButton(
            icon: Icon(isNightMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              setState(() {
                isNightMode = !isNightMode;
              });
            },
          ),
        ],
      ),
      body: widget.book.pdfPath.isEmpty
          ? const Center(child: Text('لا يوجد ملف PDF لهذا الكتاب'))
          : SfPdfViewerTheme(
              data: SfPdfViewerThemeData(
                brightness: isNightMode ? Brightness.dark : Brightness.light,
              ),
              child: SfPdfViewer.file(File(widget.book.pdfPath)),
            ),
    );
  }
}
