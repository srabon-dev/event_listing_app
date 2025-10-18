import 'package:event_listing_app/app_export.dart';
import 'package:event_listing_app/features/user/search/presentation/widgets/search_app_bar.dart';

import '../widgets/search_drawer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchScreenCubit controller;
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller = context.read<SearchScreenCubit>();
  }

  @override
  void dispose() {
    searchController.dispose();
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: RefreshIndicator(
          onRefresh: () async {
            searchController.clear();
            controller.resetFilters();
          },
          child: PagedListView<int, String>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<String>(
              itemBuilder: (context, item, index) {
                return EventCardWidget(
                  onTap: () {
                    AppRouter.route.pushNamed(RoutePath.eventDetailsScreen, extra: "id");
                  },
                  event: EventCardEntity(id: "", coverImage: item),
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
                return NoDataCard(onTap: () => controller.pagingController.refresh());
              },
            ),
          ),
        ),
      ),
    );
  }
}
