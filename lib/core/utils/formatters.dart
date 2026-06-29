import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

/// Formatting utilities for the ERP system
class Formatters {
  // Private constructor to prevent instantiation
  Formatters._();

  /// Currency formatter
  static final NumberFormat currencyFormatter = NumberFormat.currency(
    symbol: AppConstants.currencySymbol,
    decimalDigits: 2,
    locale: 'en_US',
  );

  /// Compact currency formatter (1.2K, 1.5M, etc.)
  static final NumberFormat compactCurrency = NumberFormat.compactCurrency(
    symbol: AppConstants.currencySymbol,
    decimalDigits: 1,
  );

  /// Percentage formatter
  static final NumberFormat percentageFormatter = NumberFormat.percentPattern(
    'en_US',
  );

  /// Number formatter with commas
  static final NumberFormat numberFormatter = NumberFormat.decimalPattern(
    'en_US',
  );

  /// Date formatter for display
  static final DateFormat dateFormatter = DateFormat(
    AppConstants.dateFormatDisplay,
    'en_US',
  );

  /// Date formatter for API
  static final DateFormat apiDateFormatter = DateFormat(
    AppConstants.dateFormatAPI,
    'en_US',
  );

  /// Month year formatter
  static final DateFormat monthYearFormatter = DateFormat(
    AppConstants.dateFormatMonthYear,
    'en_US',
  );

  /// DateTime formatter for display
  static final DateFormat dateTimeFormatter = DateFormat(
    AppConstants.dateTimeFormatDisplay,
    'en_US',
  );

  /// Format currency amount
  static String formatCurrency(double amount) {
    try {
      return currencyFormatter.format(amount);
    } catch (e) {
      return '${AppConstants.currencySymbol}${amount.toStringAsFixed(2)}';
    }
  }

  /// Format currency with compact notation for large amounts
  static String formatCompactCurrency(double amount) {
    try {
      if (amount.abs() >= 1000000) {
        return compactCurrency.format(amount);
      } else if (amount.abs() >= 1000) {
        return '${AppConstants.currencySymbol}${(amount / 1000).toStringAsFixed(1)}K';
      }
      return formatCurrency(amount);
    } catch (e) {
      return formatCurrency(amount);
    }
  }

  /// Format percentage
  static String formatPercentage(double value) {
    try {
      return percentageFormatter.format(value / 100);
    } catch (e) {
      return '${value.toStringAsFixed(2)}%';
    }
  }

  /// Format number with commas
  static String formatNumber(double number) {
    try {
      return numberFormatter.format(number);
    } catch (e) {
      return number.toStringAsFixed(2);
    }
  }

  /// Format number with decimal places
  static String formatNumberWithDecimals(double number, {int decimals = 2}) {
    return number.toStringAsFixed(decimals);
  }

  /// Format date for display
  static String formatDate(DateTime date) {
    try {
      return dateFormatter.format(date);
    } catch (e) {
      return date.toIso8601String();
    }
  }

  /// Format date for API
  static String formatApiDate(DateTime date) {
    try {
      return apiDateFormatter.format(date);
    } catch (e) {
      return date.toIso8601String();
    }
  }

  /// Format month and year
  static String formatMonthYear(DateTime date) {
    try {
      return monthYearFormatter.format(date);
    } catch (e) {
      return formatDate(date);
    }
  }

  /// Format datetime for display
  static String formatDateTime(DateTime dateTime) {
    try {
      return dateTimeFormatter.format(dateTime);
    } catch (e) {
      return dateTime.toIso8601String();
    }
  }

  /// Parse date string to DateTime
  static DateTime? parseDate(String dateString) {
    try {
      return dateFormatter.parse(dateString);
    } catch (e) {
      try {
        return apiDateFormatter.parse(dateString);
      } catch (e) {
        return DateTime.tryParse(dateString);
      }
    }
  }

  /// Format phone number
  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return '';

    // Remove all non-numeric characters
    String numbers = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    // Format based on length
    if (numbers.length == 10) {
      return '(${numbers.substring(0, 3)}) ${numbers.substring(3, 6)}-${numbers.substring(6)}';
    } else if (numbers.length == 11 && numbers.startsWith('1')) {
      return '+1 (${numbers.substring(1, 4)}) ${numbers.substring(4, 7)}-${numbers.substring(7)}';
    }

    return phoneNumber;
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  /// Format duration (seconds to readable format)
  static String formatDuration(int seconds) {
    if (seconds < 60) {
      return '${seconds}s';
    } else if (seconds < 3600) {
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      return remainingSeconds > 0 ? '${minutes}m ${remainingSeconds}s' : '${minutes}m';
    } else {
      final hours = seconds ~/ 3600;
      final minutes = (seconds % 3600) ~/ 60;
      return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
    }
  }

  /// Truncate text with ellipsis
  static String truncateText(String text, {int maxLength = 50}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Capitalize first letter of each word
  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;
    return text.split(' ')
        .map((word) => word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  /// Format status with appropriate styling
  static String formatStatus(String status) {
    return status.replaceAll('_', ' ').split(' ')
        .map((word) => word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  /// Get currency symbol
  static String getCurrencySymbol() {
    return AppConstants.currencySymbol;
  }

  /// Format profit/loss with color indicator (for text display)
  static String formatProfitLoss(double amount) {
    String formatted = formatCurrency(amount.abs());
    if (amount >= 0) {
      return '+$formatted';
    } else {
      return '-$formatted';
    }
  }

  /// Format change with percentage and direction
  static String formatChange(double value, {bool showPercentage = true}) {
    String prefix = value >= 0 ? '+' : '-';
    String formatted = showPercentage
        ? formatPercentage(value.abs())
        : formatNumber(value.abs());
    return '$prefix$formatted';
  }

  /// Format ratio (e.g., 1.5:1)
  static String formatRatio(double ratio) {
    return '${ratio.toStringAsFixed(2)}:1';
  }

  /// Format decimal places based on precision
  static String formatDecimal(double value, {int precision = 2}) {
    return value.toStringAsFixed(precision);
  }

  /// Safe null formatting
  static String safeString(dynamic value, {String defaultValue = 'N/A'}) {
    if (value == null) return defaultValue;
    if (value is String && value.isEmpty) return defaultValue;
    return value.toString();
  }

  /// Format list as comma-separated values
  static String formatList(List<String> items, {String separator = ', '}) {
    return items.join(separator);
  }

  /// Get initials from name
  static String getInitials(String name, {int maxInitials = 2}) {
    if (name.isEmpty) return '';
    List<String> parts = name.trim().split(' ');
    String initials = '';
    for (int i = 0; i < parts.length && i < maxInitials; i++) {
      if (parts[i].isNotEmpty) {
        initials += parts[i][0].toUpperCase();
      }
    }
    return initials;
  }

  /// Mask sensitive information (like account numbers)
  static String maskSensitiveInfo(String info, {int visibleChars = 4}) {
    if (info.isEmpty) return '';
    if (info.length <= visibleChars) return info;
    String visible = info.substring(info.length - visibleChars);
    return '*' * (info.length - visibleChars) + visible;
  }

  /// Format address components
  static String formatAddress({
    required String street,
    required String city,
    required String state,
    required String zipCode,
    String? country,
  }) {
    List<String> parts = [street, city, state, zipCode];
    if (country != null && country.isNotEmpty) {
      parts.add(country);
    }
    return parts.where((part) => part.isNotEmpty).join(', ');
  }
}