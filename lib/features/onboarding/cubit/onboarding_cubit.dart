import '../../../app_export.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final ILocalService db;
  final bool isUser;
  int _currentIndex = 0;

  late final List<OnboardingPage> pages;
  int get totalPages => pages.length;
  int get currentIndex => _currentIndex;

  OnboardingCubit(this.db, this.isUser) : super(OnboardingInitial(0)) {
    pages = isUser ? _userPages : _managerPages;
  }

  final List<OnboardingPage> _userPages = [
    OnboardingPage(
      title: (ctx) => ctx.loc.user_onboarding_title_one,
      slogan: (ctx) => ctx.loc.user_onboarding_one,
      image: Assets.images.userOnboardingOne,
    ),
    OnboardingPage(
      title: (ctx) => ctx.loc.user_onboarding_title_two,
      slogan: (ctx) => ctx.loc.user_onboarding_two,
      image: Assets.images.userOnboardingTwo,
    ),
    OnboardingPage(
      title: (ctx) => ctx.loc.user_onboarding_title_three,
      slogan: (ctx) => ctx.loc.user_onboarding_three,
      image: Assets.images.userOnboardingThree,
    ),
  ];

  final List<OnboardingPage> _managerPages = [
    OnboardingPage(
      title: (ctx) => ctx.loc.management_onboarding_title_one,
      slogan: (ctx) => ctx.loc.management_onboarding_one,
      image: Assets.images.managerOnboardingOne,
    ),
    OnboardingPage(
      title: (ctx) => ctx.loc.management_onboarding_title_two,
      slogan: (ctx) => ctx.loc.management_onboarding_two,
      image: Assets.images.managerOnboardingTwo,
    ),
    OnboardingPage(
      title: (ctx) => ctx.loc.management_onboarding_title_three,
      slogan: (ctx) => ctx.loc.management_onboarding_three,
      image: Assets.images.managerOnboardingThree,
    ),
  ];

  void changeIndex({bool isNext = false}) {
    if (isNext) {
      if (_currentIndex < totalPages - 1) {
        _currentIndex++;
        emit(ChangeIndexState(_currentIndex));
      } else {
        _checkAuthStatus();
      }
    } else {
      if (_currentIndex > 0) {
        _currentIndex--;
        emit(ChangeIndexState(_currentIndex));
      } else {
        _checkAuthStatus();
      }
    }
  }

  Future<void> skip() async => _checkAuthStatus();

  Future<void> _checkAuthStatus() async {
    if(isUser){
      AppRouter.route.goNamed(RoutePath.userNavigationScreen);
    }else {
      AppRouter.route.goNamed(RoutePath.managementNavigationScreen);
    }
  }
}

class OnboardingPage {
  final String Function(BuildContext) title;
  final String Function(BuildContext) slogan;
  final AssetGenImage image;

  const OnboardingPage({
    required this.title,
    required this.slogan,
    required this.image,
  });
}
