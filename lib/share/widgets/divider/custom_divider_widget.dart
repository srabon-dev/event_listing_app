import '../../../app_export.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({super.key, required this.text, this.textColor});
  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: Container(
            height: 0.5,
            color: AppColors.brandHoverColor,
          ),
        ),
        Text(
          text,
        ),
        Expanded(
          child: Container(
            height: 0.5,
            color: AppColors.brandHoverColor,
          ),
        ),
      ],
    );
  }
}
