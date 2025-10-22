import '../../../../app_export.dart';
import '../widgets/onboarding_action_widget.dart';
import '../widgets/onboarding_info_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, required this.isUser});
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(sl<ILocalService>(), isUser),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final index = cubit.currentIndex;
            if (index > 0) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => cubit.changeIndex(),
              );
            }
            return const SizedBox();
          },
        ),
        actions: [
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              final index = cubit.currentIndex;
              if (index == cubit.totalPages - 1) {
                return const SizedBox();
              }

              return TextButton(
                onPressed: cubit.skip,
                style: const ButtonStyle(
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(decoration: TextDecoration.none),
                  ),
                ),
                child: Text(context.loc.skip),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        width: context.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomButton(
                text: context.loc.next,
                onTap: () => cubit.changeIndex(isNext: true),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                final currentIndex = cubit.currentIndex;
                final currentPage = cubit.pages[currentIndex];

                return OnboardingInfoWidget(
                  title: currentPage.title(context),
                  slogan: currentPage.slogan(context),
                  image: currentPage.image,
                );
              },
            ),
            const OnboardingActionWidget(),
          ],
        ),
      ),
    );
  }
}
