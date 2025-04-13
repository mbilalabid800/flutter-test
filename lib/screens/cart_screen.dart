import 'package:cartzilla/constants/app_colors.dart';
import 'package:cartzilla/providers/cart_provider.dart';
import 'package:cartzilla/responsive/device_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ValueNotifier<String> selected = ValueNotifier("Delivery");

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
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
                Text(
                  "Home > Shop > Cart",
                  style: GoogleFonts.inter(color: Colors.black, fontSize: 13),
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.010,
                ),
                Text(
                  "Shopping cart",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.020,
                ),
                // Delivery / Pickup Toggle
                Row(
                  children:
                      ["Delivery", "Pickup"].map((option) {
                        return Expanded(
                          child: ValueListenableBuilder(
                            valueListenable: selected,
                            builder:
                                (context, value, _) => GestureDetector(
                                  onTap: () => selected.value = option,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.screenBackground,
                                      border: Border.all(
                                        color:
                                            value == option
                                                ? Colors.black
                                                : Colors.grey.shade300,
                                        width: value == option ? 1.5 : 1.2,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          option == 'Delivery'
                                              ? 'assets/images/delivery.png'
                                              : 'assets/images/pickup.png',
                                          height: 50,
                                        ),
                                        SizedBox(
                                          height:
                                              DeviceDimensions.screenHeight(
                                                context,
                                              ) *
                                              0.010,
                                        ),
                                        Text(
                                          option,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              DeviceDimensions.screenHeight(
                                                context,
                                              ) *
                                              0.005,
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          "All products are available",
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          ),
                        );
                      }).toList(),
                ),

                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.030,
                ),
                // Cart Items
                ...cartProvider.items.map((cartItem) {
                  final product = cartItem.product;
                  final quantity = cartItem.quantity;

                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(product.image, width: 70, height: 70),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              product.title,
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: DeviceDimensions.screenHeight(context) * 0.020,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 38,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade400,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed:
                                        () => cartProvider.updateQuantity(
                                          product.id,
                                          false,
                                        ),
                                    icon: const Icon(Icons.remove),
                                    visualDensity: VisualDensity.compact,
                                    constraints: const BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    quantity.toString(),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed:
                                        () => cartProvider.updateQuantity(
                                          product.id,
                                          true,
                                        ),
                                    icon: const Icon(Icons.add),
                                    visualDensity: VisualDensity.compact,
                                    constraints: const BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "\$${cartItem.totalPrice.toStringAsFixed(2)}",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed:
                                () => cartProvider.removeItem(product.id),
                            iconSize: 18,
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                    ],
                  );
                }),

                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.010,
                ),
                InkWell(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => const MainScreen()),
                    // );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "Continue shopping",
                        style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.020,
                ),
                if (cartProvider.isFreeDelivery)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Congratulations 🎉 You have added more than \$50 to your cart. Delivery is free for you!",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.030,
                ),
                Center(
                  child: Text(
                    "Order summary",
                    style: GoogleFonts.inter(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.010,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subtotal (${cartProvider.items.length} items):",
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "\$${cartProvider.subtotal.toStringAsFixed(2)}",
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.010,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Saving:",
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "-\$${cartProvider.savings.toStringAsFixed(2)}",
                      style: GoogleFonts.inter(color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.010,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery:",
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      cartProvider.isFreeDelivery ? "Free" : "\$5",
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.010,
                ),
                const Divider(),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.010,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Estimated total:",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${cartProvider.total.toStringAsFixed(2)}",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.025,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Proceed to checkout",
                        style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 3),
                      Icon(Icons.chevron_right, size: 20),
                    ],
                  ),
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.020,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
