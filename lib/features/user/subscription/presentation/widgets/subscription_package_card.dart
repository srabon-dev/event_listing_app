import 'package:event_listing_app/app_export.dart';

class YearlySubscriptionCard extends StatelessWidget {
  const YearlySubscriptionCard({super.key,
    required this.subscription,
    required this.onTap,
  });

  final SubscriptionModel subscription;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              AppColors.brandHoverColor.withValues(alpha: 0.1),
              AppColors.brandHoverColor.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: AppColors.brandHoverColor.withValues(alpha: 0.5),
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.brandHoverColor.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Stack(
          children: [
            if (subscription.hasIntroOffer)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade600,
                        Colors.orange.shade500,
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.local_offer,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'SPECIAL OFFER',
                        style: context.titleSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: subscription.hasIntroOffer ? 48 : 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 18,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.brandHoverColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.workspace_premium,
                          color: AppColors.brandHoverColor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subscription.title,
                              style: context.titleLarge.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              subscription.description,
                              style: context.titleSmall.copyWith(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (subscription.hasIntroOffer)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.orange.shade200,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.celebration,
                                color: Colors.orange.shade600,
                                size: 22,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Introductory Offer - First Year',
                                  style: context.titleMedium.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.orange.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pay as you go',
                                    style: context.titleSmall.copyWith(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    subscription.introPrice,
                                    style: context.headlineMedium.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.orange.shade700,
                                      fontSize: 24,
                                    ),
                                  ),
                                  Text(
                                    'for the first year',
                                    style: context.titleSmall.copyWith(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.green.shade300,
                                  ),
                                ),
                                child: Text(
                                  'Limited Time',
                                  style: context.titleSmall.copyWith(
                                    color: Colors.green.shade700,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.skyLight.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Then ${subscription.price}/year',
                              style: context.titleLarge.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Starting from year 2',
                              style: context.titleSmall.copyWith(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.info_outline,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children: [
                        Text(
                          'What\'s Included:',
                          style: context.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        ...subscription.features.map(
                              (feature) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check_circle,
                                    size: 20,
                                    color: Colors.green.shade600,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: context.titleSmall.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandHoverColor,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 4,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_open, size: 20),
                          SizedBox(width: 10),
                          Text(
                            'Subscribe Now',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      spacing: 8,
                      children: [
                        /*_buildInfoItem(
                          context,
                          Icons.calendar_today,
                          'Active: Dec 22, 2025 - Dec 31, 2028',
                        ),*/
                        _buildInfoItem(
                          context,
                          Icons.public,
                          'Available in 175 countries',
                        ),
                        _buildInfoItem(
                          context,
                          Icons.autorenew,
                          'Auto-renews annually. Cancel anytime.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: context.titleSmall.copyWith(
              color: Colors.grey.shade600,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}