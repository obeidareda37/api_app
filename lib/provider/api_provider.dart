import 'package:api_app/helpers/api_helper.dart';
import 'package:api_app/helpers/database_helpers.dart';
import 'package:api_app/model/single_product_model.dart';
import 'package:flutter/material.dart';

class ApiProvider with ChangeNotifier {
  List<SingleProductModel> cartProducts;
  List<SingleProductModel> favouriteProducts;
  List<String> allCategories;
  List<SingleProductModel> allProducts;
  List<SingleProductModel> categoryProducts;
  SingleProductModel selectedProduct;
  String selectedCategory = '';

  getAllCategories() async {
    List<dynamic> categories = await ApiHelper.apiHelper.getAllCategories();
    allCategories = categories.map((e) => e.toString()).toList();
    notifyListeners();
    getCategoryProducts(allCategories.first);
  }

  getCategoryProducts(String category) async {
    categoryProducts = null;
    this.selectedCategory = category;
    notifyListeners();
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

  insertToCart(SingleProductModel product) async {
    bool productInCart = cartProducts == null
        ? false
        : cartProducts.any((x) {
            return x.id == product.id;
          });

    if (productInCart) {
      product.quantity = cartProducts
          .where((element) => element.id == product.id)
          .first
          .quantity;
      await DatabaseHelper.databaseHelper.updateProductQuantity(product);
    } else {
      await DatabaseHelper.databaseHelper.insertCart(product);
    }
    getAllCartProdcts();
  }

  updateProductInCart(SingleProductModel product) async {
    await DatabaseHelper.databaseHelper.updateProductQuantity(product);
    getAllCartProdcts();
  }

  insertToFavourite(SingleProductModel product) async {
    bool productInFavourite = favouriteProducts == null
        ? false
        : favouriteProducts.any((x) {
            return x.id == product.id;
          });
    print(productInFavourite);

    if (productInFavourite) {
      deleteFromFavourite(product.id);
    } else {
      await DatabaseHelper.databaseHelper.insertFavorite(product);
    }

    getAllFavouriteProdcts();
  }

  deleteFromCart(int id) async {
    await DatabaseHelper.databaseHelper.deleteProductCart(id);
    getAllCartProdcts();
  }

  deleteFromFavourite(int id) async {
    await DatabaseHelper.databaseHelper.deleteProductFavorite(id);
    getAllFavouriteProdcts();
  }

  getAllCartProdcts() async {
    List<SingleProductModel> products =
        await DatabaseHelper.databaseHelper.getAllProductsCart();
    this.cartProducts = products;
    cartProducts.forEach((element) {
      print(element.quantity);
    });
    notifyListeners();
  }

  getAllFavouriteProdcts() async {
    List<SingleProductModel> products =
        await DatabaseHelper.databaseHelper.getAllProducts();
    this.favouriteProducts = products;
    notifyListeners();
  }
}
