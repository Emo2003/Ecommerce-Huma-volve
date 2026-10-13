import 'package:dart_either/src/dart_either.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repository/home_repo.dart';

import '../entities/categories_entity.dart';

class CategoriesUseCase {
  final HomeRepo homeRepo;
  CategoriesUseCase( this.homeRepo);

  Future<Either<Failure, List<CategoriesEntity>>> call() async {
    return await homeRepo.getCategories();
  }
}