import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storekepper_app/app/theme/color.dart';
import 'package:storekepper_app/core/widgets/button.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
    required this.product,
    // required this.onDelete,
    // required this.onEdit,
  });

  // Product data passed from HomeScreen
  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    // Safely extract product details with default values
    final String name = product['name'] ?? 'Unnamed Product';
    final String image = product['image'] ?? 'assets/placeholder.png';
    final int quantity = product['quantity'] ?? 0;
    final int price = product['price'] ?? 0;
    final String status = product['status'] ?? 'Unknown';
    final String description = product['description'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
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
                    image,
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
                    color: status == 'InStock'
                        ? Colors.green.withAlpha(40)
                        : Colors.red.withAlpha(40),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: status == 'InStock' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Product name
            Text(
              description,
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
                      '$quantity',
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
                      '₦$price',
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
                customButton('Edit', AppColors.primaryColor, Icons.edit, () {
                  context.push(
                    '/product_form',
                    extra: {'isEditing': true, 'product': product},
                  );
                }),
                customButton('Delete', Colors.red, Icons.delete, () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
