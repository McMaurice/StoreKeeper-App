import 'package:go_router/go_router.dart';
import 'package:storekepper_app/features/product_form/form_scrreen.dart';
import 'package:storekepper_app/features/home/home_screen.dart';
import 'package:storekepper_app/features/product/product_screen.dart';
import 'package:storekepper_app/features/welcome_screen.dart';

// Single router configuration
final GoRouter router = GoRouter(
  initialLocation: '/', // Starting screen
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),

    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),

    GoRoute(
      path: '/product_form',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final isEditing = extra?['isEditing'] ?? false;
        final product = extra?['product'] as Map<String, dynamic>?;
        return ProductFormScreen(isEditing: isEditing, product: product);
      },
    ),

    GoRoute(
      path: '/product',
      builder: (context, state) =>
          ProductScreen(product: state.extra as Map<String, dynamic>),
    ),
  ],
);
