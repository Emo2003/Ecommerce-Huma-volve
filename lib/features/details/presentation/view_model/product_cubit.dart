import 'package:ecommerce_app_huma_volve/features/details/presentation/view_model/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/product_use_case.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductByIdUseCase getProductByIdUseCase;

  ProductDetailsCubit(this.getProductByIdUseCase)
    : super(ProductDetailsInitial());

  Future<void> getProduct(num? productId) async {
    emit(ProductDetailsLoading());

    final result = await getProductByIdUseCase(productId);

    result.fold(
      ifLeft: (failure) {
        emit(ProductDetailsFailure(failure.message));
      },
      ifRight: (product) {
        emit(ProductDetailsSuccess(product));
      },
    );
  }
}
