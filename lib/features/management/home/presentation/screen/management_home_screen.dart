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

    controller.pagingController.addPageRequestListener((pageKey) {
      controller.get(pageKey: pageKey);
    });
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
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if(state is ProfileLoaded){
                  final name = state.data.name.isNotEmpty? state.data.name : context.loc.unknown;
                  return Text(context.loc.greeting(name), style: context.titleMedium);
                }
                return Text(context.loc.greeting(context.loc.unknown), style: context.titleMedium);
              },
            ),
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
          controller.pagingController.refresh();
          categoryController.getCategories();
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
                          return const LoadingWidget();
                        } else if (state is CategoryLoaded) {
                          final items = state.categories.getSports().toList();
                          if(items.isEmpty){
                            return const NoDataCard(
                              text: "Category will appear once they’re available.",
                            );
                          }
                          return GridView.builder(
                            itemCount: items.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 140,
                            ),
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return CategoryBoxCardWidget(
                                name: item.name,
                                image: item.categoryImage,
                                /*onTap: () {
                                  AppRouter.route.pushNamed(
                                    RoutePath.categoryEventsScreen,
                                    extra: {"title": item.name, "id": item.id},
                                  );
                                },*/
                              );
                            },
                          );
                        } else if (state is CategoryError) {
                          return ErrorCard(onTap: () {  }, text: state.message,);
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
              sliver: PagedSliverList<int, OrganizerEventItem>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<OrganizerEventItem>(
                    itemBuilder: (BuildContext context, OrganizerEventItem item, int index) {
                      return EventCardWidget(
                        onTap: (){
                          AppRouter.route.pushNamed(RoutePath.eventDetailsScreen, extra: {"id": item.id, "isUser": false});
                        },
                        event: item.toEntity(),
                      );
                    },
                  firstPageProgressIndicatorBuilder: (_)=> const LoadingWidget(),
                  noItemsFoundIndicatorBuilder: (_)=> const NoDataCard(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
