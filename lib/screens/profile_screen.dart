import 'package:flutter/material.dart';

import '../widgets/app_bottom_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Nextgen Shop',
        isHome: true,
        onCartTap: () {
          Navigator.of(context).pushReplacementNamed('/cart');
        },
      ),
      drawer: AppDrawer(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 80,
          top: 20,
        ),
        margin: const EdgeInsets.only(top: 70),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Center(child: Text('Profile')),
      ),
      bottomNavigationBar: AppBottomBar(currentIndex: 2),
    );
  }
}
