import 'package:cartzilla/models/cart_model.dart';
import 'package:cartzilla/models/product_model.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartModel> _items = {};

  List<CartModel> get items => _items.values.toList();
  double get subtotal =>
      _items.values.fold(0, (sum, item) => sum + item.totalPrice);
  double get savings => 260.0;
  double get total => subtotal - savings;
  bool get isFreeDelivery => subtotal > 50;

  void addItem(ProductModel product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartModel(product: product);
    }
    notifyListeners();
  }

  void removeItem(int id) {
    _items.remove(id);
    notifyListeners();
  }

  void updateQuantity(int id, bool increase) {
    if (!_items.containsKey(id)) return;
    if (increase) {
      _items[id]!.quantity++;
    } else if (_items[id]!.quantity > 1) {
      _items[id]!.quantity--;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
