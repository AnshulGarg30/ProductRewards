import 'package:flutter/material.dart';
import 'package:productreward/core/network/api_service.dart';
import 'package:productreward/presentation/themes/colors.dart';
import 'package:productreward/presentation/view/screens/rewardlist.dart';
import 'package:productreward/presentation/view/screens/product_list_page.dart';
import 'package:provider/provider.dart';
import '../../controllers/LoginController.dart';
import '../../controllers/UserProvider.dart';
import '../../controllers/rewards_list_provider.dart';
import 'ChangepasswordScreen.dart';
import 'HistoryPage.dart';
import 'LoginScreen.dart';
import 'RedeemRequest.dart';
import '../../../main.dart';
import 'WebViewScreen.dart'; // Ensure this includes your routeObserver

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasFetchedPoints = false;

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).loadUserData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }

    final userProvider = Provider.of<UserProvider>(context);
    final rewardsProvider = Provider.of<RewardsListProvider>(context, listen: false);

    if (!_hasFetchedPoints && userProvider.userData != null) {
      _hasFetchedPoints = true;
      rewardsProvider.fetchPoints(userProvider.userData!.id.toString(), userProvider, "didChangeDependencies");
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _fetchPoints();
  }

  void _fetchPoints() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final rewardsProvider = Provider.of<RewardsListProvider>(context, listen: false);

    if (mounted && userProvider.userData != null) {
      rewardsProvider.fetchPoints(userProvider.userData!.id.toString(), userProvider, "didPopNext");
    }
  }

  Future<void> _refreshHomeScreen() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final rewardsProvider = Provider.of<RewardsListProvider>(context, listen: false);

    await userProvider.loadUserData();

    if (userProvider.userData != null) {
      await rewardsProvider.fetchPoints(
        userProvider.userData!.id.toString(),
        userProvider,
        "pullToRefresh",
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final controller = Provider.of<LoginController>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColors.primary),
                currentAccountPicture: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    userProvider.userData?.image != null
                        ? '${userProvider.userData!.image}'
                        : 'https://i.pravatar.cc/300',
                  ),
                ),
                accountName: Text(userProvider.userData?.name ?? "Albert Florest"),
                accountEmail: Text(
                  userProvider.userData?.email ?? "",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ListTile(
                leading: Icon(Icons.redeem),
                title: Text("Reward Items"),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Rewardlist()));
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text("History"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HistoryPage(userID: userProvider.userData?.id),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.redeem),
                title: Text("Redeem Request"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RedeemRequest(userID: userProvider.userData?.id),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text("Change Password"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangepasswordScreen(userID: userProvider.userData?.id),
                    ),
                  );
                },
              ),
              buildWebItem(icon: Icons.privacy_tip, label: 'Privacy Policy', url: ApiService().privacypolicy),
              buildWebItem(icon: Icons.policy_outlined, label: 'Terms & Conditions', url: ApiService().termcondition),
              buildWebItem(icon: Icons.contact_mail, label: 'Contact Us', url: ApiService().contactus),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () async {
                  await controller.logout();
                  userProvider.clearUser();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                        (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('ArchGod', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshHomeScreen,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: ProductListPage(),
        ),
      ),
    );
  }

  Widget buildWebItem({required IconData icon, required String label, required String url}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WebViewScreen(url: url, title: label),
          ),
        );
      },
    );
  }

}
