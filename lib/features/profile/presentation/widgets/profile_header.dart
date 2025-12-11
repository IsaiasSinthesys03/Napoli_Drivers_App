import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/driver_profile.dart';

/// Widget que muestra el encabezado del perfil con foto y estadísticas
class ProfileHeader extends StatelessWidget {
  final DriverProfile profile;
  final VoidCallback onEditPressed;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final driver = profile.driver;

    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryGreen,
            AppColors.primaryGreen.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          // Avatar y botón editar
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: driver.profileImageUrl != null
                    ? NetworkImage(driver.profileImageUrl!)
                    : null,
                child: driver.profileImageUrl == null
                    ? const Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.primaryGreen,
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.primaryGreen,
                      size: 20,
                    ),
                    onPressed: onEditPressed,
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingM),

          // Nombre
          Text(
            driver.name,
            style: AppTextStyles.h2.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spacingXS),

          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                driver.rating.toStringAsFixed(1),
                style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingL),

          // Estadísticas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStat(
                icon: Icons.delivery_dining,
                label: 'Entregas',
                value: driver.totalDeliveries.toString(),
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              _buildStat(
                icon: Icons.attach_money,
                label: 'Ganancias',
                value: '\$${driver.totalEarnings.toStringAsFixed(0)}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.h3.copyWith(color: Colors.white)),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
