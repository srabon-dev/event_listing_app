import '../../../../app_export.dart';

class OnboardingInfoWidget extends StatelessWidget {
  const OnboardingInfoWidget({
    super.key,
    required this.title,
    required this.slogan,
    required this.image,
  });

  final String title;
  final String slogan;
  final AssetGenImage image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          image.image(
            height: context.height/4,
          ),
          const Gap(64),
          Text(
            title,
            style: context.titleLarge,
          ),
          const Gap(12),
          Text(slogan, style: context.bodyLarge, maxLines: 4, textAlign: TextAlign.center,),
          const Gap(44),
        ],
      ),
    );
  }
}
