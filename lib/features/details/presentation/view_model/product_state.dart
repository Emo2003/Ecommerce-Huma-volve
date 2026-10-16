import '../../../home/domain/entities/products_entity.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final ProductsEntity product;

  ProductDetailsSuccess(this.product);
}

class ProductDetailsFailure extends ProductDetailsState {
  final String message;

  ProductDetailsFailure(this.message);
}