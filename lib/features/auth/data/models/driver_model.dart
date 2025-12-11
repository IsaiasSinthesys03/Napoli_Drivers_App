import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/driver.dart';
import '../../domain/entities/vehicle_type.dart';
import '../../domain/entities/driver_status.dart';

part 'driver_model.g.dart';

/// Modelo de datos para Driver con serialización JSON
@JsonSerializable()
class DriverModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  @JsonKey(name: 'profile_image_url')
  final String? profileImageUrl;
  @JsonKey(name: 'vehicle_type')
  final String vehicleType;
  @JsonKey(name: 'license_plate')
  final String licensePlate;
  final String status;
  @JsonKey(name: 'is_online')
  final bool isOnline;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'total_deliveries')
  final int totalDeliveries;
  final double rating;
  @JsonKey(name: 'total_earnings')
  final double totalEarnings;

  const DriverModel({
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

  /// Convierte el modelo a entidad de dominio
  Driver toEntity() {
    return Driver(
      id: id,
      name: name,
      email: email,
      phone: phone,
      profileImageUrl: profileImageUrl,
      vehicleType: _parseVehicleType(vehicleType),
      licensePlate: licensePlate,
      status: _parseDriverStatus(status),
      isOnline: isOnline,
      createdAt: DateTime.parse(createdAt),
      totalDeliveries: totalDeliveries,
      rating: rating,
      totalEarnings: totalEarnings,
    );
  }

  /// Crea un modelo desde una entidad de dominio
  factory DriverModel.fromEntity(Driver driver) {
    return DriverModel(
      id: driver.id,
      name: driver.name,
      email: driver.email,
      phone: driver.phone,
      profileImageUrl: driver.profileImageUrl,
      vehicleType: driver.vehicleType.name,
      licensePlate: driver.licensePlate,
      status: driver.status.name,
      isOnline: driver.isOnline,
      createdAt: driver.createdAt.toIso8601String(),
      totalDeliveries: driver.totalDeliveries,
      rating: driver.rating,
      totalEarnings: driver.totalEarnings,
    );
  }

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);

  DriverModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImageUrl,
    String? vehicleType,
    String? licensePlate,
    String? status,
    bool? isOnline,
    String? createdAt,
    int? totalDeliveries,
    double? rating,
    double? totalEarnings,
  }) {
    return DriverModel(
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

  VehicleType _parseVehicleType(String type) {
    switch (type.toLowerCase()) {
      case 'moto':
        return VehicleType.moto;
      case 'bici':
      case 'bicicleta':
        return VehicleType.bici;
      case 'auto':
        return VehicleType.auto;
      default:
        return VehicleType.moto;
    }
  }

  DriverStatus _parseDriverStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return DriverStatus.pending;
      case 'approved':
        return DriverStatus.approved;
      case 'active':
        return DriverStatus.active;
      case 'inactive':
        return DriverStatus.inactive;
      default:
        return DriverStatus.pending;
    }
  }
}
