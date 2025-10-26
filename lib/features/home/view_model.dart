// import 'package:flutter/foundation.dart';

// class HomeViewModel extends ChangeNotifier {
//   final List<Map<String, dynamic>> _products = [
//     {
//       'image': 'assets/bag.png',
//       'name': 'Ventos Bag',
//       'quantity': 25,
//       'price': 5500,
//       'status': 'Limited',
//       'description': 'Durable leather bag with spacious compartments for daily use.',
//     },
//     {
//       'image': 'assets/cap.jpg',
//       'name': 'Bonfire Cap',
//       'quantity': 5,
//       'price': 150,
//       'status': 'InStock',
//       'description': 'Adjustable cotton cap with breathable fabric for outdoor wear.',
//     },
//     {
//       'image': 'assets/shirt.png',
//       'name': 'Skimmer Shirt',
//       'quantity': 10,
//       'price': 1200,
//       'status': 'Limited',
//       'description': 'Casual slim-fit shirt made from high-quality cotton blend.',
//     },
//     {
//       'image': 'assets/cap.jpg',
//       'name': 'Bonfire Cap',
//       'quantity': 5,
//       'price': 600,
//       'status': 'InStock',
//       'description': 'Comfortable street-style cap available in multiple colors.',
//     },
//     {
//       'image': 'assets/shirt.png',
//       'name': 'Skimmer Shirt',
//       'quantity': 10,
//       'price': 1200,
//       'status': 'InStock',
//       'description': 'Soft and breathable fabric ideal for everyday wear.',
//     },
//     {
//       'image': 'assets/cap.jpg',
//       'name': 'Bonfire Cap',
//       'quantity': 5,
//       'price': 150,
//       'status': 'InStock',
//       'description': 'Classic curved brim design perfect for casual outings.',
//     },
//     {
//       'image': 'assets/shirt.png',
//       'name': 'Skimmer Shirt',
//       'quantity': 10,
//       'price': 1200,
//       'status': 'Limited',
//       'description': 'Lightweight and stylish shirt for a smart casual look.',
//     },
//   ];

//   String _searchQuery = '';

//   List<Map<String, dynamic>> get products => List.unmodifiable(_products);

//   String get searchQuery => _searchQuery;

//   List<Map<String, dynamic>> get filteredProducts {
//     if (_searchQuery.isEmpty) return _products;
//     return _products
//         .where((item) =>
//             item['name'].toLowerCase().contains(_searchQuery.toLowerCase()))
//         .toList();
//   }

//   void updateSearch(String query) {
//     _searchQuery = query;
//     notifyListeners();
//   }
// }
