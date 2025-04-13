// ignore_for_file: use_build_context_synchronously

import 'package:cartzilla/constants/app_colors.dart';
import 'package:cartzilla/providers/cart_provider.dart';
import 'package:cartzilla/providers/navbar_provider.dart';
import 'package:cartzilla/providers/product_provider.dart';
import 'package:cartzilla/responsive/device_dimensions.dart';
import 'package:cartzilla/widget/bread_crumb.dart';
import 'package:cartzilla/widget/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<CartProvider>().addListener(() {
      context.read<NavBarProvider>().updateCartItemCount(
        context.read<CartProvider>(),
      );
    });
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.020,
                ),
                Image.asset("assets/images/logo.png"),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.010,
                ),
                Breadcrumb(items: ["Home", "Shop"]),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.010,
                ),
                const Text(
                  "Shop",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.010,
                ),
                Row(
                  children: [
                    _buildDropdown("Most popular"),
                    const SizedBox(width: 10),
                    _buildDropdown("Category (4)"),
                    const Spacer(),
                    const Row(
                      children: [
                        Text(
                          "More",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.add, size: 16),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.020,
                ),
                Wrap(
                  spacing: 5,
                  children: [
                    _buildChip("Clothing"),
                    _buildChip("Electronics"),
                    _buildChip("Jewelry"),
                  ],
                ),
                const SizedBox(height: 20),
                Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    if (productProvider.isLoading) {
                      return SizedBox(
                        height: DeviceDimensions.screenHeight(context) * 0.5,
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        ),
                      );
                    } else if (productProvider.errorMessage.isNotEmpty) {
                      return Center(
                        child: Text('Error: ${productProvider.errorMessage}'),
                      );
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.55,
                            ),
                        itemCount: productProvider.products.length,
                        itemBuilder: (context, index) {
                          final product = productProvider.products[index];
                          return ProductWidget(product: product);
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 12),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down, size: 16),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.close, size: 16, color: Colors.black54),
          ),
          const SizedBox(width: 6),
          Text(label, style: GoogleFonts.inter(fontSize: 12)),
        ],
      ),
    );
  }
}
