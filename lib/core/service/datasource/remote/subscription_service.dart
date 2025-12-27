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
        configuration = PurchasesConfiguration(_appleApiKey);
      } else if (Platform.isAndroid) {
        configuration = PurchasesConfiguration(_googleApiKey);
      }

      if (userId.isNotEmpty) {
        configuration.appUserID = userId;
      }

      await Purchases.configure(configuration);

      AppLogger.log('RevenueCat initialized successfully : APP USER ID ${await Purchases.appUserID}');
    } catch (e) {
      AppLogger.log('RevenueCat initialization failed: $e');
      rethrow;
    }
  }

  static Future<void> identifyUser(String userId) async {
    try {
      final currentUserId = await Purchases.appUserID;
      if (currentUserId != userId) {
        final loginResult = await Purchases.logIn(userId);

        AppLogger.log('✅ User identified: APP USER ID ${await Purchases.appUserID}');
        AppLogger.log('📦 Created: ${loginResult.created}');
        if (!loginResult.created) {
          AppLogger.log('🔄 Existing user - subscriptions synced');
        }
      } else {
        AppLogger.log('ℹ️ User already logged in with same ID');
      }
    } catch (e) {
      AppLogger.log('Failed to identify user: $e');
      rethrow;
    }
  }

  static Future<void> logoutUser() async {
    try {
      await Purchases.logOut();
      AppLogger.log('✅ User logged out : APP USER ID ${await Purchases.appUserID}');
    } catch (e) {
      AppLogger.log('❌ Failed to logout user: $e');
      rethrow;
    }
  }

  static Future<bool> hasActiveSubscription() async {
    try {
      final CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      final hasSubscription = customerInfo.entitlements.active.isNotEmpty;

      AppLogger.log('🔍 APP USER ID ${await Purchases.appUserID} : Has active subscription: $hasSubscription');

      if (hasSubscription) {
        AppLogger.log('📦 Active entitlements: ${customerInfo.entitlements.active.keys.join(", ")}');
        final entitlement = customerInfo.entitlements.active.values.first;
        AppLogger.log('📅 Subscription expires: ${entitlement.expirationDate}');
        AppLogger.log('🔄 Will renew: ${entitlement.willRenew}');
        AppLogger.log('🏪 Store: ${entitlement.store.name}');
        AppLogger.log('📱 Product ID: ${entitlement.productIdentifier}');
      }

      return hasSubscription;
    } catch (e) {
      AppLogger.log('❌ Failed to check subscription: $e');
      return false;
    }
  }

  static Future<CustomerInfo?> getCustomerInfo() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();

      AppLogger.log('👤 Customer Info:');
      AppLogger.log('  - Original App User ID: ${customerInfo.originalAppUserId}');
      AppLogger.log('  - Active Entitlements: ${customerInfo.entitlements.active.keys.join(", ")}');
      AppLogger.log('  - All Purchased Products: ${customerInfo.allPurchasedProductIdentifiers.join(", ")}');

      return customerInfo;
    } catch (e) {
      AppLogger.log('❌ Failed to get customer info: $e');
      return null;
    }
  }

  static Future<void> syncPurchases() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      AppLogger.log('✅ Purchases synced for user: ${await Purchases.appUserID}');
      AppLogger.log('📦 Active subscriptions: ${customerInfo.entitlements.active.keys.length}');
    } catch (e) {
      AppLogger.log('❌ Failed to sync purchases: $e');
    }
  }
}