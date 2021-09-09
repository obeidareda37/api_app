import 'dart:io';

import 'package:api_app/model/single_product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper databaseHelper = DatabaseHelper._();
  static final String dbaseName = 'products.db';
  static final String favoriteTableName = 'favorite';
  static final String favoriteIdColumnName = 'id';
  static final String favoriteTitleColumnName = 'title';
  static final String favoritePriceColumnName = 'price';
  static final String favoriteDescriptionColumnName = 'description';
  static final String favoriteCategoryColumnName = 'category';
  static final String favoriteImageColumnName = 'image';

  static final String cartTableName = 'cart';
  static final String cartIdColumnName = 'id';
  static final String cartTitleColumnName = 'title';
  static final String cartPriceColumnName = 'price';
  static final String cartDescriptionColumnName = 'description';
  static final String cartCategoryColumnName = 'category';
  static final String cartImageColumnName = 'image';

  Database database;

  initDatabase() async {
    database = await getDatabaseConnection();
  }

  Future<Database> getDatabaseConnection() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/$dbaseName';
    Database database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''CREATE TABLE $favoriteTableName 
          ($favoriteIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
           $favoriteTitleColumnName TEXT, $favoritePriceColumnName REAL, $favoriteImageColumnName TEXT)''');
      db.execute('''CREATE TABLE $cartTableName 
          ($cartIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
           $cartTitleColumnName TEXT, $cartPriceColumnName REAL, $cartImageColumnName TEXT)''');
     }, onOpen: (database) {
      print('the database has been opened');
    });
    return database;
  }

  insertFavorite(SingleProductModel product) async {
    int rowNum = await database.insert(favoriteTableName, product.toMap());
    print(rowNum);
  }

  Future<List<SingleProductModel>> getAllProducts() async {
    List<Map<String, Object>> results = await database.query(favoriteTableName);
    List<SingleProductModel> product = results.map((e) {
      return SingleProductModel.fromMap(e);
    }).toList();
    return product;
  }

  deleteProductFavorite(int id) async {
    database.delete(favoriteTableName, where: 'id=?', whereArgs: [id]);
  }




  insertCart(SingleProductModel product) async {
    int rowNum = await database.insert(cartTableName, product.toMap());
    print(rowNum);
  }

  Future<List<SingleProductModel>> getAllProductsCart() async {
    List<Map<String, Object>> results = await database.query(cartTableName);
    List<SingleProductModel> product = results.map((e) {
      return SingleProductModel.fromMap(e);
    }).toList();
    return product;
  }

  deleteProductCart(int id) async {
    database.delete(cartTableName, where: 'id=?', whereArgs: [id]);
  }
}
