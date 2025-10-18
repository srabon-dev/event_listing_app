import '../../../app_export.dart';

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({super.key, required this.event, this.onTap});
  final EventCardEntity event;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurvedCornerCard(
              imageUrl: event.coverImage ?? "https://picsum.photos/450/300",
              dateTime: DateConverter.formatDateRange(startDate: event.eventDateStart, endDate: event.eventDateEnd),
              height: 250,
            ),
            Text(event.title ?? context.loc.unknown, style: context.headlineSmall),
            Row(
              spacing: 6,
              children: [
                Assets.icons.location.svg(height: 20, width: 20),
                Text(
                  event.location ?? context.loc.unknown,
                  style: context.titleMedium.copyWith(fontWeight: FontWeight.w100),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Text(context.loc.ages, style: context.titleMedium),
                      Text(
                        event.ages ?? context.loc.unknown,
                        style: context.titleMedium.copyWith(fontWeight: FontWeight.w100),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Text(context.loc.sport, style: context.titleMedium),
                      Text(
                        event.category ?? context.loc.unknown,
                        style: context.titleMedium.copyWith(fontWeight: FontWeight.w100),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Text(context.loc.ratings, style: context.titleMedium),
                      Row(
                        spacing: 4,
                        children: [
                          Assets.icons.star.svg(),
                          Text(
                            event.ratings ?? context.loc.unknown,
                            style: context.titleMedium.copyWith(
                              fontWeight: FontWeight.w100,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(context.softBrandColor),
              ),
              child: Text(
                context.loc.viewDetails,
                style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CurvedCornerCard extends StatelessWidget {
  final String imageUrl;
  final String dateTime;
  final double height;
  final double width;

  const CurvedCornerCard({
    super.key,
    required this.imageUrl,
    required this.dateTime,
    this.height = 300,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: ClipPath(
              clipper: ComplexCurvedClipper(),
              child: CustomNetworkImage(imageUrl: imageUrl),
            ),
          ),
          Positioned(
            top: 5,
            right: 0,
            child: Row(
              spacing: 2,
              children: [
                Assets.icons.event.svg(height: 16, width: 16),
                Text(dateTime, style: context.titleSmall.copyWith(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ComplexCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width * 0.587, size.height * 0.134);
    path.cubicTo(
      size.width * 0.590,
      size.height * 0.143,
      size.width * 0.594,
      size.height * 0.148,
      size.width * 0.598,
      size.height * 0.148,
    );

    path.lineTo(size.width * 0.973, size.height * 0.148);
    path.cubicTo(
      size.width * 0.979,
      size.height * 0.148,
      size.width * 0.984,
      size.height * 0.155,
      size.width * 0.987,
      size.height * 0.168,
    );

    path.lineTo(size.width * 0.997, size.height * 0.208);
    path.cubicTo(
      size.width * 0.999,
      size.height * 0.218,
      size.width * 1.000,
      size.height * 0.229,
      size.width * 1.000,
      size.height * 0.238,
    );

    path.lineTo(size.width * 1.000, size.height * 1.000);
    path.lineTo(size.width * 0.087, size.height * 1.000);

    path.cubicTo(
      size.width * 0.082,
      size.height * 1.000,
      size.width * 0.077,
      size.height * 0.993,
      size.width * 0.074,
      size.height * 0.983,
    );

    path.lineTo(size.width * 0.004, size.height * 0.829);
    path.cubicTo(
      size.width * 0.001,
      size.height * 0.822,
      size.width * 0.000,
      size.height * 0.813,
      size.width * 0.000,
      size.height * 0.804,
    );

    path.lineTo(size.width * 0.000, size.height * 0.050);
    path.cubicTo(
      size.width * 0.000,
      size.height * 0.022,
      size.width * 0.007,
      size.height * 0.000,
      size.width * 0.017,
      size.height * 0.000,
    );

    path.lineTo(size.width * 0.532, size.height * 0.000);
    path.cubicTo(
      size.width * 0.537,
      size.height * 0.000,
      size.width * 0.541,
      size.height * 0.005,
      size.width * 0.544,
      size.height * 0.013,
    );

    path.lineTo(size.width * 0.587, size.height * 0.134);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}