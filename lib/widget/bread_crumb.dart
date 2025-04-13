import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Breadcrumb extends StatelessWidget {
  final List<String> items;

  const Breadcrumb({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(items.length, (index) {
        final isLast = index == items.length - 1;
        return Text(
          '${items[index]}${!isLast ? ' > ' : ''}',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: isLast ? Colors.grey : Colors.black,
          ),
        );
      }),
    );
  }
}
