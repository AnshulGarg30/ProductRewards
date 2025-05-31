import 'package:flutter/material.dart';
import 'package:productreward/presentation/themes/colors.dart';
import 'package:productreward/presentation/view/screens/points_screen.dart';
import 'package:productreward/presentation/view/screens/product_list_page.dart';
import 'ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final pages = [
    ProductListPage(),
    PointsScreen(),
    ProfileScreen(),
  ];

  final titles = ['ArchGod', 'Rewards', 'Profile'];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Text("Drawer Header", style: TextStyle(color: Colors.white)),
            ),
            ListTile(leading: Icon(Icons.logout), title: Text("Logout")),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'ArchGod' : titles[_currentIndex]
          , style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Product'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Rewards'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
