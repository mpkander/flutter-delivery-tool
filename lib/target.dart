import 'package:flutter_delivery_tool/delivery_executor/delivery_executor.dart';

class DeliveryTarget {
  final String name;

  final DeliveryExecutor executor;

  DeliveryTarget({
    required this.name,
    required this.executor,
  });
}
