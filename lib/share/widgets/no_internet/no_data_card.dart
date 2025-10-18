import '../../../app_export.dart';

class NoDataCard extends StatelessWidget {
  const NoDataCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(24),
          Text(
            context.loc.no_items_found,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
          const Gap(12),
          Text(context.loc.the_list_is_currently_empty, maxLines: 2),
          const Gap(24),
          // ElevatedButton(onPressed: onTap, child: CustomText(text: "try_again".tr)),
        ],
      ),
    );
  }
}
