import 'package:flutter/material.dart';

/// Loading indicator widget
class LoadingWidget extends StatelessWidget {
  final String? message;
  final double size;

  const LoadingWidget({
    super.key,
    this.message,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}

/// Full screen loading overlay
class LoadingOverlay extends StatelessWidget {
  final String? message;
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    this.message,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black54,
            child: LoadingWidget(message: message),
          ),
      ],
    );
  }
}

/// Shimmer loading placeholder
class ShimmerLoadingWidget extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerLoadingWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
    );
  }
}

/// Card shimmer loading placeholder
class CardShimmerLoading extends StatelessWidget {
  const CardShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerLoadingWidget(
              width: 100,
              height: 20,
            ),
            const SizedBox(height: 12),
            const ShimmerLoadingWidget(
              width: 150,
              height: 32,
            ),
            const SizedBox(height: 8),
            const ShimmerLoadingWidget(
              width: 80,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}