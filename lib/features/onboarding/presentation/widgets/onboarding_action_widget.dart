import '../../../../app_export.dart';

class OnboardingActionWidget extends StatelessWidget {
  const OnboardingActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is OnboardingInitial) {
          currentIndex = state.index;
        } else if (state is ChangeIndexState) {
          currentIndex = state.index;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 6,
          children: List.generate(context.read<OnboardingCubit>().totalPages, (i) {
            final bool isActive = currentIndex == i;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: isActive ? 8 : 10,
              width: isActive ? 20 : 10,
              decoration: BoxDecoration(
                color: isActive ? AppColors.brandHoverColor : AppColors.softBrandColor,
                borderRadius: BorderRadius.circular(isActive ? 4 : 50),
              ),
            );
          }),
        );
      },
    );
  }
}
