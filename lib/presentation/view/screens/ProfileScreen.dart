import 'package:flutter/material.dart';
import 'package:productreward/presentation/themes/colors.dart';
import 'package:productreward/presentation/view/screens/NotificationScreen.dart';
import 'package:productreward/presentation/view/screens/forgot_password_screen.dart';
import 'package:provider/provider.dart';
import '../../controllers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
        child: Column(
          children: [
            // const SizedBox(height: 20),
            // const Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(radius: 50, backgroundImage: NetworkImage(provider.user!.profileImageUrl)),
                Container(
                  decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  padding: const EdgeInsets.all(5),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(provider.user!.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(provider.user!.role, style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            // buildProfileOption(Icons.person, 'Edit Profile'),
            buildProfileOption(Icons.notifications, 'Notification', context),
            // buildProfileOption(Icons.location_on, 'Shipping Address'),
            buildProfileOption(Icons.lock, 'Change Password', context),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Colors.white,),
                label: const Text('Sign Out', style: TextStyle(color: Colors.white),),
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

  Widget buildProfileOption(IconData icon, String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          if(title == 'Change Password') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  ForgotPasswordScreen()),
            );
          }else if(title == 'Notification') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  NotificationScreen()),
            );
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
