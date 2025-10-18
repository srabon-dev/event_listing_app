import 'app.dart';
import 'app_export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceUtils.lockDevicePortrait();
  initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationCubit>(create: (_) => LocalizationCubit(sl<ILocalService>())),
        // BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<NavigationCubit>(create: (_) => NavigationCubit()),
        BlocProvider<EventListCubit>(create: (_) => EventListCubit(pagingController: PagingController(firstPageKey: 1), db: sl<ILocalService>())),
        BlocProvider<ShortlistedCubit>(create: (_) => ShortlistedCubit(pagingController: PagingController(firstPageKey: 1), pagingController1: PagingController(firstPageKey: 1), pagingController2: PagingController(firstPageKey: 1), db: sl<ILocalService>())),
        BlocProvider<SearchScreenCubit>(create: (_) => SearchScreenCubit(pagingController: PagingController(firstPageKey: 1), db: sl<ILocalService>())),
        BlocProvider<CategoryCubit>(create: (_) => CategoryCubit(db: sl<ILocalService>())),
        BlocProvider<ProfileCubit>(
          create:
              (_) => ProfileCubit(
                repository: ProfileRepository(apiClient: sl<IApiClient>()),
                db: sl<ILocalService>(),
              ),
        ),
        /*BlocProvider<ProfileEditCubit>(
          create:
              (_) => ProfileEditCubit(
                db: sl<ILocalService>(),
                repository: ProfileEditRepository(apiClient: sl<IApiClient>()),
              ),
        ),*/
      ],
      child: const MyApp(),
    ),
  );
}
