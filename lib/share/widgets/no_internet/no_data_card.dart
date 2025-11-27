import '../../../app_export.dart';

class NoDataCard extends StatelessWidget {
  const NoDataCard({super.key, this.text, this.onTap});

  final String? text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.images.box.image(height: 100, width: 100),
            Text("Looks a bit empty here.", style: context.titleMedium),
            Text(text ?? "New events will appear once they’re available.", maxLines: 2),
            if (onTap != null) ElevatedButton(onPressed: onTap, child: const Text("Refresh")),
          ],
        ),
      ),
    );
  }
}
