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
  Map<String, dynamic> toMap() {
  return {
    'title': title,
    'author': author,
    'description': description,
    'price': price,
    'coverPath': coverPath,
    'pdfPath': pdfPath,
  };
}

factory Book.fromMap(Map<String, dynamic> map) {
  return Book(
    title: map['title'],
    author: map['author'],
    description: map['description'],
    price: map['price'],
    coverPath: map['coverPath'],
    pdfPath: map['pdfPath'],
  );
}
}
