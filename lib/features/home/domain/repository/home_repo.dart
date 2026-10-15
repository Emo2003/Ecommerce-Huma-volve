import 'package:dart_either/dart_either.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/categories_entity.dart';

import '../entities/products_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CategoriesEntity>>> getCategories();

  Future<Either<Failure, List<ProductsEntity>>> getProducts(
    num? categoryId, {
    required int limit,
    required int offset,
  });
}
