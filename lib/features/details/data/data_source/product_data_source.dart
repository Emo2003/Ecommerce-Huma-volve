import '../../../home/data/models/Products_model.dart';

abstract class ProductDataSource {
  Future<ProductsModel> getProductById(num? productId);

}