import 'package:ecommerce_app_huma_volve/features/details/presentation/view/product_details_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/screens/splash_screen.dart';

final appRouting = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final num productId = num.parse(state.pathParameters['id']!);
        return ProductDetailsScreen(productId: productId);
      },
    ),
  ],
);
