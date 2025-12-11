import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/entities/driver.dart';
import '../../domain/usecases/toggle_online_status_usecase.dart';
import '../../domain/repositories/dashboard_repository.dart';
import 'dashboard_state.dart';

/// Cubit para gestionar el estado del dashboard
class DashboardCubit extends Cubit<DashboardState> {
  final ToggleOnlineStatusUseCase toggleOnlineStatusUseCase;
  final DashboardRepository repository;

  DashboardCubit({
    required this.toggleOnlineStatusUseCase,
    required this.repository,
  }) : super(const DashboardInitial());

  /// Inicializa el dashboard con los datos del driver
  Future<void> initialize(Driver driver) async {
    final isOnline = await repository.getOnlineStatus(driver.id);
    emit(DashboardLoaded(driver: driver, isOnline: isOnline));
  }

  /// Cambia el estado online/offline
  Future<void> toggleOnlineStatus() async {
    final currentState = state;
    if (currentState is! DashboardLoaded) return;

    final newOnlineStatus = !currentState.isOnline;

    // Optimistic update
    emit(currentState.copyWith(isOnline: newOnlineStatus));

    final result = await toggleOnlineStatusUseCase(
      driverId: currentState.driver.id,
      isOnline: newOnlineStatus,
    );

    result.fold(
      (error) {
        // Revertir en caso de error
        emit(currentState.copyWith(isOnline: !newOnlineStatus));
        emit(DashboardError(error));
        // Volver al estado loaded
        emit(currentState.copyWith(isOnline: !newOnlineStatus));
      },
      (_) {
        // Éxito - ya está actualizado optimísticamente
      },
    );
  }
}
