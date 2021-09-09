import 'package:api_app/helpers/api_helper.dart';
import 'package:api_app/helpers/database_helpers.dart';
import 'package:api_app/model/single_product_model.dart';
import 'package:flutter/material.dart';

class ApiProvider with ChangeNotifier {
  List<String> allCategories;
  List<SingleProductModel> allProducts;
  List<SingleProductModel> categoryProducts;
  List<SingleProductModel> favoriteProducts;
  List<SingleProductModel> cartProducts;
  SingleProductModel selectedProduct;
  String selectedCategory = '';
  bool isFavorite = false;

  getAllCategories() async {
    List<dynamic> categories = await ApiHelper.apiHelper.getAllCategories();
    allCategories = categories.map((e) => e.toString()).toList();
    notifyListeners();
    getCategoryProducts(allCategories.first);
  }

  getCategoryProducts(String category) async {
    categoryProducts = null;
    this.selectedCategory = category;
    List<dynamic> products =
        await ApiHelper.apiHelper.getCategoryProducts(category);
    categoryProducts =
        products.map((e) => SingleProductModel.fromJson(e)).toList();
    notifyListeners();
  }

  getAllProducts() async {
    List<dynamic> products = await ApiHelper.apiHelper.getAllProducts();
    allProducts = products.map((e) => SingleProductModel.fromJson(e)).toList();
    notifyListeners();
  }

  getSpecificProduct(int id) async {
    selectedProduct = null;
    notifyListeners();
    dynamic response = await ApiHelper.apiHelper.getSpecificProduct(id);
    selectedProduct = SingleProductModel.fromJson(response);
    notifyListeners();
  }

  insertToFavorite() async {
    await DatabaseHelper.databaseHelper.insertFavorite(selectedProduct);
    isFavorite = true;
    notifyListeners();
  }

  getProductFromFavorite() async {
    favoriteProducts = await DatabaseHelper.databaseHelper.getAllProducts();
    notifyListeners();
  }

  deleteFromDatabase(id) async {
    await DatabaseHelper.databaseHelper.deleteProductFavorite(id);
    isFavorite = false;
    notifyListeners();
  }

  insertToCart() async {
    await DatabaseHelper.databaseHelper.insertCart(selectedProduct);
    isFavorite = true;
    notifyListeners();
  }

  getProductFromCart() async {
    cartProducts = await DatabaseHelper.databaseHelper.getAllProductsCart();
    notifyListeners();
  }

  deleteFromCart(id) async {
    await DatabaseHelper.databaseHelper.deleteProductCart(id);
    isFavorite = false;
    notifyListeners();
  }
}
