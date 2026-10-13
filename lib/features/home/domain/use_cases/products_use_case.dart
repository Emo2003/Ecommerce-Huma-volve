import 'package:dart_either/dart_either.dart';

import '../../../../core/failure/failure.dart';
import '../entities/products_entity.dart';
import '../repository/home_repo.dart';

class ProductsUseCase {
  final HomeRepo homeRepo;

  ProductsUseCase(this.homeRepo);

  Future<Either<Failure, List<ProductsEntity>>> call(num? categoryId) async {
    return await homeRepo.getProducts(categoryId);
  }
}
