import 'package:event_listing_app/app_export.dart';

class ProfileRowCard extends StatelessWidget {
  const ProfileRowCard({super.key, required this.name, required this.icon, this.onTap});

  final String name;
  final SvgGenImage icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.skyLight),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: icon.svg(),
                      ),
                  ),
                  Text(name, style: context.titleMedium.copyWith(fontWeight: FontWeight.w400)),
                ],
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
