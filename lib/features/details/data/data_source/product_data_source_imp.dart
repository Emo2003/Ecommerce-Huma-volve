import 'package:ecommerce_app_huma_volve/features/details/data/data_source/product_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/Products_model.dart';

import '../../../../core/constant/api_end_point.dart';
import '../../../../core/network_service/network_services.dart';

class ProductDataSourceImp implements ProductDataSource {
  final NetworkServices networkServices;

  ProductDataSourceImp(this.networkServices);

  @override
  Future<ProductsModel> getProductById(num? productId) async {
    final response = await networkServices.dio.get(
      "${ApiEndPoint.products}/$productId",
    );
    final product = ProductsModel.fromJson(response.data);
    return product;
  }
}
