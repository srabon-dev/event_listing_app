import 'package:event_listing_app/app_export.dart';

class NoInternetCard extends StatelessWidget {
  const NoInternetCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.empty.image(
              height: 100,
              width: 100
          ),
          Text(
            "Oops! No Internet",
            style: context.titleMedium,
          ),
          const Text("It looks like you’re offline.", maxLines: 2),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width / 1.6, 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.try_again,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
