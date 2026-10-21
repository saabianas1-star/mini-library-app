import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/book.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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
          ? const Center(child: Text('لهذا الكتاب لا يوجد ملف PDF'))
          : ColorFiltered(
              colorFilter: isNightMode
                  ? const ColorFilter.matrix(<double>[
                      -1, 0, 0, 0, 255,
                      0, -1, 0, 0, 255,
                      0, 0, -1, 0, 255,
                      0, 0, 0, 1, 0,
                    ])
                  : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
              child: SfPdfViewerTheme(
                data: SfPdfViewerThemeData(
                  backgroundColor: Colors.white,
                ),
                child: SfPdfViewer.file(
                  File(widget.book.pdfPath),
                  scrollDirection: PdfScrollDirection.horizontal,
                  pageLayoutMode: PdfPageLayoutMode.single,
                  pageSpacing: 0,
                ),
              ),
            ),
    );
  }
}
