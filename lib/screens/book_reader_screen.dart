import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/book.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BookReaderScreen extends StatefulWidget {
  final Book book;
  const BookReaderScreen({super.key, required this.book});

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  bool isNightMode = false;
final PdfViewerController _pdfController = PdfViewerController();
bool _restored = false;

String get _pageKey => 'last_page_${widget.book.pdfPath}';

Future<void> _restoreLastPage() async {
  final prefs = await SharedPreferences.getInstance();
  final page = prefs.getInt(_pageKey) ?? 1;
  if (page > 1) _pdfController.jumpToPage(page);
  _restored = true;
}

Future<void> _saveLastPage(int page) async {
  if (!_restored) return;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(_pageKey, page);
}
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
                                controller: _pdfController,
              onDocumentLoaded: (details) {
                _restoreLastPage();
              },
              onPageChanged: (details) {
                _saveLastPage(details.newPageNumber);
              },
                ),
              ),
            ),
    );
  }
}
