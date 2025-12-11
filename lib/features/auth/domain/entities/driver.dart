import 'package:equatable/equatable.dart';
import 'vehicle_type.dart';
import 'driver_status.dart';

/// Entidad de dominio que representa a un repartidor
class Driver extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImageUrl;
  final VehicleType vehicleType;
  final String licensePlate;
  final DriverStatus status;
  final bool isOnline;
  final DateTime createdAt;

  // Estadísticas
  final int totalDeliveries;
  final double rating;
  final double totalEarnings;

  const Driver({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImageUrl,
    required this.vehicleType,
    required this.licensePlate,
    required this.status,
    required this.isOnline,
    required this.createdAt,
    this.totalDeliveries = 0,
    this.rating = 0.0,
    this.totalEarnings = 0.0,
  });

  /// Verifica si el repartidor puede iniciar sesión
  bool get canLogin => status.canLogin;

  /// Verifica si el repartidor está pendiente de aprobación
  bool get isPending => status == DriverStatus.pending;

  /// Copia la entidad con campos modificados
  Driver copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImageUrl,
    VehicleType? vehicleType,
    String? licensePlate,
    DriverStatus? status,
    bool? isOnline,
    DateTime? createdAt,
    int? totalDeliveries,
    double? rating,
    double? totalEarnings,
  }) {
    return Driver(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      vehicleType: vehicleType ?? this.vehicleType,
      licensePlate: licensePlate ?? this.licensePlate,
      status: status ?? this.status,
      isOnline: isOnline ?? this.isOnline,
      createdAt: createdAt ?? this.createdAt,
      totalDeliveries: totalDeliveries ?? this.totalDeliveries,
      rating: rating ?? this.rating,
      totalEarnings: totalEarnings ?? this.totalEarnings,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    profileImageUrl,
    vehicleType,
    licensePlate,
    status,
    isOnline,
    createdAt,
    totalDeliveries,
    rating,
    totalEarnings,
  ];
}
