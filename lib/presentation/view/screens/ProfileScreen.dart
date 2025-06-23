import 'package:flutter/material.dart';
import 'package:productreward/presentation/themes/colors.dart';
import 'package:productreward/presentation/view/screens/LoginScreen.dart';
import 'package:productreward/presentation/view/screens/NotificationScreen.dart';
import 'package:provider/provider.dart';
import '../../controllers/LoginController.dart';
import '../../controllers/UserProvider.dart';
import 'ChangepasswordScreen.dart';

class ProfileScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final controller = Provider.of<LoginController>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // const SizedBox(height: 20),
            // const Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(radius: 50,backgroundImage: NetworkImage(
                  userProvider.userData?.image != null
                      ? '${userProvider.userData!.image}'
                      : 'https://i.pravatar.cc/300',
                ),),
                Container(
                  decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(5),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(userProvider.userData?.name ?? "Albert Florest", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(userProvider.userData?.email ?? "", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            // buildProfileOption(Icons.person, 'Edit Profile'),
            // buildProfileOption(Icons.notifications, 'Notification', context, 0),
            // buildProfileOption(Icons.notifications, 'Edit Profile', context, 0),
            // buildProfileOption(Icons.location_on, 'Shipping Address'),
            buildProfileOption(Icons.lock, 'Change Password', context, userProvider.userData?.id),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () async{
                  await controller.logout();
                  userProvider.clearUser();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) =>  LoginScreen()),
                        (route) => false,
                  );

                },
                icon: const Icon(Icons.logout, color: Colors.white,),
                label: const Text('LogOut', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildProfileOption(IconData icon, String title, BuildContext context, String? userid) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          if(title == 'Change Password') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  ChangepasswordScreen(userID: userid,)),
            );
          }else if(title == 'Notification') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  NotificationScreen()),
            );
          }else if(title == 'Edit Profile') {
            // Navigator.push(
            //   context,
              // MaterialPageRoute(builder: (_) =>  EditProfile()),
            // );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.primary_shade, shape: BoxShape.circle),
                child: Icon(icon, color: AppColors.primary),
              ),
              const SizedBox(width: 20),
              Expanded(child: Text(title, style: TextStyle(fontSize: 16))),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
