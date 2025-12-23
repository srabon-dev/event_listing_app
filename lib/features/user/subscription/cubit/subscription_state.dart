part of 'subscription_cubit.dart';

sealed class SubscriptionState extends Equatable {
  const SubscriptionState();
}

final class SubscriptionInitial extends SubscriptionState {
  @override
  List<Object> get props => [];
}

final class SubscriptionLoading extends SubscriptionState {
  @override
  List<Object> get props => [];
}

final class SubscriptionLoaded extends SubscriptionState {
  final SubscriptionModel? yearlySubscription;
  final ActiveSubscriptionModel? activeSubscription;
  final bool hasActiveSubscription;

  const SubscriptionLoaded({
    required this.yearlySubscription,
    this.activeSubscription,
    required this.hasActiveSubscription,
  });

  @override
  List<Object?> get props => [yearlySubscription, activeSubscription, hasActiveSubscription];
}

final class SubscriptionPurchasing extends SubscriptionState {
  final String productId;

  const SubscriptionPurchasing(this.productId);

  @override
  List<Object> get props => [productId];
}

final class SubscriptionPurchaseSuccess extends SubscriptionState {
  final String message;
  final ActiveSubscriptionModel subscription;

  const SubscriptionPurchaseSuccess({
    required this.message,
    required this.subscription,
  });

  @override
  List<Object> get props => [message, subscription];
}

final class SubscriptionRestoring extends SubscriptionState {

  @override
  List<Object> get props => [];
}

final class SubscriptionRestoreSuccess extends SubscriptionState {
  final String message;
  final ActiveSubscriptionModel? subscription;

  const SubscriptionRestoreSuccess({
    required this.message,
    this.subscription,
  });

  @override
  List<Object?> get props => [message, subscription];
}

final class SubscriptionError extends SubscriptionState {
  final String message;
  final String? errorCode;

  const SubscriptionError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}