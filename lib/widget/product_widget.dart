import 'package:cartzilla/constants/app_colors.dart';
import 'package:cartzilla/responsive/device_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:cartzilla/models/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: AppColors.screenBackground),
      child: SizedBox(
        height: 130, // ✅ Prevent overflow in GridView
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            SizedBox(
              height: 140,
              width: DeviceDimensions.screenWidth(context) * 0.40,
              child: Center(
                child: Image.network(product.image, fit: BoxFit.contain),
              ),
            ),
            SizedBox(height: DeviceDimensions.screenHeight(context) * 0.015),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${product.price}',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
            SizedBox(height: DeviceDimensions.screenHeight(context) * 0.010),
            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        'Add to cart',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200, // light grey background
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_outline_outlined,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
