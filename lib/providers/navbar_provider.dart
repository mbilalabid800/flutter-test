import 'package:cartzilla/providers/cart_provider.dart';
import 'package:flutter/material.dart';

class NavBarProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int _cartItemCount = 0;

  int get selectedIndex => _selectedIndex;
  int get cartItemCount => _cartItemCount;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Update cartItemCount based on CartProvider's item count
  void updateCartItemCount(CartProvider cartProvider) {
    _cartItemCount = cartProvider.items.length;
    notifyListeners();
  }
}
