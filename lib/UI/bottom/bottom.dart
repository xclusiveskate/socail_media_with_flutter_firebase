import 'package:flutter/material.dart';
import 'package:new_tete/UI/bottom/chats/chat.dart';
import 'package:new_tete/UI/bottom/connection/connection.dart';
import 'package:new_tete/UI/bottom/home/drawer.dart';
import 'package:new_tete/UI/bottom/home/home.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  List pages = [const HomePage(), const ConnectionPage(), const ChatsPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),

      drawer: const MyDrawer(),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.greenAccent,
          unselectedItemColor: Colors.lightGreen,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: "Connections",
                icon: Icon(Icons.connect_without_contact)),
            BottomNavigationBarItem(label: "Chats", icon: Icon(Icons.chat)),
          ]),
    );
  }
}
