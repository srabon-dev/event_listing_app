import 'package:event_listing_app/app_export.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.mySubscription),
        titleTextStyle: context.titleMedium,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: RefreshIndicator(
          onRefresh: () async {

          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: context.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.skyLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Text(context.loc.lastPurchaseDate, style: context.titleMedium.copyWith(fontWeight: FontWeight.w500)),
                          Text(DateConverter.formatDate(format: "EEEE - MMMM dd, yyyy"), style: context.titleSmall.copyWith(fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: context.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.skyLight),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Text(context.loc.subscriptionExpiryDate, style: context.titleMedium.copyWith(fontWeight: FontWeight.w500)),
                          Text(DateConverter.formatDate(format: "EEEE - MMMM dd, yyyy"), style: context.titleSmall.copyWith(fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    const Gap(12),
                    ElevatedButton(
                      onPressed: (){

                      },
                      child: Text(context.loc.renewSubscription),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
