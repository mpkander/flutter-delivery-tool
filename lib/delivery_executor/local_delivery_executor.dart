import 'package:flutter_delivery_tool/build_executor/build_executor.dart';
import 'package:flutter_delivery_tool/config_data/delivery_config.dart';
import 'package:flutter_delivery_tool/delivery_executor/delivery_executor.dart';

class LocalDeliveryExecutor extends DeliveryExecutor {
  final BuildExecutor _buildExecutor;

  LocalDeliveryExecutor(this._buildExecutor);

  @override
  Future<void> execute() => _buildExecutor.execute();
}
