import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:storekepper_app/src/data/local/entity/entity.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File('${dbFolder.path}/storeKepper.sqlite');

   // Delete old database file if you alter the entities
    // if (await file.exists()) {
    //   await file.delete();
    //   print('Old database deleted, creating new one.');
    // }

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Products])
class AppDataBase extends _$AppDataBase {
  AppDataBase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Get the Product List
  Future<List<Product>> getProducts() async {
    return await select(products).get();
  }

  // Get just a product
  Future<Product> getProduct(int id) async {
    return await (select(
      products,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  //Update a product
  Future<bool> updateProduct(ProductsCompanion entity) async {
    return await update(products).replace(entity);
  }

  //Add a product
  Future<int> insertProduct(ProductsCompanion entity) async {
    return await into(products).insert(entity);
  }

  //Remove a product
  Future<int> deleteProduct(int id) async {
    return await (delete(products)..where((tbl) => tbl.id.equals(id))).go();
  }
}
