import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 404 Not Found Page
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 100,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                '404',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Page Not Found',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              Text(
                'The page you are looking for does not exist or has been moved.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.home),
                label: const Text('Go to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}