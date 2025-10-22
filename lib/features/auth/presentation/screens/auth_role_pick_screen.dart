import '../../../../app_export.dart';

class AuthRolePickScreen extends StatefulWidget {
  const AuthRolePickScreen({super.key});

  @override
  State<AuthRolePickScreen> createState() => _AuthRolePickScreenState();
}

class _AuthRolePickScreenState extends State<AuthRolePickScreen> {
  bool isFindEvent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(context.loc.choose_your_role, style: context.headlineMedium.copyWith(fontWeight: FontWeight.w500),),
              Text(context.loc.discover_register_events, style: context.bodyLarge.copyWith(fontWeight: FontWeight.w400, color: AppColors.secondaryText),),
              const Gap(12),
              Row(
                spacing: 18,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        isFindEvent = true;
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isFindEvent?AppColors.softBrandColor:AppColors.white.withValues(alpha: 0.5),
                            border: isFindEvent? Border.all(color: AppColors.brandHoverColor): null,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          spacing: 12,
                          children: [
                            Assets.images.findEvent.image(),
                            Text(context.loc.find_events, style: context.titleLarge,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        isFindEvent = false;
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isFindEvent? AppColors.white.withValues(alpha: 0.5): AppColors.softBrandColor,
                          border: isFindEvent? null: Border.all(color: AppColors.brandHoverColor),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          spacing: 12,
                          children: [
                            Assets.images.listEvent.image(),
                            Text(context.loc.find_events, style: context.titleLarge,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(18),
              CustomButton(
                text: context.loc.continues,
                onTap: (){
                  AppRouter.route.pushNamed(RoutePath.signUpScreen, extra: isFindEvent);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
