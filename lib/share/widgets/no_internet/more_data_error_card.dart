import '../../../app_export.dart';

class MoreDataErrorCard extends StatelessWidget {
  const MoreDataErrorCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Column(
          children: [
            Text(
              context.loc.something_went_wrong_tap_to_try_again,
              maxLines: 3,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const Gap(5),
            const Icon(Icons.refresh),
          ],
        ),
      ),
    );
  }
}
