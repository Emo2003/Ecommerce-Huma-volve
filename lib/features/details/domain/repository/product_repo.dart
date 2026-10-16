import 'package:dart_either/dart_either.dart';

import '../../../../core/failure/failure.dart';
import '../../../home/domain/entities/products_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, ProductsEntity>> getProductById(num? productId);

}