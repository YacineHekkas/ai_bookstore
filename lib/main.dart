import 'package:ai_bookstore/controller/collection_provider.dart';
import 'package:ai_bookstore/controller/favorite_provider.dart';
import 'package:ai_bookstore/view/screens/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/book_provider.dart';
import 'controller/chat_provider.dart';
import 'controller/search_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BooksProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()), // Chat management
        ChangeNotifierProvider(create: (_) => SearchProvider()), // Chat management
        ChangeNotifierProvider(create: (_) => FavoritesProvider()), // Chat management
        ChangeNotifierProvider(create: (_) => CollectionsProvider()), // Chat management

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home:  MainNavigation(),
      ),
    );
  }
}