import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/book.dart';

class DataService {
  static const String baseUrl = "https:/192.168.40.70/";
  static const String authToken = "your-hardcoded-auth-token"; // Hardcoded Auth Token

  // Fetch recommendations
  Future<List<Book>> fetchRecommendations() async {
    final response = await http.get(
      Uri.parse("$baseUrl/books/recommendation"),
      headers: {
        "Authorization": "Token 4976edc82ba713ddad4214efb4c033ce0bcc080c",
        "Content-Type": "application/json",
      },

    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load recommendations');
    }
  }

  // Fetch books for "Continue Reading" and general display
  Future<List<Book>> fetchBooks({String? category}) async {
    final response = await http.get(
        Uri.parse("$baseUrl/books/landing"),
        headers: {
          "Authorization": "Token 4976edc82ba713ddad4214efb4c033ce0bcc080c",
          "Content-Type": "application/json",
        },


    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  // Search books by query
  Future<List<Book>> searchBooks(String query) async {
    final response = await http.get(
      Uri.parse("$baseUrl/search?query=$query"),
      headers: {
        "Authorization": "Token $authToken",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception('Failed to search books');
    }
  }
}
