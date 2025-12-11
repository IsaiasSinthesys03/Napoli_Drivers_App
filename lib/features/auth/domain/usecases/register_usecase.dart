import 'package:fpdart/fpdart.dart';
import '../entities/driver.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso para registrar un nuevo repartidor
class RegisterUseCase {
  final AuthRepository repository;

  const RegisterUseCase(this.repository);

  Future<Either<String, Driver>> call({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String vehicleType,
    required String licensePlate,
    String? profileImagePath,
  }) async {
    // Validaciones
    if (name.isEmpty || name.length < 3) {
      return left('El nombre debe tener al menos 3 caracteres');
    }
    if (email.isEmpty || !_isValidEmail(email)) {
      return left('Email inválido');
    }
    if (password.isEmpty || password.length < 6) {
      return left('La contraseña debe tener al menos 6 caracteres');
    }
    if (password != confirmPassword) {
      return left('Las contraseñas no coinciden');
    }
    if (phone.isEmpty) {
      return left('El teléfono es requerido');
    }
    if (licensePlate.isEmpty) {
      return left('La placa/patente es requerida');
    }

    // Delegar al repositorio
    return repository.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
      vehicleType: vehicleType,
      licensePlate: licensePlate,
      profileImagePath: profileImagePath,
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
