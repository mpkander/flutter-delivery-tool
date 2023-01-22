import 'dart:io';

import 'package:flutter_delivery_tool/build_executor/apk_build_executor.dart';
import 'package:flutter_delivery_tool/build_executor/app_bundle_build_executor.dart';
import 'package:flutter_delivery_tool/build_executor/ipa_build_executor.dart';
import 'package:flutter_delivery_tool/config_data/delivery_config.dart';

abstract class BuildExecutor {
  String get buildTargetName;

  bool get useFvm;

  List<String> get additionalArguments;

  List<String> _combineCommand() => [
        if (useFvm) 'fvm',
        'flutter',
        'build',
        buildTargetName,
        ...additionalArguments,
      ];

  Future<void> execute() async {
    final command = _combineCommand();

    // TODO: use logWriter
    stdout.writeln('Running command ${command.join(' ')}');
    final result = await Process.run(command.first, command..removeAt(0));
    stdout.writeln(result.stdout);

    if (result.exitCode != 0) {
      throw BuildExecutionException(
        exitCode: result.exitCode,
        errorMessage: result.stderr,
        resultMessage: result.stdout,
      );
    }
  }

  const BuildExecutor();

  factory BuildExecutor.createBuildExecutor({
    required DeliveryConfigTargetType configTargetType,
    required List<String> additionalArguments,
    required bool useFvm,
  }) {
    switch (configTargetType) {
      case DeliveryConfigTargetType.apk:
        return ApkBuildExecutor(additionalArguments, useFvm);
      case DeliveryConfigTargetType.appBundle:
        return AppBundleBuildExecutor(additionalArguments, useFvm);
      case DeliveryConfigTargetType.ipa:
        return IpaBuildExecutor(additionalArguments, useFvm);
    }
  }
}

class BuildExecutionException implements Exception {
  final int exitCode;

  final Object? errorMessage;

  final Object? resultMessage;

  BuildExecutionException({
    required this.exitCode,
    this.errorMessage,
    this.resultMessage,
  });

  @override
  String toString() =>
      'BuildExecutionException(exitCode: $exitCode, errorMessage: $errorMessage, resultMessage: $resultMessage)';
}
