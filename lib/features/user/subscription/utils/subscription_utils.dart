import 'dart:io';
import 'package:event_listing_app/app_export.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionUtils {

  static Future<void> openSubscriptionManagement() async {
    try {
      if (Platform.isIOS) {
        await _launchURL('https://apps.apple.com/account/subscriptions');
      } else if (Platform.isAndroid) {
        await _launchURL('https://play.google.com/store/account/subscriptions');
      }
    } catch (e) {
      AppLogger.log('Failed to open subscription management: $e');
      rethrow;
    }
  }

  static Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch $urlString');
    }
  }

  static String formatDuration(DateTime expiryDate) {
    final now = DateTime.now();
    final difference = expiryDate.difference(now);

    if (difference.isNegative) {
      return 'Expired';
    }

    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} remaining';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} remaining';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} remaining';
    } else {
      return 'Expiring soon';
    }
  }

  static String calculateSavings(String monthlyPrice, String yearlyPrice) {
    try {
      final monthlyValue = _extractPrice(monthlyPrice);
      final yearlyValue = _extractPrice(yearlyPrice);

      if (monthlyValue == null || yearlyValue == null) {
        return '';
      }

      final annualMonthlyPrice = monthlyValue * 12;
      final savings = annualMonthlyPrice - yearlyValue;
      final percentSavings = (savings / annualMonthlyPrice * 100).round();

      return 'Save $percentSavings%';
    } catch (e) {
      return '';
    }
  }

  static double? _extractPrice(String priceString) {
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

  static Future<bool> isEligibleForIntroOffer(String productId) async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();

      return !customerInfo.allPurchasedProductIdentifiers.contains(productId);
    } catch (e) {
      AppLogger.log('Failed to check intro offer eligibility: $e');
      return false;
    }
  }

  static String getSubscriptionStatusMessage(ActiveSubscriptionModel subscription) {
    if (subscription.isExpired) {
      return 'Your subscription has expired';
    }

    if (!subscription.willRenew) {
      final daysLeft = subscription.daysUntilExpiry;
      if (daysLeft <= 7) {
        return 'Subscription ends in $daysLeft day${daysLeft != 1 ? 's' : ''}';
      }
      return 'Subscription set to expire';
    }

    return 'Active subscription';
  }

  static String getRenewalInfoText(ActiveSubscriptionModel subscription) {
    if (subscription.willRenew) {
      return 'Renews on ${DateConverter.formatDate(dateTime: subscription.expiryDate, format: "MMMM dd, yyyy")}';
    } else {
      return 'Expires on ${DateConverter.formatDate(dateTime: subscription.expiryDate, format: "MMMM dd, yyyy")}';
    }
  }
}