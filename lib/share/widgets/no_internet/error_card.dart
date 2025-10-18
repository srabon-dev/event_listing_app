import '../../../app_export.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.onTap, this.text});

  final VoidCallback onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(24),
            if (text != null)
              Text(text ?? "", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16))
            else
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    context.loc.somethingWentWrong,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  const Gap(12),
                  Text(context.loc.the_application_has_encountered_an_unknown_error, maxLines: 2),
                  Text(context.loc.please_try_again_later),
                ],
              ),
            const Gap(24),
            CustomButton(text: context.loc.try_again, onTap: onTap),
          ],
        ),
      ),
    );
  }
}
