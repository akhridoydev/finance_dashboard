import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/not_found_page.dart';
import '../constants/app_constants.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

/// App Router Configuration
/// Uses Go Router for declarative routing with deep linking support
class AppRouter {
  // Private constructor
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.dashboard,
    errorBuilder: (context, state) => const NotFoundPage(),
    routes: [
      // Authentication Routes
      GoRoute(
        path: AppRoutes.login,
        name: 'Login',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Login')),
          body: const Center(child: Text('Login Page - To be implemented')),
        ),
      ),

      // Main Dashboard Route
      GoRoute(
        path: AppRoutes.dashboard,
        name: 'Dashboard',
        builder: (context, state) => const DashboardPage(),
      ),

      // Transactions Routes
      GoRoute(
        path: AppRoutes.transactions,
        name: 'Transactions',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Transactions')),
          body: const Center(child: Text('Transactions - To be implemented')),
        ),
      ),

      // Settings Routes
      GoRoute(
        path: AppRoutes.settings,
        name: 'Settings',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: const Center(child: Text('Settings - To be implemented')),
        ),
      ),
    ],
  );
}

/// Route Path Constants
class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String transactions = '/transactions';
  static const String income = '/income';
  static const String expenses = '/expenses';
  static const String investments = '/investments';
  static const String employees = '/employees';
  static const String assets = '/assets';
  static const String banking = '/banking';
  static const String clients = '/clients';
  static const String vendors = '/vendors';
  static const String invoices = '/invoices';
  static const String loans = '/loans';
  static const String reports = '/reports';
  static const String analytics = '/analytics';
  static const String settings = '/settings';
  static const String profile = '/profile';
}