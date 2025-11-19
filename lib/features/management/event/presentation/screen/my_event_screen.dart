import 'package:event_listing_app/app_export.dart';

class MyEventScreen extends StatefulWidget {
  const MyEventScreen({super.key});

  @override
  State<MyEventScreen> createState() => _MyEventScreenState();
}

class _MyEventScreenState extends State<MyEventScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  late final MyEventCubit controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    controller = context.read<MyEventCubit>();

    controller.pagingController.addPageRequestListener((pageKey) {
      controller.get(pageKey: pageKey);
    });
    controller.pagingController1.addPageRequestListener((pageKey) {
      controller.get1(pageKey: pageKey);
    });
    controller.pagingController2.addPageRequestListener((pageKey) {
      controller.get2(pageKey: pageKey);
    });
    controller.pagingController3.addPageRequestListener((pageKey) {
      controller.get3(pageKey: pageKey);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = [
      context.loc.upcoming,
      context.loc.registrationOpen,
      context.loc.eventStarted,
      context.loc.eventFinished,
    ];

    const Color selectedBg = Color(0xFF002868);
    const Color unselectedBg = Color(0xFFE6ECF5);
    const Color selectedText = Colors.white;
    const Color unselectedText = Color(0xFF002868);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.my_event),
        titleTextStyle: context.titleMedium,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            width: context.width,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ValueListenableBuilder(
                valueListenable: selectedIndex,
                builder: (context, newIndex, child){
                  return Row(
                    children: List.generate(tabs.length, (index) {
                      final bool isSelected = newIndex == index;

                      return GestureDetector(
                        onTap: () {
                          selectedIndex.value = index;
                          _tabController.animateTo(index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? selectedBg : unselectedBg,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: isSelected ? selectedText : unselectedText,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RefreshIndicator(
            onRefresh: () async {
              controller.pagingController.refresh();
            },
            child: PagedListView<int, OrganizerEventItem>(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<OrganizerEventItem>(
                itemBuilder: (_, item, _) {
                  return EventCardWidget(
                    onTap: (){
                      AppRouter.route.pushNamed(RoutePath.eventDetailsScreen, extra: {"id": item.id, "isUser": false});
                    },
                    event: item.toEntity(),
                  );
                }
              ),
            ),
          ),
          RefreshIndicator(
            onRefresh: () async {
              controller.pagingController1.refresh();
            },
            child: PagedListView<int, OrganizerEventItem>(
              pagingController: controller.pagingController1,
              builderDelegate: PagedChildBuilderDelegate<OrganizerEventItem>(
                itemBuilder: (_, item, _) {
                  return EventCardWidget(
                    onTap: (){
                      AppRouter.route.pushNamed(RoutePath.eventDetailsScreen, extra: {"id": item.id, "isUser": false});
                    },
                    event: item.toEntity(),
                  );
                }
              ),
            ),
          ),
          RefreshIndicator(
            onRefresh: () async {
              controller.pagingController2.refresh();
            },
            child: PagedListView<int, OrganizerEventItem>(
              pagingController: controller.pagingController2,
              builderDelegate: PagedChildBuilderDelegate<OrganizerEventItem>(
                itemBuilder: (_, item, _) {
                  return EventCardWidget(
                    onTap: (){
                      AppRouter.route.pushNamed(RoutePath.eventDetailsScreen, extra:{"id": item.id, "isUser": false});
                    },
                    event: item.toEntity(),
                  );
                }
              ),
            ),
          ),
          RefreshIndicator(
            onRefresh: () async {
              controller.pagingController3.refresh();
            },
            child: PagedListView<int, OrganizerEventItem>(
              pagingController: controller.pagingController3,
              builderDelegate: PagedChildBuilderDelegate<OrganizerEventItem>(
                itemBuilder: (_, item, _) {
                  return EventCardWidget(
                    onTap: (){
                      AppRouter.route.pushNamed(RoutePath.eventDetailsScreen, extra: {"id": item.id, "isUser": false});
                    },
                    event: item.toEntity(),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
