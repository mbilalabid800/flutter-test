import 'package:cartzilla/constants/app_api.dart';
import 'package:cartzilla/models/product_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  // Fetch products from API using Dio
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await _dio.get(AppApi.getProducts);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map((data) => ProductModel.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle Dio errors (e.g., network issues, timeout, etc.)
      throw Exception('Failed to load products: ${e.message}');
    } catch (e) {
      // Handle other types of errors
      throw Exception('Failed to load products: $e');
    }
  }
}
