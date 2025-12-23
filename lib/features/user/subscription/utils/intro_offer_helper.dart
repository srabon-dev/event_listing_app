import 'package:event_listing_app/app_export.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class IntroOfferHelper {

  static Future<bool> isEligibleForIntroOffer() async {
    try {
      final CustomerInfo customerInfo = await Purchases.getCustomerInfo();

      if (customerInfo.allPurchasedProductIdentifiers.isNotEmpty) {
        return false;
      }

      if (customerInfo.entitlements.all.isNotEmpty) {
        return false;
      }

      return true;
    } catch (e) {
      AppLogger.log('Error checking intro offer eligibility: $e');
      return false;
    }
  }

  static IntroOfferDetails? getIntroOfferDetails(Package package) {
    final product = package.storeProduct;
    final introPrice = product.introductoryPrice;

    if (introPrice == null || introPrice.price <= 0) {
      return null;
    }

    return IntroOfferDetails(
      price: introPrice.priceString,
      period: 'First Year',
      cycles: 1,
      periodUnit: 'year',
      isPayAsYouGo: true,
      savings: _calculateSavings(product.priceString, introPrice.priceString),
    );
  }

  static String? _calculateSavings(String regularPrice, String introPrice) {
    try {
      final regularValue = _extractNumericPrice(regularPrice);
      final introValue = _extractNumericPrice(introPrice);

      if (regularValue == null || introValue == null || regularValue == 0) {
        return null;
      }

      final savings = ((regularValue - introValue) / regularValue * 100).round();
      return savings > 0 ? 'Save $savings%' : null;
    } catch (e) {
      return null;
    }
  }

  static double? _extractNumericPrice(String priceString) {
    try {
      final regex = RegExp(r'[\d,]+\.?\d*');
      final match = regex.firstMatch(priceString);
      if (match != null) {
        final numericString = match.group(0)?.replaceAll(',', '');
        return double.tryParse(numericString ?? '');
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static bool isInIntroPeriod(EntitlementInfo entitlement) {
    final purchaseDate = entitlement.originalPurchaseDate;
    final daysSincePurchase = DateTime.now().difference(DateTime.parse(purchaseDate)).inDays;

    return daysSincePurchase < 365;
  }

  static int getRemainingIntroDays(EntitlementInfo entitlement) {
    final purchaseDate = entitlement.originalPurchaseDate;
    final daysSincePurchase = DateTime.now().difference(DateTime.parse(purchaseDate)).inDays;
    final remainingDays = 365 - daysSincePurchase;

    return remainingDays > 0 ? remainingDays : 0;
  }

  static DateTime getIntroPeriodEndDate(DateTime purchaseDate) {
    return purchaseDate.add(const Duration(days: 365));
  }

  static String formatIntroOfferText(String introPrice, String regularPrice) {
    return '$introPrice for the first year, then $regularPrice/year';
  }

  static bool isIntroOfferPeriodActive() {
    final now = DateTime.now();
    final startDate = DateTime(2025, 12, 22);
    final endDate = DateTime(2028, 12, 31, 23, 59, 59);

    return now.isAfter(startDate) && now.isBefore(endDate);
  }

  static String getIntroOfferStatusMessage(ActiveSubscriptionModel subscription) {
    if (!subscription.isIntroPeriod) {
      return 'Standard pricing active';
    }

    final purchaseDate = subscription.purchaseDate;
    final introPeriodEnd = getIntroPeriodEndDate(purchaseDate);
    final remainingDays = introPeriodEnd.difference(DateTime.now()).inDays;

    if (remainingDays > 30) {
      final remainingMonths = (remainingDays / 30).round();
      return 'Introductory offer active - $remainingMonths months remaining';
    } else {
      return 'Introductory offer ends in $remainingDays days';
    }
  }

  static Future<ValidationResult> validateIntroOfferSetup() async {
    final errors = <String>[];
    final warnings = <String>[];

    try {
      final offerings = await Purchases.getOfferings();

      if (offerings.current == null) {
        errors.add('No current offering configured in RevenueCat');
        return ValidationResult(isValid: false, errors: errors, warnings: warnings);
      }

      if (offerings.current!.availablePackages.isEmpty) {
        errors.add('No packages available in current offering');
        return ValidationResult(isValid: false, errors: errors, warnings: warnings);
      }

      final package = offerings.current!.availablePackages.first;
      final product = package.storeProduct;

      if (product.introductoryPrice == null) {
        warnings.add('No introductory price configured for product');
      } else if (product.introductoryPrice!.price <= 0) {
        warnings.add('Introductory price is set to zero or negative');
      }

      if (!isIntroOfferPeriodActive()) {
        warnings.add('Current date is outside intro offer period (Dec 22, 2025 - Dec 31, 2028)');
      }

      return ValidationResult(
        isValid: errors.isEmpty,
        errors: errors,
        warnings: warnings,
      );
    } catch (e) {
      errors.add('Failed to validate setup: $e');
      return ValidationResult(isValid: false, errors: errors, warnings: warnings);
    }
  }
}

class IntroOfferDetails {
  final String price;
  final String period;
  final int cycles;
  final String periodUnit;
  final bool isPayAsYouGo;
  final String? savings;

  IntroOfferDetails({
    required this.price,
    required this.period,
    required this.cycles,
    required this.periodUnit,
    required this.isPayAsYouGo,
    this.savings,
  });
}

class ValidationResult {
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;

  ValidationResult({
    required this.isValid,
    required this.errors,
    required this.warnings,
  });

  bool get hasWarnings => warnings.isNotEmpty;

  String get summary {
    final buffer = StringBuffer();

    if (errors.isNotEmpty) {
      buffer.writeln('Errors:');
      for (final error in errors) {
        buffer.writeln('  ❌ $error');
      }
    }

    if (warnings.isNotEmpty) {
      buffer.writeln('Warnings:');
      for (final warning in warnings) {
        buffer.writeln('  ⚠️ $warning');
      }
    }

    if (isValid && warnings.isEmpty) {
      buffer.writeln('✅ Intro offer setup is valid');
    }

    return buffer.toString();
  }
}