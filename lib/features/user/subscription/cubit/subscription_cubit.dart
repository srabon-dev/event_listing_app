import 'dart:async';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../app_export.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionInitial());

  void initialize() {
    _setupCustomerInfoListener();
    loadSubscriptions();
  }

  void _setupCustomerInfoListener() {
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      if (!isClosed) {
        loadSubscriptions();
      }
    });
  }

  Future<void> loadSubscriptions() async {
    try {
      emit(SubscriptionLoading());
      final CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      final Offerings offerings = await Purchases.getOfferings();

      SubscriptionModel? yearlySubscription;

      if (offerings.current != null && offerings.current!.availablePackages.isNotEmpty) {
        final package = offerings.current!.availablePackages.first;
        final product = package.storeProduct;
        final introPrice = product.introductoryPrice;
        final hasIntroOffer = introPrice != null && introPrice.price > 0;

        String introPriceString = '';
        String introDuration = '';

        if (hasIntroOffer) {
          introPriceString = introPrice.priceString;
          introDuration = 'First Year';
        }

        yearlySubscription = SubscriptionModel(
          id: package.identifier,
          title: package.storeProduct.title,
          description: package.storeProduct.description,
          price: product.priceString,
          introPrice: hasIntroOffer ? introPriceString : product.priceString,
          introDuration: introDuration,
          identifier: product.identifier,
          features: _getPremiumFeatures(),
          hasIntroOffer: hasIntroOffer,
          introPriceString: introPriceString,
        );
      }

      final activeSubscription = _getActiveSubscription(customerInfo);
      final hasActiveSubscription = customerInfo.entitlements.active.isNotEmpty;

      emit(SubscriptionLoaded(
        yearlySubscription: yearlySubscription,
        activeSubscription: activeSubscription,
        hasActiveSubscription: hasActiveSubscription,
      ));
    } catch (e) {
      AppLogger.log("Failed to load subscription: ${_getErrorMessage(e)}");
      emit(SubscriptionError(
        message: 'Failed to load subscription: ${_getErrorMessage(e)}',
        errorCode: _getErrorCode(e),
      ));
    }
  }

  Future<void> purchaseSubscription(String packageId) async {
    try {
      final currentState = state;
      emit(SubscriptionPurchasing(packageId));
      final Offerings offerings = await Purchases.getOfferings();

      if (offerings.current == null || offerings.current!.availablePackages.isEmpty) {
        emit(const SubscriptionError(message: 'No subscription available'));
        if (currentState is SubscriptionLoaded) {
          emit(currentState);
        }
        return;
      }

      final package = offerings.current!.availablePackages.first;

      final purchaseResult = await Purchases.purchase(PurchaseParams.package(package));

      final customerInfo = purchaseResult.customerInfo;

      if (customerInfo.entitlements.active.isNotEmpty) {
        final activeSubscription = _getActiveSubscription(customerInfo);

        if (activeSubscription != null) {
          emit(SubscriptionPurchaseSuccess(
            message: activeSubscription.isIntroPeriod
                ? 'Subscription activated with introductory offer!'
                : 'Subscription activated successfully!',
            subscription: activeSubscription,
          ));

          await Future.delayed(const Duration(seconds: 1));
          await loadSubscriptions();
        } else {
          emit(const SubscriptionError(
            message: 'Purchase completed but subscription not active',
          ));
        }
      } else {
        emit(const SubscriptionError(
          message: 'Purchase completed but no active entitlements found',
        ));
        if (currentState is SubscriptionLoaded) {
          emit(currentState);
        }
      }
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);

      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        emit(const SubscriptionError(
          message: 'Purchase was cancelled',
          errorCode: 'cancelled',
        ));
      } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
        emit(const SubscriptionError(
          message: 'Payment is pending. Please check back later.',
          errorCode: 'pending',
        ));
      } else if (errorCode == PurchasesErrorCode.productAlreadyPurchasedError) {
        emit(const SubscriptionError(
          message: 'You already own this subscription',
          errorCode: 'already_purchased',
        ));
      } else {
        emit(SubscriptionError(
          message: 'Purchase failed: ${_getErrorMessage(e)}',
          errorCode: errorCode.toString(),
        ));
      }

      await loadSubscriptions();
    } catch (e) {
      emit(SubscriptionError(
        message: 'Purchase failed: ${_getErrorMessage(e)}',
      ));
      await loadSubscriptions();
    }
  }

  Future<void> restorePurchases() async {
    try {
      emit(SubscriptionRestoring());

      final CustomerInfo customerInfo = await Purchases.restorePurchases();

      if (customerInfo.entitlements.active.isNotEmpty) {
        final activeSubscription = _getActiveSubscription(customerInfo);

        emit(SubscriptionRestoreSuccess(
          message: 'Subscription restored successfully!',
          subscription: activeSubscription,
        ));
      } else {
        emit(const SubscriptionRestoreSuccess(
          message: 'No active subscriptions found to restore',
        ));
      }

      await Future.delayed(const Duration(seconds: 1));
      await loadSubscriptions();
    } catch (e) {
      emit(SubscriptionError(
        message: 'Restore failed: ${_getErrorMessage(e)}',
      ));
      await loadSubscriptions();
    }
  }

  ActiveSubscriptionModel? _getActiveSubscription(CustomerInfo customerInfo) {
    if (customerInfo.entitlements.active.isEmpty) {
      return null;
    }

    final entitlement = customerInfo.entitlements.active.values.first;

    final isIntroPeriod = _isInIntroductoryPeriod(entitlement);

    return ActiveSubscriptionModel(
      productId: entitlement.productIdentifier,
      title: 'Annual Premium Subscription',
      purchaseDate: DateTime.parse(entitlement.originalPurchaseDate),
      expiryDate:  DateTime.parse(entitlement.expirationDate ?? DateTime.now().toLocal().toIso8601String()),
      willRenew: entitlement.willRenew,
      store: entitlement.store.name,
      isActive: entitlement.isActive,
      isIntroPeriod: isIntroPeriod,
    );
  }

  bool _isInIntroductoryPeriod(EntitlementInfo entitlement) {
    final daysSincePurchase = DateTime.now().difference(DateTime.parse(entitlement.originalPurchaseDate)).inDays;
    return daysSincePurchase < 365;
  }

  List<String> _getPremiumFeatures() {
    return [
      'Unlimited event access',
      'Priority customer support',
      // 'Ad-free experience',
      'Early access to new features',
      'Exclusive premium content',
      // 'Advanced analytics dashboard',
      'Custom event notifications',
      // 'Offline access to saved events',
    ];
  }

  String _getErrorMessage(dynamic error) {
    if (error is PlatformException) {
      return error.message ?? 'An unknown error occurred';
    }
    return error.toString();
  }

  String? _getErrorCode(dynamic error) {
    if (error is PlatformException) {
      return error.code;
    }
    return null;
  }
}