import 'package:ecommerce_app_huma_volve/features/details/data/data_source/product_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/details/domain/repository/product_repo.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network_service/network_services.dart';
import '../../../../../core/theme.dart';
import '../../../../details/data/data_source/product_data_source_imp.dart';
import '../../../../details/data/repository/product_repo_imp.dart';
import '../../../../details/domain/use_case/product_use_case.dart';
import '../../../../details/presentation/view/product_details_screen.dart';
import '../../../../details/presentation/view_model/product_cubit.dart';

class ProductCard extends StatefulWidget {
  final ProductsEntity product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late final ProductDetailsCubit productDetailsCubit;
  late final NetworkServices networkServices;
  late final ProductDataSource productDataSource;
  late final GetProductByIdUseCase getProductByIdUseCase;
  late final ProductRepo productRepo;

  @override
  void initState() {
    super.initState();
    networkServices = NetworkServices();
    productDataSource = ProductDataSourceImp(networkServices);
    productRepo = ProductRepositoryImpl(productDataSource);
    getProductByIdUseCase = GetProductByIdUseCase(productRepo);
    productDetailsCubit = ProductDetailsCubit(getProductByIdUseCase);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                BlocProvider(
                  create: (context) => productDetailsCubit,
                  child: ProductDetailsScreen(productId: widget.product.id),
                ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.08),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Hero(
                    tag: 'product-${widget.product.id}',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: Image.network(
                        widget.product.images?.isNotEmpty == true
                            ? widget.product.images!.first
                            : 'https://placehold.co/600x600/png?text=Product',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://placehold.co/600x600/png?text=Product',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: AppTheme.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.product.title ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${widget.product.price?.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppTheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
