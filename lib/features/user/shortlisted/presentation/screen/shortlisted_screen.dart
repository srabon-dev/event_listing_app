import 'package:event_listing_app/app_export.dart';

class ShortlistedScreen extends StatefulWidget {
  const ShortlistedScreen({super.key});

  @override
  State<ShortlistedScreen> createState() => _ShortlistedScreenState();
}

class _ShortlistedScreenState extends State<ShortlistedScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: Text(context.loc.my_shortlisted_event),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TabBarView(
          controller: _tabController,
          children: [
            RefreshIndicator(
              onRefresh: () async {

              },
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index){
                  return EventCardWidget(
                    onTap: (){
                      AppRouter.route.pushNamed(RoutePath.eventDetailsScreen, extra: "id");
                    },
                    event: ManagementEntities(
                      id: "",
                      name: "",
                      eventEnd: DateTime.now(),
                      eventStart: DateTime.now(),
                    ),
                  );
                },
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {

              },
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index){
                  return EventCardWidget(
                    onTap: (){
                      AppRouter.route.pushNamed(RoutePath.eventDetailsScreen, extra: "id");
                    },
                    event: ManagementEntities(
                      id: "",
                      name: "",
                      eventEnd: DateTime.now(),
                      eventStart: DateTime.now(),
                    ),
                  );
                },
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {

              },
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index){
                  return EventCardWidget(
                    onTap: (){
                      AppRouter.route.pushNamed(RoutePath.eventDetailsScreen, extra: "id");
                    },
                    event: ManagementEntities(
                      id: "",
                      name: "",
                      eventEnd: DateTime.now(),
                      eventStart: DateTime.now(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
