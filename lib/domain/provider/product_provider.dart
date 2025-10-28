import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:storekepper_app/data/local/db/database.dart';
import 'package:storekepper_app/models/product_model.dart';
import 'package:drift/drift.dart';

// --- MAPPERS SAMPLE RETURNED FROM DATABASE ---
extension ProductMapper on Product {
  ProductModel toModel() => ProductModel(
    id: id,
    name: name,
    description: description,
    quantity: quantity,
    price: price,
    imagePath: imagePath,
    status: status,
  );
}

// --- MAPPERS SAMPLE GOING TO DATABASE ---
extension ProductModelMapper on ProductModel {
  ProductsCompanion toCompanion({bool insert = false}) {
    return ProductsCompanion(
      id: insert || id == null ? const Value.absent() : Value(id!),
      name: Value(name),
      description: Value(description),
      quantity: Value(quantity),
      price: Value(price),
      imagePath: Value(imagePath),
      status: Value(status),
    );
  }
}

// --- SAMPLE DATA SEEDED IN DATABASE ON TESTING ---
// final sampleProducts = [
//   ProductModel(
//     id: 1,
//     name: 'Ventos Bag',
//     description:
//         'Durable leather bag with spacious compartments for daily use.',
//     quantity: 25,
//     price: 5500,
//     imagePath: 'assets/bag.png',
//     status: 'InStock',
//   ),
//   ProductModel(
//     id: 2,
//     name: 'Bonfire Cap',
//     description:
//         'Adjustable cotton cap with breathable fabric for outdoor wear.',
//     quantity: 5,
//     price: 150,
//     imagePath: 'assets/cap.jpg',
//     status: 'InStock',
//   ),
//   ProductModel(
//     id: 3,
//     name: 'Skimmer Shirt',
//     description: 'Casual slim-fit shirt made from high-quality cotton blend.',
//     quantity: 10,
//     price: 1200,
//     imagePath: 'assets/shirt.png',
//     status: 'Limited',
//   ),
// ];

//---- PROVIDERS ---- (SUPLYS THE DATABASE)

final dbProvider = Provider<AppDataBase>((ref) {
  final db = AppDataBase();
  ref.onDispose(() => db.close());
  return db;
});

//-----LISTENS TO CHANGES IN THE DATABASE AND PROVIDES TO SCREEN ASAP
final productsProvider = StreamProvider<List<ProductModel>>((ref) {
  final db = ref.watch(dbProvider);
  return db
      .select(db.products)
      .watch()
      .map((rows) => rows.map((e) => e.toModel()).toList());
});

//---- NOTIFIERS ---- (MODIFIES THE DATABASE)
class ProductNotifier extends StateNotifier<AsyncValue<List<ProductModel>>> {
  ProductNotifier(this.ref) : super(const AsyncValue.loading()) {
    _init();
  }

  final Ref ref;

  Future<void> _init() async {
    final db = ref.read(dbProvider);
    final products = await db.getProducts();

    // if (products.isEmpty) {
    //   for (final model in sampleProducts) {
    //     await db.insertProduct(model.toCompanion());
    //   }
    //   final seeded = await db.getProducts();
    //   state = AsyncValue.data(seeded.map((e) => e.toModel()).toList());
    // } else {
    state = AsyncValue.data(products.map((e) => e.toModel()).toList());
    // }
  }

  Future<void> addProduct(ProductModel model) async {
    final db = ref.read(dbProvider);
    await db.insertProduct(model.toCompanion());
  }

  Future<void> updateProduct(ProductModel model) async {
    final db = ref.read(dbProvider);
    await db.updateProduct(model.toCompanion());
  }

  Future<void> deleteProduct(int id) async {
    final db = ref.read(dbProvider);
    await db.deleteProduct(id);
  }
}

//--- CONNECTOR TO SCREENS THAT MODIFIES DATA----
final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, AsyncValue<List<ProductModel>>>(
      (ref) => ProductNotifier(ref),
    );
