import '../../../../app_export.dart';
import '../widgets/onboarding_action_widget.dart';
import '../widgets/onboarding_info_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(sl<ILocalService>()),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            int currentIndex = 0;
            if (state is OnboardingInitial) {
              currentIndex = state.index;
            } else if (state is ChangeIndexState) {
              currentIndex = state.index;
            }

            if (currentIndex > 0) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.read<OnboardingCubit>().changeIndex(),
              );
            }
            return const SizedBox();
          },
        ),
        actions: [
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              int currentIndex = 0;
              if (state is OnboardingInitial) {
                currentIndex = state.index;
              } else if (state is ChangeIndexState) {
                currentIndex = state.index;
              }
              if(currentIndex == (context.read<OnboardingCubit>().totalPages -1)){
                return const SizedBox();
              }

              return TextButton(
                onPressed: () {
                  context.read<OnboardingCubit>().skip();
                },
                style: const ButtonStyle(
                    textStyle: WidgetStatePropertyAll(TextStyle(decoration: TextDecoration.none))
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
                onTap: (){
                  context.read<OnboardingCubit>().changeIndex(isNext: true);
                },
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
                int currentIndex = 0;
                if (state is OnboardingInitial) {
                  currentIndex = state.index;
                } else if (state is ChangeIndexState) {
                  currentIndex = state.index;
                }
                switch (currentIndex) {
                  case 0:
                    return OnboardingInfoWidget(
                      title: context.loc.user_onboarding_title_one,
                      slogan: context.loc.user_onboarding_one,
                      image: Assets.images.userOnboardingOne,
                    );
                  case 1:
                    return OnboardingInfoWidget(
                      title: context.loc.user_onboarding_title_two,
                      slogan: context.loc.user_onboarding_two,
                      image: Assets.images.userOnboardingTwo,
                    );
                  case 2:
                    return OnboardingInfoWidget(
                      title: context.loc.user_onboarding_title_three,
                      slogan: context.loc.user_onboarding_three,
                      image: Assets.images.userOnboardingThree,
                    );
                  case 3:
                    return OnboardingInfoWidget(
                      title: context.loc.management_onboarding_title_one,
                      slogan: context.loc.management_onboarding_one,
                      image: Assets.images.managerOnboardingOne,
                    );
                  case 4:
                    return OnboardingInfoWidget(
                      title: context.loc.management_onboarding_title_two,
                      slogan: context.loc.management_onboarding_two,
                      image: Assets.images.managerOnboardingTwo,
                    );
                  case 5:
                    return OnboardingInfoWidget(
                      title: context.loc.management_onboarding_title_three,
                      slogan: context.loc.management_onboarding_three,
                      image: Assets.images.managerOnboardingThree,
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
            const OnboardingActionWidget(),
          ],
        ),
      ),
    );
  }
}
