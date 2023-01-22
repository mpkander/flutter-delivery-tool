import 'package:flutter_delivery_tool/delivery_executor/delivery_executor.dart';
import 'package:flutter_delivery_tool/target.dart';

class Job {
  final String id;

  final String? name;

  final List<DeliveryTarget> targets;

  Job({
    required this.id,
    required this.name,
    required this.targets,
  });

  @override
  String toString() => 'Job(id: $id, deliveryExecutors: $targets)';
}
