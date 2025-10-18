import 'package:get_it/get_it.dart';
import '../../app_export.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {

  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  )));

  sl.registerLazySingleton<INetworkChecker>(() => NetworkChecker());
  sl.registerLazySingleton<ILocalizationHelper>(() => LocalizationHelper());
  sl.registerLazySingleton<IErrorHandler>(() => ErrorHandle(sl<ILocalizationHelper>()));

  sl.registerLazySingleton<IApiClient>(() => ApiClient(
    dio: sl<Dio>(),
    networkChecker: sl<INetworkChecker>(),
    localizationHelper: sl<ILocalizationHelper>(),
    errorHandler: sl<IErrorHandler>(),
  ));

  sl.registerLazySingleton<ILocalService>(() => LocalService());

  sl.registerLazySingleton<ITokenRepository>(() => TokenRepository(apiClient: sl<IApiClient>()));

  sl.registerLazySingleton<ITokenManager>(() => TokenManager(
    dbHelper: sl<ILocalService>(),
    tokenRepository: sl<ITokenRepository>(),
  ));
}
