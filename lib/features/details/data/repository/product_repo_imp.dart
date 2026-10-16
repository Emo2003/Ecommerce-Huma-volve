import 'package:dart_either/dart_either.dart';

import '../../../../core/failure/failure.dart';
import '../../../home/domain/entities/products_entity.dart';
import '../../domain/repository/product_repo.dart';
import '../data_source/product_data_source.dart';

class ProductRepositoryImpl implements ProductRepo {
  final ProductDataSource homeDataSource;

  ProductRepositoryImpl(this.homeDataSource);

  @override
  Future<Either<Failure, ProductsEntity>> getProductById(num? productId) async {
    try {
      final product = await homeDataSource.getProductById(productId);

      return Right(product);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
