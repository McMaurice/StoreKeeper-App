import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storekepper_app/src/domain/provider/product_provider.dart';
import 'package:storekepper_app/src/models/product_model.dart';

final homeViewModelProvider = ChangeNotifierProvider.autoDispose<HomeViewModel>(
  (ref) {
    return HomeViewModel(ref);
  },
);

class HomeViewModel extends ChangeNotifier {
  final Ref ref;
  HomeViewModel(this.ref);

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  // Watch the product provider directly
  AsyncValue<List<ProductModel>> get products => ref.watch(productsProvider);

  // Update search query
  void updateSearch(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  // Filter logic
  List<ProductModel> filteredProducts(List<ProductModel> products) {
    if (_searchQuery.isEmpty) return products;
    return products
        .where((p) => p.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }
}
