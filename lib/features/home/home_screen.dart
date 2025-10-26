import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storekepper_app/app/theme/color.dart';
import 'package:storekepper_app/core/widgets/search_bar.dart';

// Home screen that lists products
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample list of products
  List<Map<String, dynamic>> products = [
    {
      'image': 'assets/bag.png',
      'name': 'Ventos Bag',
      'quantity': 25,
      'price': 5500,
      'status': 'Limited',
      'description':
          'Durable leather bag with spacious compartments for daily use.',
    },
    {
      'image': 'assets/cap.jpg',
      'name': 'Bonfire Cap',
      'quantity': 5,
      'price': 150,
      'status': 'InStock',
      'description':
          'Adjustable cotton cap with breathable fabric for outdoor wear.',
    },
    {
      'image': 'assets/shirt.png',
      'name': 'Skimmer Shirt',
      'quantity': 10,
      'price': 1200,
      'status': 'Limited',
      'description':
          'Casual slim-fit shirt made from high-quality cotton blend.',
    },
    {
      'image': 'assets/cap.jpg',
      'name': 'Bonfire Cap',
      'quantity': 5,
      'price': 600,
      'status': 'InStock',
      'description':
          'Comfortable street-style cap available in multiple colors.',
    },
    {
      'image': 'assets/shirt.png',
      'name': 'Skimmer Shirt',
      'quantity': 10,
      'price': 1200,
      'status': 'InStock',
      'description': 'Soft and breathable fabric ideal for everyday wear.',
    },
    {
      'image': 'assets/cap.jpg',
      'name': 'Bonfire Cap',
      'quantity': 5,
      'price': 150,
      'status': 'InStock',
      'description': 'Classic curved brim design perfect for casual outings.',
    },
    {
      'image': 'assets/shirt.png',
      'name': 'Skimmer Shirt',
      'quantity': 10,
      'price': 1200,
      'status': 'Limited',
      'description': 'Lightweight and stylish shirt for a smart casual look.',
    },
  ];

  // Filter products by search text
  String searchQuery = '';
  List<Map<String, dynamic>> get filteredProducts {
    if (searchQuery.isEmpty) return products;
    return products
        .where(
          (item) =>
              item['name'].toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('StoreKepper', style: TextStyle(color: Colors.white)),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 40,
              width: 240, // Adjust width to fit AppBar
              child: CustomSearchBar(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () => context.push('/product_form', extra: {'isEditing': false}),
        child: const Icon(Icons.library_add, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          hitTestBehavior: HitTestBehavior.deferToChild,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Inventory',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${filteredProducts.length} Products Available',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // List of Product Cards
                Column(
                  children: filteredProducts.map((product) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                (0.5 * 150).toInt(),
                              ),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        // CARD PRODECT DETAILS
                        child: GestureDetector(
                          onTap: () => context.push('/product', extra: product),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      product['image'],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: -1,
                                    left: 0,
                                    child: Text(
                                      product['status'],
                                      style: TextStyle(
                                        color: product['status'] == 'Limited'
                                            ? Colors.red
                                            : Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Product image on left
                              const SizedBox(width: 16),
                              // Product details on right
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product['name'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              'Quantity: ${product['quantity']}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              '₦${product['price']}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(Icons.arrow_forward_ios),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
