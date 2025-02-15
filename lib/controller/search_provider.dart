import 'package:flutter/material.dart';

import '../model/book.dart';
import '../model/search_history.dart';

class SearchProvider with ChangeNotifier {
  List<SearchHistory> _recentSearches = [];
  List<Book> _recommendedBooks = [];
  List<Book> _searchResults = [];
  bool _isLoading = false;
  String _searchQuery = '';
  bool _hasSearched = false;

  List<SearchHistory> get recentSearches => _recentSearches;
  List<Book> get recommendedBooks => _recommendedBooks;
  List<Book> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  bool get hasSearched => _hasSearched;

  // Initialize with dummy data
  SearchProvider() {
    _loadInitialData();
  }

  void _loadInitialData() {
    // Dummy recent searches
    _recentSearches = [
      SearchHistory(query: 'The Morac Book 1', timestamp: DateTime.now()),
      SearchHistory(query: 'Elvenwood Forest', timestamp: DateTime.now()),
      SearchHistory(query: 'Stillwell Long Island', timestamp: DateTime.now()),
    ];

    // Dummy recommended books
    _recommendedBooks = [
      Book(
        id: '1',
        title: 'Stillwell Long Island',
        author: 'Adam Smith',
        imageUrl: 'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-V9s1rC3N4MrVM5MNDngnWtJ4dPbVMo.png',
        price: 120.00,
        pages: 2,
        language: '',
        description: '',
      ),
      Book(
        id: '2',
        title: 'Warmage Book 2',
        author: 'Terry Mancour',
        imageUrl: 'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-V9s1rC3N4MrVM5MNDngnWtJ4dPbVMo.png',
        price: 60.00,
        pages: 0,
        language: '',
        description: '',
      ),
    ];
    notifyListeners();
  }

  // Add a search to history
  Future<void> addSearch(String query) async {
    if (query.isEmpty) return;

    // Remove if exists to avoid duplicates
    _recentSearches.removeWhere((item) => item.query == query);

    // Add to beginning of list
    _recentSearches.insert(
      0,
      SearchHistory(query: query, timestamp: DateTime.now()),
    );

    // Keep only last 10 searches
    if (_recentSearches.length > 10) {
      _recentSearches = _recentSearches.sublist(0, 10);
    }

    notifyListeners();
    // TODO: Implement API call to save search history
  }

  // Remove a search from history
  Future<void> removeSearch(String query) async {
    _recentSearches.removeWhere((item) => item.query == query);
    notifyListeners();
    // TODO: Implement API call to remove search from history
  }

  // Search books
  Future<void> searchBooks(String query) async {
    _searchQuery = query;
    _isLoading = true;
    _hasSearched = true;
    notifyListeners();

    try {
      // TODO: Implement actual API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // Simulate search results (replace this with actual API results)
      _searchResults = [
        Book(
          id: '3',
          title: 'Search Result 1',
          author: 'Author 1',
          imageUrl: 'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-V9s1rC3N4MrVM5MNDngnWtJ4dPbVMo.png',
          price: 90.00,
          pages: 300,
          language: 'English',
          description: 'A book about searching',
        ),
        Book(
          id: '4',
          title: 'Search Result 2',
          author: 'Author 2',
          imageUrl: 'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-V9s1rC3N4MrVM5MNDngnWtJ4dPbVMo.png',
          price: 75.00,
          pages: 250,
          language: 'English',
          description: 'Another book about searching',
        ),
      ];

      // Add to recent searches
      await addSearch(query);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Load recommended books
  Future<void> loadRecommendedBooks() async {
    _isLoading = true;
    notifyListeners();

    try {
      // TODO: Implement actual API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // Dummy data already loaded in constructor

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Clear search results and reset search state
  void clearSearchResults() {
    _searchResults.clear();
    _hasSearched = false;
    _searchQuery = '';
    notifyListeners();
  }
}