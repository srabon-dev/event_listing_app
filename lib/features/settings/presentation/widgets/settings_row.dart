import '../../../../app_export.dart';

class SettingsRow extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const SettingsRow({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}