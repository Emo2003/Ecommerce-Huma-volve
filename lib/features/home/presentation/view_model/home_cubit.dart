import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/categories_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/use_cases/products_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entities/categories_entity.dart';
import '../../domain/entities/products_entity.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoriesUseCase categoriesUseCase;
  final ProductsUseCase productsUseCase;

  HomeCubit(this.categoriesUseCase, this.productsUseCase)
    : super(HomeInitialState());

  void loadCategories() async {
    emit(CategoriesLoadingState());
    try {
      final categories = await categoriesUseCase.call();
      categories.fold(
        ifLeft: (Failure value) {
          emit(CategoriesErrorState(errorMessage: value.message));
        },
        ifRight: (List<CategoriesEntity> value) {
          emit(CategoriesSuccessState(categories: value));
        },
      );
    } catch (e) {
      emit(CategoriesErrorState(errorMessage: e.toString()));
    }
  }

  void loadProducts(num? categoryId) async {
    emit(ProductsLoadingState());
    try {
      final products = await productsUseCase.call(categoryId);
      products.fold(
        ifLeft: (Failure value) {
          emit(ProductsErrorState(errorMessage: value.message));
        },
        ifRight: (List<ProductsEntity> value) {
          emit(ProductsSuccessState(products: value));
        },
      );
    } catch (e) {
      emit(ProductsErrorState(errorMessage: e.toString()));
    }
  }
}
