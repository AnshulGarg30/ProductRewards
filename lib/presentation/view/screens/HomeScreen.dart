import 'package:flutter/material.dart';
import 'package:productreward/presentation/themes/colors.dart';
import 'package:productreward/presentation/view/screens/points_screen.dart';
import 'package:productreward/presentation/view/screens/product_list_page.dart';
import 'package:provider/provider.dart';
import '../../../core/network/api_service.dart';
import '../../controllers/LoginController.dart';
import '../../controllers/UserProvider.dart';
import '../../controllers/rewards_list_provider.dart';
import 'ChangepasswordScreen.dart';
import 'HistoryPage.dart';
import 'LoginScreen.dart';
import 'ProfileScreen.dart';
import 'RedeemRequest.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).loadUserData(); // uses AuthLocalDataSource
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RewardsListProvider>(context, listen: false).fetchRewards();
    });
  }

  bool _hasFetchedPoints = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final userProvider = Provider.of<UserProvider>(context);
    final rewardsProvider = Provider.of<RewardsListProvider>(context, listen: false);

    if (!_hasFetchedPoints && userProvider.userData != null) {
      _hasFetchedPoints = true;
      rewardsProvider.fetchPoints(userProvider.userData!.id.toString(), userProvider);
    }
  }


  final pages = [
    ProductListPage(),
    PointsScreen(),
    // ProfileScreen(),
  ];

  final titles = ['ArchGod', 'Rewards'/*, 'Profile'*/];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final controller = Provider.of<LoginController>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SingleChildScrollView(  // <-- Add this
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColors.primary),
                currentAccountPicture: CircleAvatar(radius: 50,backgroundImage: NetworkImage(
                  userProvider.userData?.image != null
                      ? '${userProvider.userData!.image}'
                      : 'https://i.pravatar.cc/300',
                ),),
                accountName: Text(userProvider.userData?.name ?? "Albert Florest",),
                accountEmail: Text(userProvider.userData?.email ?? "", style: TextStyle(color: Colors.grey)),
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text("History"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  HistoryPage(userID: userProvider.userData?.id,))
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.redeem),
                title: Text("Redeem Request"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) =>  RedeemRequest(userID: userProvider.userData?.id,))
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text("Change Password"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  ChangepasswordScreen(userID: userProvider.userData?.id)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () async{
                  await controller.logout();
                  userProvider.clearUser();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) =>  LoginScreen()),
                        (route) => false,
                  );
                },
              ),
              // Add more ListTiles here
            ],
          ),
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
          // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
