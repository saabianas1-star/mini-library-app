class Book {
  final String title;
  final String author;
  final String description;
  final double price;
  final String? coverPath;
  final String pdfPath;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.price,
    this.coverPath,
    required this.pdfPath,
  });
}
