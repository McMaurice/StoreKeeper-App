import 'package:drift/drift.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()(); //autoInc.sets it as pritbl
  TextColumn get name => text().named('name')();
  TextColumn get description => text().named('description')();
  IntColumn get quantity => integer().named('quantity')();
  IntColumn get price => integer().named('price')();
  TextColumn get imagePath => text().named('image_path')();
  TextColumn get status => text().named('status')();
}
