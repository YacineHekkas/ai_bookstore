import 'package:ai_bookstore/controller/collection_provider.dart';
import 'package:ai_bookstore/view/screens/chat_screen.dart';
import 'package:ai_bookstore/view/screens/collection_screen.dart';
import 'package:ai_bookstore/view/screens/favorite_screen.dart';
import 'package:ai_bookstore/view/screens/profil_screen.dart';
import 'package:ai_bookstore/view/screens/search_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'home_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {


  int _selectedIndex = 0;

  // List of pages to show in bottom navigation
  final List<Widget> _pages = [
    const HomeScreen(),
    const ChatScreen(),
    const CollectionsScreen(),
    const FavoritesScreen(),
    const ProfileSettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex, // Set the current index
        onTap: _onItemTapped, // Handle item tap
        backgroundColor: Colors.transparent, // Background color of the bar
        color: Color(0xffCE7B81), // Color of the bar
        buttonBackgroundColor: Color(0xffCE7B81), // Background color of the selected button
        height: 60, // Height of the navigation bar
        animationDuration: const Duration(milliseconds: 300), // Animation duration
        items: <Widget>[
          SvgPicture.asset('assets/icons/home.svg', width: 24, height: 24, color: Colors.white),
          SvgPicture.asset('assets/icons/aibot.svg', width: 24, height: 24, color: Colors.white),
          SvgPicture.asset('assets/icons/apps.svg', width: 24, height: 24, color: Colors.white),
          SvgPicture.asset('assets/icons/vector.svg', width: 24, height: 24, color: Colors.white),
          SvgPicture.asset('assets/icons/profile.svg', width: 24, height: 24, color: Colors.white),
        ],
      ),
    );
  }
}