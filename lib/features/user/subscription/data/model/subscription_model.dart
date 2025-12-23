import 'package:equatable/equatable.dart';

class SubscriptionModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String price;
  final String introPrice;
  final String introDuration;
  final String identifier;
  final List<String> features;
  final bool hasIntroOffer;
  final String introPriceString;

  const SubscriptionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.introPrice,
    required this.introDuration,
    required this.identifier,
    required this.features,
    this.hasIntroOffer = true,
    required this.introPriceString,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    introPrice,
    introDuration,
    identifier,
    features,
    hasIntroOffer,
    introPriceString,
  ];
}

class ActiveSubscriptionModel extends Equatable {
  final String productId;
  final String title;
  final DateTime purchaseDate;
  final DateTime expiryDate;
  final bool willRenew;
  final String store;
  final bool isActive;
  final bool isIntroPeriod;
  final String? cancellationReason;

  const ActiveSubscriptionModel({
    required this.productId,
    required this.title,
    required this.purchaseDate,
    required this.expiryDate,
    required this.willRenew,
    required this.store,
    required this.isActive,
    this.isIntroPeriod = false,
    this.cancellationReason,
  });

  bool get isExpired => DateTime.now().isAfter(expiryDate);

  int get daysUntilExpiry => expiryDate.difference(DateTime.now()).inDays;

  int get monthsUntilExpiry => (expiryDate.difference(DateTime.now()).inDays / 30).floor();

  @override
  List<Object?> get props => [
    productId,
    title,
    purchaseDate,
    expiryDate,
    willRenew,
    store,
    isActive,
    isIntroPeriod,
    cancellationReason,
  ];
}