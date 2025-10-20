import 'package:event_listing_app/app_export.dart';

import '../widgets/notifications_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.notification),
        titleTextStyle: context.titleMedium,
      ),
      body: RefreshIndicator(
        onRefresh: () async {

        },
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index){
            return const NotificationsCard();
          },
        ),
      ),
    );
  }
}
