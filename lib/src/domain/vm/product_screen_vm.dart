import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storekepper_app/src/app/utilities/image_helper.dart';
import 'package:storekepper_app/src/domain/provider/product_provider.dart';
import 'package:storekepper_app/src/models/product_model.dart';

class ProductViewModel extends StateNotifier<AsyncValue<void>> {
  ProductViewModel(this._ref) : super(const AsyncData(null));

  final Ref _ref;

  Future<void> deleteProduct(ProductModel product) async {
    state = const AsyncLoading();

    try {
      // Delete image if exists
      await ImageHelper().deleteImage(product.imagePath);

      // Delete product from DB
      final notifier = _ref.read(productNotifierProvider.notifier);
      await notifier.deleteProduct(product.id!);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// PROVIDER
final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, AsyncValue<void>>(
      (ref) => ProductViewModel(ref),
    );
