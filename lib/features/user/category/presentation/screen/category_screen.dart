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
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CategoryError) {
              return Center(child: Text(state.message));
            }

            if (state is CategoryLoaded && state.categories.isNotEmpty) {
              final displayItems = state.categories.toList();
              return RefreshIndicator(
                onRefresh: () async{
                  controller.getCategories();
                },
                child: GridView.builder(
                  itemCount: displayItems.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.4,
                  ),
                  itemBuilder: (context, index) {
                    final item = displayItems[index];
                    return CategoryBoxCardWidget(
                      name: item["name"]!,
                      image: item["image"]!,
                    );
                  },
                ),
              );
            }
            return const Center(child: Text('No categories found'));
          },
        ),
      ),
    );
  }
}
