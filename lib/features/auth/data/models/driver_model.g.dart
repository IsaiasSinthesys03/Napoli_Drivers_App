// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverModel _$DriverModelFromJson(Map<String, dynamic> json) => DriverModel(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  profileImageUrl: json['profile_image_url'] as String?,
  vehicleType: json['vehicle_type'] as String,
  licensePlate: json['license_plate'] as String,
  status: json['status'] as String,
  isOnline: json['is_online'] as bool,
  createdAt: json['created_at'] as String,
  totalDeliveries: (json['total_deliveries'] as num?)?.toInt() ?? 0,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  totalEarnings: (json['total_earnings'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$DriverModelToJson(DriverModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'profile_image_url': instance.profileImageUrl,
      'vehicle_type': instance.vehicleType,
      'license_plate': instance.licensePlate,
      'status': instance.status,
      'is_online': instance.isOnline,
      'created_at': instance.createdAt,
      'total_deliveries': instance.totalDeliveries,
      'rating': instance.rating,
      'total_earnings': instance.totalEarnings,
    };
