import 'package:fpdart/fpdart.dart' hide Order;
import '../../domain/entities/order.dart';
import '../../domain/entities/order_status.dart';
import '../../domain/repositories/orders_repository.dart';
import '../datasources/mock_orders_datasource.dart';

/// Implementación del repositorio de pedidos
class OrdersRepositoryImpl implements OrdersRepository {
  final MockOrdersDataSource dataSource;

  const OrdersRepositoryImpl(this.dataSource);

  @override
  Future<Either<String, List<Order>>> getAvailableOrders() async {
    try {
      final orders = await dataSource.getAvailableOrders();
      return right(orders);
    } catch (e) {
      return left('Error al obtener pedidos: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, List<Order>>> getActiveOrders(String driverId) async {
    try {
      final orders = await dataSource.getActiveOrders(driverId);
      return right(orders);
    } catch (e) {
      return left('Error al obtener pedidos activos: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, Order>> getOrderById(String orderId) async {
    try {
      final order = await dataSource.getOrderById(orderId);
      if (order == null) {
        return left('Pedido no encontrado');
      }
      return right(order);
    } catch (e) {
      return left('Error al obtener pedido: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, Order>> acceptOrder(
    String orderId,
    String driverId,
  ) async {
    try {
      final order = await dataSource.updateOrderStatus(
        orderId,
        OrderStatus.accepted,
      );
      return right(order);
    } catch (e) {
      return left('Error al aceptar pedido: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, Order>> confirmPickup(String orderId) async {
    try {
      final order = await dataSource.updateOrderStatus(
        orderId,
        OrderStatus.pickedUp,
      );
      return right(order);
    } catch (e) {
      return left('Error al confirmar recogida: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, Order>> markOnTheWay(String orderId) async {
    try {
      final order = await dataSource.updateOrderStatus(
        orderId,
        OrderStatus.onTheWay,
      );
      return right(order);
    } catch (e) {
      return left('Error al marcar en camino: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, Order>> markDelivered(String orderId) async {
    try {
      final order = await dataSource.updateOrderStatus(
        orderId,
        OrderStatus.delivered,
      );
      return right(order);
    } catch (e) {
      return left('Error al marcar entregado: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, Order>> updateOrderStatus(
    String orderId,
    OrderStatus newStatus,
  ) async {
    try {
      final order = await dataSource.updateOrderStatus(orderId, newStatus);
      return right(order);
    } catch (e) {
      return left('Error al actualizar estado: ${e.toString()}');
    }
  }
}
