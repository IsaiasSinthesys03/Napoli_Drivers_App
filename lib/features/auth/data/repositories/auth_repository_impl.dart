import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/driver.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/mock_auth_datasource.dart';
import '../models/driver_model.dart';

/// Implementación del repositorio de autenticación usando Mock DataSource
class AuthRepositoryImpl implements AuthRepository {
  final MockAuthDataSource dataSource;
  final SharedPreferences prefs;

  // Keys para SharedPreferences
  static const String _keyDriverId = 'driver_id';
  static const String _keyIsLoggedIn = 'is_logged_in';

  const AuthRepositoryImpl({required this.dataSource, required this.prefs});

  @override
  Future<Either<String, Driver>> login({
    required String email,
    required String password,
  }) async {
    try {
      final driverModel = await dataSource.login(email, password);

      if (driverModel == null) {
        return left('Credenciales inválidas');
      }

      // Convertir a entidad
      final driver = driverModel.toEntity();

      // Guardar sesión
      await prefs.setString(_keyDriverId, driver.id);
      await prefs.setBool(_keyIsLoggedIn, true);

      return right(driver);
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, Driver>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String vehicleType,
    required String licensePlate,
    String? profileImagePath,
  }) async {
    try {
      final driverModel = await dataSource.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        vehicleType: vehicleType,
        licensePlate: licensePlate,
        profileImagePath: profileImagePath,
      );

      final driver = driverModel.toEntity();

      // NO guardamos sesión aquí porque el usuario está pending
      // Solo retornamos el driver para mostrar pantalla de espera

      return right(driver);
    } catch (e) {
      return left(e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Future<void> logout() async {
    await prefs.remove(_keyDriverId);
    await prefs.setBool(_keyIsLoggedIn, false);
  }

  @override
  Future<Driver?> getCurrentDriver() async {
    final isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;
    if (!isLoggedIn) return null;

    final driverId = prefs.getString(_keyDriverId);
    if (driverId == null) return null;

    try {
      final driverModel = await dataSource.getDriverById(driverId);
      return driverModel?.toEntity();
    } catch (e) {
      return null;
    }
  }
}
