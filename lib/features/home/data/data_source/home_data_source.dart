import 'package:ecommerce_app_huma_volve/features/home/data/models/Categories_model.dart';

import '../models/Products_model.dart';

abstract class HomeDataSource {
  Future<List<CategoriesModel>> getCategories();

  Future<List<ProductsModel>> getProducts(num? categoryId);
}
