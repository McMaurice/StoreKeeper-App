import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storekepper_app/src/app/constants/color.dart';
import 'package:storekepper_app/src/app/utilities/formaters.dart';
import 'package:storekepper_app/src/domain/vm/product_screen_vm.dart';
import 'package:storekepper_app/src/models/product_model.dart';
import 'package:storekepper_app/src/ui/widgets/button.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteThis = ref.watch(productViewModelProvider);

    ref.listen<AsyncValue<void>>(productViewModelProvider, (prev, next) {
      next.whenOrNull(
        data: (_) => context.pop(), // Close screen after delete
        error: (err, _) => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error deleting product: $err'))),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
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
                  child: product.imagePath.startsWith('assets/')
                      ? Image.asset(
                          product.imagePath,
                          width: double.infinity,
                          height: 400,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          File(product.imagePath),
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
                      color: product.status == 'Limited'
                          ? Colors.red.withAlpha((0.5 * 100).toInt())
                          : Colors.green.withAlpha((0.5 * 100).toInt()),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      product.status,
                      style: TextStyle(
                        color: product.status == 'Limited'
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
              (product.description.isEmpty)
                  ? 'No description for this product.'
                  : product.description,
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
                      '${product.quantity} ${AppFormatter.pluralFormatter("Unit", count: product.quantity)} left',
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
                      '₦${AppFormatter.currency(product.price)}',
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
                SizedBox(
                  width: 120,
                  child: CustomButton(
                    title: 'Edit',
                    color: AppColors.primaryColor,
                    onPressed: () {
                      context.push(
                        '/product_form',
                        extra: {'isEditing': true, 'product': product},
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: CustomButton(
                    title: "Delete",
                    color: Colors.red,
                    onPressed: deleteThis.isLoading
                        ? null
                        : () => ref
                              .read(productViewModelProvider.notifier)
                              .deleteProduct(product),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
