import 'package:event_listing_app/app_export.dart';
import 'package:event_listing_app/features/user/search/presentation/widgets/search_app_bar.dart';
import 'package:event_listing_app/features/user/search/presentation/widgets/search_drawer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchScreenCubit controller;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  final searchController = TextEditingController();
  final zipCode = TextEditingController();
  final ValueNotifier<String?> selectedSportType = ValueNotifier(null);
  final ValueNotifier<String?> selectedEventType = ValueNotifier(null);
  final ValueNotifier<String?> selectedAgesGroup = ValueNotifier(null);
  final ValueNotifier<String?> selectedSkillLevel = ValueNotifier(null);
  final ValueNotifier<String?> selectedStatus = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    controller = context.read<SearchScreenCubit>();

    controller.pagingController.addPageRequestListener((pageKey) {
      controller.get(
        pageKey: pageKey,
        status: selectedStatus.value,
        searchTerm: searchController.text.trim(),
        sport: selectedSportType.value,
        eventType: selectedEventType.value,
        selectedAge: selectedAgesGroup.value,
        skillLevel: selectedSkillLevel.value,
        zipCode: zipCode.text.trim(),
      );
    });
  }

  Future<void> refresh() async {
    searchController.clear();
    zipCode.clear();
    selectedSportType.value = null;
    selectedEventType.value = null;
    selectedAgesGroup.value = null;
    selectedSkillLevel.value = null;
    selectedStatus.value = null;

    controller.pagingController.refresh();
  }

  @override
  void dispose() {
    searchController.dispose();
    selectedSportType.dispose();
    selectedEventType.dispose();
    selectedAgesGroup.dispose();
    selectedSkillLevel.dispose();
    selectedStatus.dispose();
    zipCode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: SearchAppBar(
        searchController: searchController,
        controller: controller,
        globalKey: _globalKey,
      ),
      endDrawer: SearchDrawer(
        controller: controller,
        selectedSportType: selectedSportType,
        selectedEventType: selectedEventType,
        selectedAgesGroup: selectedAgesGroup,
        selectedSkillLevel: selectedSkillLevel,
        selectedStatus: selectedStatus,
        zipCode: zipCode,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: RefreshIndicator(
          onRefresh: refresh,
          child: PagedListView<int, OrganizerEventItem>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<OrganizerEventItem>(
              itemBuilder: (context, item, index) {
                return EventCardWidget(
                  onTap: (){
                    AppRouter.route.pushNamed(RoutePath.eventDetailsScreen, extra: {"id": item.id, "isUser": true});
                  },
                  event: item.toEntity(),
                );
              },
              firstPageErrorIndicatorBuilder: (_) {
                return ErrorCard(
                  onTap: () => controller.pagingController.refresh(),
                  text: controller.pagingController.error,
                );
              },
              firstPageProgressIndicatorBuilder: (_) {
                return const LoadingWidget();
              },
              newPageProgressIndicatorBuilder: (_) {
                return const LoadingWidget();
              },
              noItemsFoundIndicatorBuilder: (_) {
                return const NoDataCard();
              },
            ),
          ),
        ),
      ),
    );
  }
}
