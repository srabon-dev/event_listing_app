import 'dart:io';
import 'package:event_listing_app/app_export.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionService {
  static const String _appleApiKey = AppConfig.revenueCatAppleApiKey;
  static const String _googleApiKey = AppConfig.revenueCatGoogleApiKey;

  static Future<void> initialize() async {
    try {
      await Purchases.setLogLevel(LogLevel.debug);

      final local = sl<ILocalService>();
      final userId = await local.getUserId();

      late PurchasesConfiguration configuration;

      if (Platform.isIOS || Platform.isMacOS) {
        configuration = PurchasesConfiguration(_appleApiKey)..appUserID = userId;
      } else if (Platform.isAndroid) {
        configuration = PurchasesConfiguration(_googleApiKey)..appUserID = userId;
      }

      await Purchases.configure(configuration);

      AppLogger.log('RevenueCat initialized successfully');
    } catch (e) {
      AppLogger.log('RevenueCat initialization failed: $e');
      rethrow;
    }
  }

  static Future<void> identifyUser(String userId) async {
    try {
      await Purchases.logIn(userId);
      AppLogger.log('User identified: $userId');
    } catch (e) {
      AppLogger.log('Failed to identify user: $e');
      rethrow;
    }
  }

  static Future<void> logoutUser() async {
    try {
      await Purchases.logOut();
      AppLogger.log('✅ User logged out');
    } catch (e) {
      AppLogger.log('❌ Failed to logout user: $e');
      rethrow;
    }
  }

  static Future<bool> hasActiveSubscription() async {
    try {
      final CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      final entitlementId = Platform.isAndroid ? 'android_entitlement_id' : 'play_finder_1y';
      AppLogger.log('Failed to check subscription: ${customerInfo.entitlements.active}');
      return customerInfo.entitlements.active.containsKey(entitlementId);
    } catch (e) {
      AppLogger.log('❌ Failed to check subscription: $e');
      return false;
    }
  }

  static Future<CustomerInfo?> getCustomerInfo() async {
    try {
      return await Purchases.getCustomerInfo();
    } catch (e) {
      AppLogger.log('❌ Failed to get customer info: $e');
      return null;
    }
  }
}