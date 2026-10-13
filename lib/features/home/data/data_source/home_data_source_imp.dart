import 'package:ecommerce_app_huma_volve/core/network_service/network_services.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_source/home_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/Categories_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/Products_model.dart';

import '../../../../core/constant/api_end_point.dart';

class HomeDataSourceImp implements HomeDataSource {
  final NetworkServices networkServices;

  HomeDataSourceImp(this.networkServices);

  @override
  Future<List<CategoriesModel>> getCategories() async {
    final response = await networkServices.dio.get(ApiEndPoint.categories);
    final List jsonData = response.data;
    final List<CategoriesModel> categories = jsonData
        .map((e) => CategoriesModel.fromJson(e))
        .toList();
    return categories;
  }

  @override
  Future<List<ProductsModel>> getProducts(num? categoryId) async {
    final response = await networkServices.dio.get(
      "${ApiEndPoint.categories}/$categoryId/${ApiEndPoint.products}",
    );
    final List jsonData = response.data;
    final List<ProductsModel> products = jsonData
        .map((e) => ProductsModel.fromJson(e))
        .toList();
    return products;
  }
}
