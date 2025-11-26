import 'package:event_listing_app/app_export.dart';

import '../widgets/notifications_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NotificationsCubit(
            db: sl<ILocalService>(),
            repository: NotificationRepository(apiClient: sl<IApiClient>()),
          ),
        ),
        BlocProvider(
          create: (_) => RemoveNotificationCubit(
            db: sl<ILocalService>(),
            repository: NotificationRepository(apiClient: sl<IApiClient>()),
          ),
        ),
      ],
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
  final pagingController = PagingController<int, NotificationItem>(firstPageKey: 1);
  late final NotificationsCubit controller;
  late final RemoveNotificationCubit removeNotificationCubit;

  @override
  void initState() {
    controller = context.read<NotificationsCubit>();
    removeNotificationCubit = context.read<RemoveNotificationCubit>();
    
    pagingController.addPageRequestListener((pageKey) {
      controller.get(pageKey: pageKey, pagingController: pagingController);
    });
    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.loc.notification), titleTextStyle: context.titleMedium),
      body: RefreshIndicator(
        onRefresh: () async {
          pagingController.refresh();
        },
        child: PagedListView<int, NotificationItem>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<NotificationItem>(
            itemBuilder: (BuildContext context, NotificationItem item, int index) {
              return BlocConsumer<RemoveNotificationCubit, RemoveNotificationState>(
                listener: (_, state) {
                  if (state is RemoveNotificationStatus && state.isVerified) {
                    pagingController.refresh();
                  }
                },
                buildWhen: (prev, curr) {
                  if (curr is RemoveNotificationStatus) {
                    return curr.deletingId == item.id;
                  }
                  return false;
                },
                builder: (context, state) {
                  final isLoading = state is RemoveNotificationStatus && state.isLoading && state.deletingId == item.id;

                  return NotificationsCard(
                    item: item,
                    isLoading: isLoading,
                    onTap: () {
                      context.read<RemoveNotificationCubit>().removeNotification(id: item.id ?? "");
                    },
                  );
                },
              );
            },
            firstPageProgressIndicatorBuilder: (_) => const LoadingWidget(),
          ),
        ),
      ),
    );
  }
}
