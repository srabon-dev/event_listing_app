import 'package:event_listing_app/app_export.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget{
  const SearchAppBar({super.key, required this.searchController, required this.controller, required this.globalKey});
  final TextEditingController searchController;
  final SearchScreenCubit controller;
  final GlobalKey<ScaffoldState> globalKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextField(
                controller: searchController,
                hintText: context.loc.search,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                prefixIcon: const Icon(Icons.search),
                onFieldSubmitted: (value) {
                  controller.setSearch(value);
                },
              ),
            ),
            const Gap(8),
            GestureDetector(
              onTap: () async {
                globalKey.currentState?.openEndDrawer();
              },
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.softBrandColor,
                ),
                child: const Icon(Iconsax.filter),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
