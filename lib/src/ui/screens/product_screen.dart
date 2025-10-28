import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storekepper_app/src/app/constants/color.dart';
import 'package:storekepper_app/src/app/utilities/formaters.dart';
import 'package:storekepper_app/src/app/utilities/image_helper.dart';
import 'package:storekepper_app/src/domain/provider/product_provider.dart';
import 'package:storekepper_app/src/models/product_model.dart';
import 'package:storekepper_app/src/ui/widgets/button.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key, required this.product});

  final ProductModel product;

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  void onDelete() async {
    await ImageHelper().deleteImage(widget.product.imagePath);
    final notifier = ref.read(productNotifierProvider.notifier);
    await notifier.deleteProduct(widget.product.id!);
    if (!mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.exo2().fontFamily,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade100,

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.product.imagePath.startsWith('assets/')
                      ? Image.asset(
                          widget.product.imagePath,
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          File(widget.product.imagePath),
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.fill,
                        ),
                ),
                Positioned(
                  top: 3,
                  left: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: widget.product.status == 'Limited'
                          ? Colors.red.withAlpha((0.5 * 100).toInt())
                          : Colors.green.withAlpha((0.5 * 100).toInt()),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.product.status,
                      style: TextStyle(
                        color: widget.product.status == 'Limited'
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Product name
            Text(
              (widget.product.description.isEmpty)
                  ? 'No description for this product.'
                  : widget.product.description,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            // Quantity and Price info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      'Quantity',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${widget.product.quantity} ${AppFormatter.pluralFormatter("Unit", count: widget.product.quantity)} left',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Price',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '₦${AppFormatter.currency(widget.product.price)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  title: 'Edit',
                  color: AppColors.primaryColor,
                  onPressed: () {
                    context.push(
                      '/product_form',
                      extra: {'isEditing': true, 'product': widget.product},
                    );
                  },
                ),
                CustomButton(
                  title: "Delete",
                  color: Colors.red,
                  onPressed: () => onDelete(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
