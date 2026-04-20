import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_trace_app/features/splash/pages/splash_page.dart';
import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/home/presentation/pages/dashboard_page.dart';
import '../features/onboarding/pages/onboarding_page.dart';
import 'route_constants.dart';
import '../core/widgets/common_text.dart';

// Placeholder widgets until real screens are built
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen(this.title, {super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: CommonText(title)));
}

final appRouter = GoRouter(
  initialLocation: RouteConstants.splash,
  routes: [
    GoRoute(
      path: RouteConstants.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RouteConstants.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: RouteConstants.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RouteConstants.signup,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: RouteConstants.forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: RouteConstants.home,
      builder: (context, state) => const DashboardPage(),
    ),
  ],
);
