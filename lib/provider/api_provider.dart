import 'package:api_app/helpers/api_helper.dart';
import 'package:api_app/model/single_product_model.dart';
import 'package:flutter/material.dart';

class ApiProvider with ChangeNotifier{
  List<String> allCategories;
  List<SingleProductModel> allProducts;
  List<SingleProductModel> categoryProducts;
  SingleProductModel selectedProduct;
  getAllCategories() async {
    List<dynamic> categories = await ApiHelper.apiHelper.getAllCategories();
    allCategories = categories.map((e) => e.toString()).toList();
    notifyListeners();
  }

  getCategoryProducts(String category) async {
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
    dynamic response = await ApiHelper.apiHelper.getSpecificProduct(id);
    selectedProduct = SingleProductModel.fromJson(response);
    notifyListeners();
  }
}