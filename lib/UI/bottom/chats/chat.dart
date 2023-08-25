import 'package:flutter/material.dart';
import 'package:new_tete/UI/bottom/home/drawer.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 35,
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(6),
                  hintText: "Search direct messages",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      drawer: const MyDrawer(),
      body: const Center(
        child: Text("This is chat page"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {},
        child: const Icon(
          Icons.chat_rounded,
          size: 28,
        ),
      ),
    );
  }
}
