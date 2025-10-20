import 'package:flutter_quill/flutter_quill.dart';

import 'app_export.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Event List APP',

          //Route Section
          routeInformationParser: AppRouter.route.routeInformationParser,
          routerDelegate: AppRouter.route.routerDelegate,
          routeInformationProvider: AppRouter.route.routeInformationProvider,

          //Theme Section
          themeMode: ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,

          //Language Section
          supportedLocales: L10n.all,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ],
        );
      },
    );
  }
}