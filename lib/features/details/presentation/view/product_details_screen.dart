import 'package:ecommerce_app_huma_volve/features/details/presentation/view/widgets/share_product_button.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme.dart';
import '../../../../core/widgets/primary_button.dart';
import '../view_model/product_cubit.dart';
import '../view_model/product_state.dart';

class ProductDetailsScreen extends StatefulWidget {
  final num? productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<ProductDetailsCubit>().getProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailsFailure) {
            return Center(
              child: Text(state.message, textAlign: TextAlign.center),
            );
          }

          if (state is ProductDetailsSuccess) {
            return _buildProductDetails(context, state.product);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context, ProductsEntity product) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 400,
          pinned: true,
          backgroundColor: AppTheme.background,

          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          actions: [
            ShareProductButton(productId: widget.productId.toString()),
            const SizedBox(width: 8),
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite_border, size: 18),
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],

          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: 'product-${product.id}',
              child: product.images != null && product.images!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(32),
                      ),
                      child: Image.network(
                        product.images!.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.image_not_supported, size: 50),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.image_not_supported, size: 50),
                    ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title ?? '',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(fontSize: 28, height: 1.2),
                        ),
                      ),

                      const SizedBox(width: 16),

                      Text(
                        '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(color: AppTheme.primary, fontSize: 24),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description ?? '',
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(height: 1.6, fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  // SizeSelector(
                  //   sizes: product.sizes,
                  //   ...
                  // ),
                  const SizedBox(height: 32),

                  PrimaryButton(
                    text: 'Add to Cart',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.title} added to cart'),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: AppTheme.primary,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
