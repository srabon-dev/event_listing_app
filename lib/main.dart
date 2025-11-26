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
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            repository: AuthRepository(apiClient: sl<IApiClient>()),
            db: sl<ILocalService>(),
          ),
        ),
        BlocProvider<NavigationCubit>(create: (_) => NavigationCubit()),
        BlocProvider<EventListCubit>(
          create: (_) => EventListCubit(
            pagingController: PagingController(firstPageKey: 1),
            db: sl<ILocalService>(),
            repository: HomeRepository(apiClient: sl<IApiClient>())
          ),
        ),
        BlocProvider<EventDeleteCubit>(
          create: (_) => EventDeleteCubit(
            db: sl<ILocalService>(),
            repository: EventDetailsRepository(apiClient: sl<IApiClient>())
          ),
        ),
        BlocProvider<ManagementHomeCubit>(
          create: (_) => ManagementHomeCubit(
            pagingController: PagingController(firstPageKey: 1),
            repository: ManagementHomeRepository(apiClient: sl<IApiClient>()),
            db: sl<ILocalService>(),
          ),
        ),
        BlocProvider<SettingsCubit>(
          create: (_) => SettingsCubit(
            repository: SettingsRepository(apiClient: sl<IApiClient>()),
            db: sl<ILocalService>(),
          ),
        ),
        BlocProvider<BookmarkCubit>(
          create: (_) => BookmarkCubit(
            repository: BookmarkRepository(apiClient: sl<IApiClient>()),
            db: sl<ILocalService>(),
          ),
        ),
        BlocProvider<ReviewCubit>(
          create: (_) => ReviewCubit(
            repository: ReviewRepository(apiClient: sl<IApiClient>()),
            db: sl<ILocalService>(),
          ),
        ),
        BlocProvider<ShortlistedCubit>(
          create: (_) => ShortlistedCubit(
            pagingController: PagingController(firstPageKey: 1),
            pagingController1: PagingController(firstPageKey: 1),
            pagingController2: PagingController(firstPageKey: 1),
            pagingController3: PagingController(firstPageKey: 1),
            db: sl<ILocalService>(),
            repository: ShortlistedRepository(apiClient: sl<IApiClient>())
          ),
        ),
        BlocProvider<MyEventCubit>(
          create: (_) => MyEventCubit(
            pagingController: PagingController(firstPageKey: 1),
            pagingController1: PagingController(firstPageKey: 1),
            pagingController2: PagingController(firstPageKey: 1),
            pagingController3: PagingController(firstPageKey: 1),
            db: sl<ILocalService>(),
            repository: ManagementRepository(apiClient: sl<IApiClient>())
          ),
        ),
        BlocProvider<SearchScreenCubit>(
          create: (_) => SearchScreenCubit(
            pagingController: PagingController(firstPageKey: 1),
            db: sl<ILocalService>(),
            repository: SearchRepository(apiClient: sl<IApiClient>())
          ),
        ),
        BlocProvider<EventAddBloc>(
          create: (_) => EventAddBloc(
            repository: EventAddRepository(apiClient: sl<IApiClient>()),
            db: sl<ILocalService>(),
          ),
        ),
        BlocProvider<CategoryCubit>(
          create: (_) => CategoryCubit(repository: CategoryRepository(apiClient: sl<IApiClient>())),
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(
            repository: ProfileRepository(apiClient: sl<IApiClient>()),
            db: sl<ILocalService>(),
          ),
        ),
        BlocProvider<ProfileEditCubit>(
          create: (_) => ProfileEditCubit(
            db: sl<ILocalService>(),
            repository: ProfileEditRepository(apiClient: sl<IApiClient>()),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
