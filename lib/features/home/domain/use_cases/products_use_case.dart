import 'package:dart_either/dart_either.dart';

import '../../../../core/failure/failure.dart';
import '../entities/products_entity.dart';
import '../repository/home_repo.dart';

class ProductsUseCase {
  final HomeRepo homeRepo;

  ProductsUseCase(this.homeRepo);

  Future<Either<Failure, List<ProductsEntity>>> call(
    num? categoryId, {
    required int limit,
    required int offset,
  }) async {
    final result = await homeRepo.getProducts(
      categoryId,
      limit: limit,
      offset: offset,
    );
    return result.fold(
      ifLeft: (Failure value) {
        return Left(value);
      },
      ifRight: (List<ProductsEntity> value) {
        return Right(value);
      },
    );
  }
}
