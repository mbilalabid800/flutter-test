import 'package:cartzilla/providers/navbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavBarProvider>(context);
    final selectedIndex = navBarProvider.selectedIndex;
    final cartItemCount = navBarProvider.cartItemCount;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BottomAppBar(
        color: const Color.fromARGB(255, 236, 236, 236),
        elevation: 10,
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(context, 0, Icons.home_outlined, selectedIndex),
                  _buildNavItem(
                    context,
                    1,
                    Icons.shopping_cart_outlined,
                    selectedIndex,
                    cartItemCount,
                  ),
                  _buildNavItem(
                    context,
                    2,
                    Icons.person_outline,
                    selectedIndex,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: 80,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFB9C0C9),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    int selectedIndex, [
    int cartItemCount = 0,
  ]) {
    bool isSelected = selectedIndex == index;

    return InkWell(
      onTap: () {
        final navBarProvider = Provider.of<NavBarProvider>(
          context,
          listen: false,
        );
        navBarProvider.setSelectedIndex(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Icon(
                icon,
                size: 28,
                color: isSelected ? Colors.black : Colors.grey,
              ),
              if (index == 1 && cartItemCount > 0)
                Positioned(
                  right: 5,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (isSelected)
            Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
