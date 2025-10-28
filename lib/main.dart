import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storekepper_app/src/domain/provider/product_provider.dart';
import 'package:storekepper_app/src/services/navigation/router.dart';
import 'package:storekepper_app/src/app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock orientation to portrait up
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'StoreKepper App',
      theme: AppTheme.lightTheme,
    );
  }
}

// List<Map<String, dynamic>> get filteredProducts {
//   if (searchQuery.isEmpty) return products;
//   return products
//       .where(
//         (item) =>
//             item['name'].toLowerCase().contains(searchQuery.toLowerCase()),
//       )
//       .toList();

class HomeScresen extends ConsumerStatefulWidget {
  const HomeScresen({super.key});

  @override
  ConsumerState<HomeScresen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScresen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search product...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Expanded(
            child: productsAsync.when(
              data: (products) {
                final filtered = products
                    .where(
                      (p) => p.name.toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      ),
                    )
                    .toList();
                if (filtered.isEmpty) {
                  return const Center(child: Text('No matching products'));
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final product = filtered[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(
                        '${product.quantity} pcs - ₦${product.price}',
                      ),
                      trailing: Text(product.status),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
