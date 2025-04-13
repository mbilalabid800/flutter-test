import 'package:cartzilla/providers/navbar_provider.dart';
import 'package:cartzilla/screens/user_profile_screen.dart';
import 'package:cartzilla/widget/custom_navbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:cartzilla/screens/cart_screen.dart';
import 'package:cartzilla/screens/home_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavBarProvider>(context);
    final selectedIndex = navBarProvider.selectedIndex;

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [HomeScreen(), CartScreen(), UserProfileScreen()],
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
