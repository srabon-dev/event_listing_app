import '../../../app_export.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.onTap, this.text});

  final VoidCallback onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              context.loc.somethingWentWrong,
              style: context.titleMedium,
            ),
            Text(text ?? context.loc.the_application_has_encountered_an_unknown_error, maxLines: 2),
          ],
        ),
      ),
    );
  }
}
