import 'package:api_app/single_product_model.dart';
import 'package:dio/dio.dart';

class ApiHelper {
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();
  Dio dio = Dio();

  Future<List<SingleProductModel>> getAllProducts() async {
    String url = 'https://fakestoreapi.com/products';
    Response response = await dio.get(url);
    List<SingleProductModel> categories = response.data;
    return categories;
  }

  Future<List<SingleProductModel>> getSingleProducts(int productNum) async {
    String url = 'https://fakestoreapi.com/products/$productNum';
    Response response = await dio.get(url);
    List<dynamic> products = response.data;
    return products.map((e) => SingleProductModel.fromJson(e)).toList();
  }
}
