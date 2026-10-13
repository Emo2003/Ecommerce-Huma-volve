import 'package:ecommerce_app_huma_volve/features/home/domain/entities/categories_entity.dart';

class CategoriesModel extends CategoriesEntity {
  CategoriesModel({super.id, super.name});

  CategoriesModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
}
