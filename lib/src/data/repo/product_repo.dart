
// @riverpod
// class ProductViewModel extends _$ProductViewModel {
//   @override
//   Future<List<Product>> build() async {
//     // Automatically fetch all products when the VM is initialized
//     return await ref.watch(productRepositoryProvider).getAll();
//   }

//   Future<void> refresh() async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(
//       () => ref.watch(productRepositoryProvider).getAll(),
//     );
//   }

//   Future<void> addProduct(ProductsCompanion entity) async {
//     final repo = ref.watch(productRepositoryProvider);
//     await repo.add(entity);
//     await refresh(); // update the UI after insert
//   }

//   Future<void> updateProduct(ProductsCompanion entity) async {
//     final repo = ref.watch(productRepositoryProvider);
//     await repo.update(entity);
//     await refresh(); // update UI
//   }

//   Future<void> deleteProduct(int id) async {
//     final repo = ref.watch(productRepositoryProvider);
//     await repo.remove(id);
//     await refresh(); // update UI
//   }
// }
