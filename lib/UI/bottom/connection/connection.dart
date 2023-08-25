import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_tete/UI/bottom/connection/all.dart';
import 'package:new_tete/UI/bottom/connection/my_users.dart';
import 'package:new_tete/UI/bottom/home/drawer.dart';
import 'package:new_tete/UI/util/utils.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Connections",
          style: GoogleFonts.aBeeZee(fontSize: 20),
        ),
        actions: [
          isSearching == true
              ? SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search_off),
                        contentPadding: const EdgeInsets.all(1),
                        border: OutlineInputBorder(
                            gapPadding: 2.0,
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Search user"),
                  ))
              : const SizedBox.shrink(),
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                });
              },
              icon: const Icon(Icons.search)),
          PopupMenuButton(
              child: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [const PopupMenuItem(value: 1, child: Text("No 1"))];
              })
        ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TabBar(
                physics: const BouncingScrollPhysics(),
                controller: tabController,
                labelColor: Colors.lightGreen,
                tabs: const [
                  Tab(
                    child: Text("All Users"),
                  ),
                  Tab(
                    child: Text("Connected Users"),
                  )
                ]),
            SizedBox(
              // color: Colors.grey,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                  controller: tabController,
                  children: const [AllUsers(), MyConnections()]),
            )
          ],
        ),
      ),
    );
  }
}
