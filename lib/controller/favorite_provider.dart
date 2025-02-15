import 'package:flutter/material.dart';
import '../model/book.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Book> _favorites = [
    // Dummy data
    Book(
      id: '1',
      title: 'Stillwell Long Island',
      author: 'Adam Smith',
      imageUrl: 'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-7u6a0hQd11rb2mpiKMRnbVcXCI2gN2.png',
      price: 120.00,
      pages: 222, language: 'English', description: '',
    ),
    Book(
      id: '2',
      title: 'Elvenwood Forest',
      author: 'Christina Henry',
      imageUrl: 'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-7u6a0hQd11rb2mpiKMRnbVcXCI2gN2.png',
      price: 75.00,
      pages: 222, language: 'English', description: '',    ),
  ];

  List<Book> get favorites => [..._favorites];

  bool isFavorite(String bookId) {
    return _favorites.any((book) => book.id == bookId);
  }

  void toggleFavorite(Book book) {
    final isExist = _favorites.any((b) => b.id == book.id);
    if (isExist) {
      _favorites.removeWhere((b) => b.id == book.id);
    } else {
      _favorites.add(book);
    }
    notifyListeners();
    // TODO: Implement API call to update favorites
  }

  void removeFavorite(String bookId) {
    _favorites.removeWhere((book) => book.id == bookId);
    notifyListeners();
    // TODO: Implement API call to remove from favorites
  }
}