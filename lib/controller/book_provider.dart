import 'package:flutter/material.dart';
import '../model/book.dart';

class BooksProvider with ChangeNotifier {
  final List<Book> _books = [
    Book(
      id: '1',
      title: 'Stillwell Long Island',
      author: 'Adam Smith',
      imageUrl: "assets/images/img_1.png",
      price: 120.00,
      pages: 316,
      language: 'English',
      description: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\'...',
    ),
    Book(
      id: '2',
      title: 'The Ottoman History',
      author: 'Hannibal Adofo',
      imageUrl: "assets/images/img_2.png",
      price: 99.00,
      pages: 250,
      language: 'English',
      description: 'A comprehensive history of the Ottoman Empire...',
    ),
    // Add more books as needed
  ];

  List<Book> get books => [..._books];

  List<Book> get favoriteBooks => _books.where((book) => book.isFavorite).toList();

  Book findById(String id) {
    return _books.firstWhere((book) => book.id == id);
  }

  void toggleFavorite(String bookId) {
    final bookIndex = _books.indexWhere((book) => book.id == bookId);
    if (bookIndex >= 0) {
      _books[bookIndex] = _books[bookIndex].copyWith(
        isFavorite: !_books[bookIndex].isFavorite,
      );
      notifyListeners();
    }
  }
}