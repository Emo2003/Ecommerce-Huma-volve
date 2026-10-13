import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repository/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network_service/network_services.dart';
import '../../../core/storage_services/secure_storage.dart';
import '../../../core/theme.dart';
import '../../auth/login/data/data_source/login_data_source.dart';
import '../../auth/login/data/data_source/login_data_source_imp.dart';
import '../../auth/login/data/repository/login_repo_imp.dart';
import '../../auth/login/domain/use_cases/login_use_case.dart';
import '../../auth/login/presentation/view/login_screen.dart';
import '../../auth/login/presentation/view_model/login_cubit.dart';
import '../../main_navigation/screens/main_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final NetworkServices networkServices;

  late final LoginDataSource loginDataSource;
  late final LoginRepository loginRepo;
  late final LoginUseCase loginUseCase;
  late final LoginCubit loginCubit;

  @override
  void initState() {
    super.initState();

    networkServices = NetworkServices();
    loginDataSource = LoginDataSourceImp(networkServices);
    loginRepo = LoginRepoImp(loginDataSource);
    loginUseCase = LoginUseCase(loginRepo);
    loginCubit = LoginCubit(loginUseCase);

    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));

    final accessToken = await SecureStorage.getAccessToken();

    if (!mounted) return;

    final Widget nextScreen;

    if (accessToken != null && accessToken.isNotEmpty) {
      nextScreen = const MainNavigationScreen();
    } else {
      nextScreen = BlocProvider<LoginCubit>.value(
        value: loginCubit,
        child: const LoginScreen(),
      );
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 120, color: AppTheme.primary),
            const SizedBox(height: 24),
            Text(
              'Huma-volve',
              style: Theme.of(context).textTheme.displayLarge
                  ?.copyWith(fontSize: 40, color: AppTheme.primary),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Ultimate E-Commerce App',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 48),
            CircularProgressIndicator(color: AppTheme.primary),
          ],
        ),
      ),
    );
  }
}
