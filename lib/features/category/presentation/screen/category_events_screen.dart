import 'package:event_listing_app/app_export.dart';

class CategoryEventsScreen extends StatelessWidget {
  const CategoryEventsScreen({
    super.key,
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return CategoryEventsCubit(
          pagingController: PagingController(firstPageKey: 1),
          db: sl<ILocalService>(),
        );
      },
      child: _View(id: id, title: title),
    );
  }
}

class _View extends StatefulWidget {
  const _View({required this.id, required this.title});

  final String id;
  final String title;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  late final CategoryEventsCubit controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<CategoryEventsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle: context.titleMedium,
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: PagedListView<int, String>(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<String>(
            itemBuilder: (BuildContext context, String item, int index) {
              return EventCardWidget(
                onTap: () {
                  AppRouter.route.pushNamed(
                    RoutePath.eventDetailsScreen,
                    extra: "id",
                  );
                },
                event: EventCardEntity(id: "", coverImage: item),
              );
            },
          ),
        ),
      ),
    );
  }
}
