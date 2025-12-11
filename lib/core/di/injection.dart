import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/datasources/mock_auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/dashboard/data/datasources/mock_dashboard_datasource.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/toggle_online_status_usecase.dart';
import '../../features/dashboard/presentation/cubit/dashboard_cubit.dart';
import '../../features/orders/data/datasources/mock_orders_datasource.dart';
import '../../features/orders/data/repositories/orders_repository_impl.dart';
import '../../features/orders/domain/repositories/orders_repository.dart';
import '../../features/orders/presentation/cubit/orders_cubit.dart';
import '../../features/history/data/datasources/mock_history_datasource.dart';
import '../../features/history/data/repositories/history_repository_impl.dart';
import '../../features/history/domain/repositories/history_repository.dart';
import '../../features/history/presentation/cubit/history_cubit.dart';
import '../../features/profile/data/datasources/mock_profile_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../services/phone_service.dart';
import '../services/navigation_service.dart';

final getIt = GetIt.instance;

/// Inicializa las dependencias de la aplicación
Future<void> initDependencies() async {
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // ========== CORE SERVICES ==========
  getIt.registerLazySingleton<PhoneService>(() => PhoneService());
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());

  // ========== AUTH ==========
  // DataSources
  getIt.registerLazySingleton<MockAuthDataSource>(() => MockAuthDataSource());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      dataSource: getIt<MockAuthDataSource>(),
      prefs: getIt<SharedPreferences>(),
    ),
  );

  // UseCases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );

  // Cubits
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      repository: getIt<AuthRepository>(),
    ),
  );

  // ========== DASHBOARD ==========
  // DataSources
  getIt.registerLazySingleton<MockDashboardDataSource>(
    () => MockDashboardDataSource(getIt<SharedPreferences>()),
  );

  // Repositories
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(getIt<MockDashboardDataSource>()),
  );

  // UseCases
  getIt.registerLazySingleton<ToggleOnlineStatusUseCase>(
    () => ToggleOnlineStatusUseCase(getIt<DashboardRepository>()),
  );

  // Cubits
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(
      toggleOnlineStatusUseCase: getIt<ToggleOnlineStatusUseCase>(),
      repository: getIt<DashboardRepository>(),
    ),
  );

  // ========== ORDERS ==========
  // DataSources
  getIt.registerLazySingleton<MockOrdersDataSource>(
    () => MockOrdersDataSource(),
  );

  // Repositories
  getIt.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(getIt<MockOrdersDataSource>()),
  );

  // Cubits
  getIt.registerFactory<OrdersCubit>(
    () => OrdersCubit(getIt<OrdersRepository>()),
  );

  // ========== HISTORY ==========
  // DataSources
  getIt.registerLazySingleton<MockHistoryDataSource>(
    () => MockHistoryDataSource(),
  );

  // Repositories
  getIt.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(getIt<MockHistoryDataSource>()),
  );

  // Cubits
  getIt.registerFactory<HistoryCubit>(
    () => HistoryCubit(getIt<HistoryRepository>()),
  );

  // ========== PROFILE ==========
  // DataSources
  getIt.registerLazySingleton<MockProfileDataSource>(
    () => MockProfileDataSource(getIt<SharedPreferences>()),
  );

  // Repositories
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<MockProfileDataSource>()),
  );

  // Cubits
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      repository: getIt<ProfileRepository>(),
      authRepository: getIt<AuthRepository>(),
      prefs: getIt<SharedPreferences>(),
    ),
  );
}
