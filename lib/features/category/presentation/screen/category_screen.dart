import 'package:event_listing_app/app_export.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final CategoryCubit controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<CategoryCubit>();

    if (controller.state is! CategoryLoaded) {
      controller.getCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.loc.sportCategories),
          titleTextStyle: context.titleMedium,
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const LoadingWidget();
            }

            if (state is CategoryError) {
              return Center(child: Text(state.message));
            }

            if (state is CategoryLoaded && state.categories.getSports().isNotEmpty) {
              final displayItems = state.categories.getSports().toList();

              if(displayItems.isEmpty){
                return const NoDataCard(
                  text: "Category will appear once they’re available.",
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  controller.getCategories();
                },
                child: GridView.builder(
                  itemCount: displayItems.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 24,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 140,
                  ),
                  itemBuilder: (context, index) {
                    final item = displayItems[index];

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
                ),
              );
            }
            return Center(child: Text(context.loc.no_categories_found));
          },
        ),
      ),
    );
  }
}
