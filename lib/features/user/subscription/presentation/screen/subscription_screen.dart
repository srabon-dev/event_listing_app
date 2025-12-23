import 'package:event_listing_app/app_export.dart';

import '../widgets/subscription_package_card.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubscriptionCubit(),
      child: const _View(),
    );
  }
}


class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {

  @override
  void initState() {
    super.initState();
    context.read<SubscriptionCubit>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.mySubscription),
        titleTextStyle: context.titleMedium,
      ),
      body: BlocConsumer<SubscriptionCubit, SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionPurchaseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is SubscriptionRestoreSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is SubscriptionError) {
            if (state.errorCode != 'cancelled') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 4),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is SubscriptionLoading) {
            return const LoadingWidget();
          }

          if (state is SubscriptionLoaded) {
            return _buildLoadedContent(context, state);
          }

          if (state is SubscriptionPurchasing) {
            return _buildPurchasingOverlay(context);
          }

          if (state is SubscriptionRestoring) {
            return _buildRestoringOverlay(context);
          }

          return _buildErrorState(context);
        },
      ),
    );
  }

  Widget _buildLoadedContent(BuildContext context, SubscriptionLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<SubscriptionCubit>().loadSubscriptions();
      },
      child: CustomScrollView(
        slivers: [
          if (state.hasActiveSubscription && state.activeSubscription != null)
            SliverToBoxAdapter(
              child: _buildActiveSubscriptionSection(context, state.activeSubscription!),
            )
          /*else
            SliverToBoxAdapter(
              child: _buildNoSubscriptionSection(context),
            ),*/,

          if (state.yearlySubscription != null && !state.hasActiveSubscription)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pro Subscription',
                      style: context.titleLarge.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Subscribe now and unlock all premium features',
                      style: context.titleSmall.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

          if (state.yearlySubscription != null && !state.hasActiveSubscription)
            SliverToBoxAdapter(
              child: YearlySubscriptionCard(
                subscription: state.yearlySubscription!,
                onTap: () {
                  context.read<SubscriptionCubit>().purchaseSubscription(
                    state.yearlySubscription!.id,
                  );
                },
              ),
            ),

          SliverToBoxAdapter(
            child: _buildFooterSection(context, state.hasActiveSubscription),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSubscriptionSection(BuildContext context, ActiveSubscriptionModel subscription) {
    final isExpiringSoon = subscription.daysUntilExpiry <= 30 && !subscription.willRenew;

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            width: context.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  AppColors.brandHoverColor.withValues(alpha: 0.15),
                  AppColors.brandHoverColor.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: AppColors.brandHoverColor.withValues(alpha: 0.4), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.brandHoverColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'ACTIVE',
                        style: context.titleSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.verified,
                      color: AppColors.brandHoverColor,
                      size: 28,
                    ),
                  ],
                ),

                Text(
                  subscription.title,
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),

                if (subscription.isIntroPeriod)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.local_offer, color: Colors.green, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          'Introductory Offer Active - First Year',
                          style: context.titleSmall.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                const Divider(height: 24),

                _buildInfoRow(
                  context,
                  Icons.shopping_bag_outlined,
                  'Purchase Date',
                  DateConverter.formatDate(
                    dateTime: subscription.purchaseDate,
                    format: "MMMM dd, yyyy",
                  ),
                ),

                const SizedBox(height: 8),

                _buildInfoRow(
                  context,
                  Icons.calendar_today_outlined,
                  subscription.willRenew ? 'Renewal Date' : 'Expiry Date',
                  DateConverter.formatDate(
                    dateTime: subscription.expiryDate,
                    format: "MMMM dd, yyyy",
                  ),
                ),

                const SizedBox(height: 8),

                _buildInfoRow(
                  context,
                  Icons.store_outlined,
                  'Store',
                  subscription.store == 'APP_STORE' ? 'App Store' : 'Play Store',
                ),

                const SizedBox(height: 8),

                _buildInfoRow(
                  context,
                  Icons.autorenew,
                  'Auto Renewal',
                  subscription.willRenew ? 'Enabled' : 'Disabled',
                  valueColor: subscription.willRenew ? Colors.green : Colors.orange,
                ),

                if (isExpiringSoon)
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Subscription ${subscription.daysUntilExpiry > 0 ? "expires in ${subscription.daysUntilExpiry} day${subscription.daysUntilExpiry != 1 ? 's' : ''}" : "has expired"}',
                            style: context.titleSmall.copyWith(
                              color: Colors.orange.shade800,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          OutlinedButton.icon(
            onPressed: () {
              _showManageSubscriptionDialog(context);
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: AppColors.brandHoverColor),
            ),
            icon: const Icon(Icons.settings, color: AppColors.brandHoverColor),
            label: const Text(
              'Manage Subscription',
              style: TextStyle(color: AppColors.brandHoverColor, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoSubscriptionSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              AppColors.skyLight.withValues(alpha: 0.3),
              AppColors.skyLight.withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: AppColors.skyLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 14,
          children: [
            Icon(
              Icons.card_membership_outlined,
              size: 56,
              color: AppColors.brandHoverColor.withValues(alpha: 0.7),
            ),
            Text(
              'No Active Subscription',
              style: context.titleLarge.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            Text(
              'Subscribe now to unlock all premium features and enhance your experience',
              style: context.titleSmall.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                context.read<SubscriptionCubit>().restorePurchases();
              },
              icon: const Icon(Icons.restore),
              label: const Text('Restore Purchases'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value, {Color? valueColor}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.titleSmall.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooterSection(BuildContext context, bool hasActiveSubscription) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          if (!hasActiveSubscription)
            Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<SubscriptionCubit>().restorePurchases();
                  },
                  child: const Text('Restore Purchases'),
                ),
                Container(
                  width: 1,
                  height: 16,
                  color: Colors.grey.shade400,
                ),
                TextButton(
                  onPressed: () {
                    SubscriptionUtils.openSubscriptionManagement();
                  },
                  child: const Text('Managed Subscription'),
                ),
              ],
            ),
/*
          const Divider(),

          Text(
            'Available in 175 Countries',
            style: context.titleSmall.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),*/

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => AppRouter.route.pushNamed(RoutePath.privacyPolicy),
                child: const Text('Privacy Policy'),
              ),
              Container(
                width: 1,
                height: 16,
                color: Colors.grey.shade400,
              ),
              TextButton(
                onPressed: () => AppRouter.route.pushNamed(RoutePath.termsOfCondition),
                child: const Text('Terms of Service'),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Subscription active from Dec 22, 2025 to Dec 31, 2028. Auto-renews annually unless cancelled. Manage in your account settings.',
              style: context.titleSmall.copyWith(
                color: Colors.grey.shade500,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchasingOverlay(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.6),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 18,
            children: [
              const CircularProgressIndicator(),
              Text(
                'Processing Purchase...',
                style: context.titleLarge.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                'Please wait while we activate your subscription',
                style: context.titleSmall.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestoringOverlay(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.6),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 18,
            children: [
              const CircularProgressIndicator(),
              Text(
                'Restoring Purchases...',
                style: context.titleLarge.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                'Checking for previous subscriptions',
                style: context.titleSmall.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 18,
          children: [
            Icon(Icons.error_outline, size: 72, color: Colors.red.withValues(alpha: 0.6)),
            Text(
              'Something went wrong',
              style: context.titleLarge.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              'Unable to load subscription. Please check your connection and try again.',
              style: context.titleSmall.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                context.read<SubscriptionCubit>().loadSubscriptions();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _showManageSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Manage Subscription'),
        content: const Text(
          'To manage or cancel your subscription, please visit your account settings in the App Store or Google Play Store.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              SubscriptionUtils.openSubscriptionManagement();
            },
            child: const Text('Open Store'),
          ),
        ],
      ),
    );
  }
}