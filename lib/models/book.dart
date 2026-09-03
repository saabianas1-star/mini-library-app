class Book {
  final String id;
  final String title;
  final String author;
  final String coverPath; // مسار صورة الغلاف
  final String description; // الشرح
  final double price; // السعر
  final String pdfPath; // مسار ملف PDF

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverPath,
    required this.description,
    required this.price,
    required this.pdfPath,
  });
}
