class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final double price;
  final int pages;
  final String language;
  final String description;
  final bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.price,
    required this.pages,
    required this.language,
    required this.description,
    this.isFavorite = false,
  });

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? imageUrl,
    double? price,
    int? pages,
    String? language,
    String? description,
    bool? isFavorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      pages: pages ?? this.pages,
      language: language ?? this.language,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}