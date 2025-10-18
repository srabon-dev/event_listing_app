import 'package:go_router/go_router.dart';
import 'package:event_listing_app/app_export.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.splashScreen.addBasePath,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      ///======================= Initial Route =======================
      GoRoute(
        name: RoutePath.splashScreen,
        path: RoutePath.splashScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const SplashScreen(), state: state);
        },
      ),
      GoRoute(
        name: RoutePath.onboardingScreen,
        path: RoutePath.onboardingScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const OnboardingScreen(), state: state);
        },
      ),

      ///======================= Auth Route =======================
      /*GoRoute(
        name: RoutePath.authMainScreen,
        path: RoutePath.authMainScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const AuthMainScreen(), state: state);
        },
      ),*/
      GoRoute(
        name: RoutePath.loginScreen,
        path: RoutePath.loginScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const LoginScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.signUpScreen,
        path: RoutePath.signUpScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const SignUpScreen(), state: state);
        },
      ),
      GoRoute(
        name: RoutePath.signUpOtpScreen,
        path: RoutePath.signUpOtpScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: SignUpOtpScreen(email: state.extra as String),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.forgetScreen,
        path: RoutePath.forgetScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const ForgetScreen(), state: state);
        },
      ),
      GoRoute(
        name: RoutePath.forgetOtpScreen,
        path: RoutePath.forgetOtpScreen.addBasePath,
        pageBuilder: (context, state) {
          final data = state.extra;
          final email = data != null && data is String ? data : "";
          return _buildPageWithAnimation(child: ForgetOtpScreen(email: email), state: state);
        },
      ),
      GoRoute(
        name: RoutePath.resetPassword,
        path: RoutePath.resetPassword.addBasePath,
        pageBuilder: (context, state) {
          final data = state.extra;
          final email = data != null && data is String ? data : "";
          return _buildPageWithAnimation(child: ResetPassword(email: email), state: state);
        },
      ),

      ///======================= Main Route =======================
      GoRoute(
        name: RoutePath.userNavigationScreen,
        path: RoutePath.userNavigationScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const UserNavigationScreen(), state: state);
        },
      ),
      GoRoute(
        name: RoutePath.managementNavigationScreen,
        path: RoutePath.managementNavigationScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const ManagementNavigationScreen(), state: state);
        },
      ),
      GoRoute(
        name: RoutePath.categoryScreen,
        path: RoutePath.categoryScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const CategoryScreen(), state: state);
        },
      ),
      GoRoute(
        name: RoutePath.eventDetailsScreen,
        path: RoutePath.eventDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          final id = state.extra as String? ?? "";
          return _buildPageWithAnimation(child: EventDetailsScreen(id: id), state: state);
        },
      ),
      /*GoRoute(
        name: RoutePath.profileEditScreen,
        path: RoutePath.profileEditScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: ProfileEditScreen(profile: state.extra as ProfileEntity),
            state: state,
          );
        },
      ),*/

      ///======================= Air Conditioner Route =======================
      /*GoRoute(
        name: RoutePath.airConditionerAddScreen,
        path: RoutePath.airConditionerAddScreen.addBasePath,
        pageBuilder: (context, state) {
          final extra = state.extra;
          final map = (extra is Map<String, dynamic>) ? extra : {};

          print(map);
          final isBack = map['isBack'] as bool? ?? false;
          final rvId = map['rvId'] as String? ?? '';
          final isUpdate = map['isUpdate'] as bool? ?? false;
          final item = map['item'] as AirConditionItem?;

          return _buildPageWithAnimation(
            child: AirConditionerAddScreen(isBack: isBack, rvId: rvId, isUpdate: isUpdate, item: item,),
            state: state,
          );
        },
      ),*/
      /*GoRoute(
        name: RoutePath.airConditionerViewScreen,
        path: RoutePath.airConditionerViewScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const AirConditionerViewScreen(), state: state);
        },
      ),*/

      ///======================= Settings Route =======================
      /*GoRoute(
        name: RoutePath.settingsScreen,
        path: RoutePath.settingsScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const SettingsScreen(), state: state);
        },
      ),*/
      GoRoute(
        name: RoutePath.changePasswordScreen,
        path: RoutePath.changePasswordScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const ChangePasswordScreen(), state: state);
        },
      ),
      GoRoute(
        name: RoutePath.privacyPolicy,
        path: RoutePath.privacyPolicy.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const PrivacyPolicy(), state: state);
        },
      ),
      GoRoute(
        name: RoutePath.termsOfCondition,
        path: RoutePath.termsOfCondition.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const TermsOfCondition(), state: state);
        },
      ),
      GoRoute(
        name: RoutePath.aboutScreen,
        path: RoutePath.aboutScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: const AboutScreen(), state: state);
        },
      ),
    ],
  );

  static CustomTransitionPage _buildPageWithAnimation({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static GoRouter get route => initRoute;
}
