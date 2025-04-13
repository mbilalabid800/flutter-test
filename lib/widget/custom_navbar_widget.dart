import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  final int cartItemCount;

  const CustomNavBar({super.key, this.cartItemCount = 3});

  @override
  // ignore: library_private_types_in_public_api
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 236, 236, 236),
      elevation: 10,
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_outlined),
                _buildNavItem(1, Icons.shopping_cart_outlined),
                _buildNavItem(2, Icons.person_outline),
              ],
            ),
            Spacer(),
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
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Icon(
                icon,
                size: 28,
                color:
                    isSelected
                        ? Colors.black
                        : Colors.grey, // <=== Color switch here
              ),
              if (index == 1 && widget.cartItemCount > 0)
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
                      '${widget.cartItemCount}',
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
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
