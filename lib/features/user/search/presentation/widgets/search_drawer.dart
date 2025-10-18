import 'package:event_listing_app/app_export.dart';

class SearchDrawer extends StatelessWidget {
  const SearchDrawer({super.key, required this.controller});
  final SearchScreenCubit controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.softBrandColor,
      child: Column(
        children: [
          CustomTextField(

          ),
          CustomDropdownField(
            hintText: "Selected One",
            items: [
              "Registration Open",
              "Event Started",
              "Event Finished"
            ],
            onChanged: (value){

            },
          )
        ],
      ),
    );
  }
}
