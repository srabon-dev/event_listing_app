import '../../../../app_export.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({super.key, required this.title, required this.desc});

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return desc.isNotEmpty?RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black),
          ),
          TextSpan(
            text: ": $desc",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black),
          ),
        ],
      ),
    ): const SizedBox();
  }
}
