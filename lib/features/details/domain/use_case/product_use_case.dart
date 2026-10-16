import 'package:dart_either/dart_either.dart';

import '../../../../core/failure/failure.dart';
import '../../../home/domain/entities/products_entity.dart';
import '../repository/product_repo.dart';

class GetProductByIdUseCase {
  final ProductRepo repository;

  GetProductByIdUseCase(this.repository);

  Future<Either<Failure, ProductsEntity>> call(
      num? productId,
      ) {
    return repository.getProductById(productId);
  }
}