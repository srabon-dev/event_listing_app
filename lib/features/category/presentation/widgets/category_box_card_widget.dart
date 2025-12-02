import 'package:event_listing_app/app_export.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryBoxCardWidget extends StatelessWidget {
  const CategoryBoxCardWidget({super.key, required this.name, required this.image, this.onTap});

  final String name;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/category_bg.png"),
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomNetworkImage(imageUrl: image,),
              ),
            ),
            Flexible(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: context.titleLarge.copyWith(fontWeight: FontWeight.w500, fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}