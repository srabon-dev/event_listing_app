import 'package:event_listing_app/app_export.dart';

class ManagementHomeScreen extends StatefulWidget {
  const ManagementHomeScreen({super.key});

  @override
  State<ManagementHomeScreen> createState() => _ManagementHomeScreenState();
}

class _ManagementHomeScreenState extends State<ManagementHomeScreen> {
  late final ManagementHomeCubit controller;
  late final CategoryCubit categoryController;
  late final NavigationCubit navigationController;

  @override
  void initState() {
    super.initState();
    controller = context.read<ManagementHomeCubit>();
    categoryController = context.read<CategoryCubit>();
    navigationController = context.read<NavigationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        centerTitle: false,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Assets.images.logoCircle.image(),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.loc.greeting("Srabon Ray"), style: context.titleMedium),
            Text(context.loc.welcomeToPlayFinderUSA, style: context.bodyLarge),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: (){
                AppRouter.route.pushNamed(RoutePath.notificationsScreen);
              },
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.brandHoverColor),
                  color: AppColors.softBrandColor,
                ),
                child: Assets.icons.notification.svg(),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {

        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  spacing: 12,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.loc.sportCategories,
                          style: context.titleMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            AppRouter.route.pushNamed(RoutePath.categoryScreen);
                          },
                          child: Text(
                            context.loc.view_all,
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<CategoryCubit, CategoryState>(
                      builder: (context, state) {
                        if (state is CategoryLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is CategoryLoaded) {
                          final items = state.categories.take(4).toList();

                          return GridView.builder(
                            itemCount: items.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.4,
                            ),
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return CategoryBoxCardWidget(
                                name: item["name"]!,
                                image: item["image"]!,
                                onTap: () {
                                  AppRouter.route.pushNamed(
                                    RoutePath.categoryEventsScreen,
                                    extra: {"title": item["name"]!, "id": ""},
                                  );
                                },
                              );
                            },
                          );
                        } else if (state is CategoryError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.loc.my_event,
                          style: context.titleMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            navigationController.changeIndex(index: 2);
                          },
                          child: Text(
                            context.loc.view_all,
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              sliver: PagedSliverList<int, String>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<String>(
                    itemBuilder: (BuildContext context, String item, int index){
                      return EventCardWidget(
                        onTap: (){
                          AppRouter.route.pushNamed(RoutePath.eventDetailsScreen, extra: "id");
                        },
                        event: EventCardEntity(
                          id: "",
                          coverImage: item,
                        ),
                      );
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
