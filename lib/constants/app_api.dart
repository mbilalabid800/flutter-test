class AppApi {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Get Api
  static const String getProducts = '$baseUrl/products';
  static const String getCarts = '$baseUrl/carts';
  static String getCartsByUser(String userId) => '$baseUrl/carts/user/$userId';

  // Post Api
  static const String addToCart = '$baseUrl/carts';

  // Delete Api
  static String deleteCart(String cartId) => '$baseUrl/carts/$cartId';
}
