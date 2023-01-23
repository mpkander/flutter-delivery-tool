import 'dart:io';

import 'package:flutter_delivery_tool/build_executor/apk_build_executor.dart';
import 'package:flutter_delivery_tool/build_executor/build_executor.dart';
import 'package:flutter_delivery_tool/delivery_executor/delivery_executor.dart';
import 'package:flutter_delivery_tool/utils/log_writer.dart';
import 'package:process_run/shell.dart';

abstract class FirebaseDeliveryExecutor extends DeliveryExecutor {}

class FirebaseAndroidDeliveryExecutor extends DeliveryExecutor {
  final ApkBuildExecutor _buildExecutor;

  FirebaseAndroidDeliveryExecutor(this._buildExecutor);

  @override
  Future<void> execute() async {
    var shell = Shell();

    shell = shell.cd('android');

    final result = await shell.run('make beta');

    for (final res in result) {
      logWriter.i(res.outText);
    }
  }
}
