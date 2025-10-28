import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:storekepper_app/app/constants/color.dart';
import 'package:storekepper_app/app/utilities/formaters.dart';
import 'package:storekepper_app/domain/provider/product_provider.dart';
import 'package:storekepper_app/models/product_model.dart';
import 'package:storekepper_app/ui/widgets/button.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key, required this.product});

  final ProductModel product;

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  void onDelete() async {
    final notifier = ref.read(productNotifierProvider.notifier);
    await notifier.deleteProduct(widget.product.id!);
    if (!mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
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
                  child: Image.asset(
                    widget.product.imagePath,
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: widget.product.status == 'InStock'
                        ? Colors.green.withAlpha(40)
                        : Colors.red.withAlpha(40),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.product.status,
                    style: TextStyle(
                      color: widget.product.status == 'InStock'
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Product name
            Text(
              widget.product.description,
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
                      '${widget.product.quantity}',
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
