import 'dart:io';

import 'package:args/args.dart';
import 'package:checked_yaml/checked_yaml.dart';
import 'package:flutter_delivery_tool/build_executor/build_executor.dart';
import 'package:flutter_delivery_tool/config_data/delivery_config.dart';
import 'package:flutter_delivery_tool/delivery_executor/delivery_executor.dart';
import 'package:flutter_delivery_tool/delivery_executor/local_delivery_executor.dart';
import 'package:flutter_delivery_tool/job.dart';
import 'package:flutter_delivery_tool/target.dart';
import 'package:flutter_delivery_tool/utils/log_writer.dart';
import 'package:json_annotation/json_annotation.dart';

const String _verboseFlag = 'verbose';
const String _jobOption = 'job';

const String _deliveryConfigFileName = 'delivery_config.yaml';

void main(List<String> arguments) async {
  final argParser = ArgParser()
    ..addFlag(
      _verboseFlag,
      abbr: _verboseFlag[0],
      help: 'Enable verbose output',
      negatable: false,
    )
    ..addOption(
      _jobOption,
      abbr: _jobOption[0],
      help: 'Run specific job from your yaml config',
      valueHelp: 'Job from your yaml config',
    );

  final ArgResults argResults;
  try {
    argResults = argParser.parse(arguments);
  } on FormatException catch (e) {
    stderr.writeln(e.message);
    exit(2);
  }

  final logWriter = LogWriter(argResults[_verboseFlag]);

  final importConfigProgress =
      logWriter.p('Importing $_deliveryConfigFileName...');

  logWriter.v('Getting file from the directory');
  final deliveryConfigFile = File(_deliveryConfigFileName);
  if (!deliveryConfigFile.existsSync()) {
    logWriter.e(
      'You need to provide $_deliveryConfigFileName. Please follow instructions',
    );
    exit(2);
  }

  logWriter.v('Start reading file from the directory');
  final deliveryConfigData = deliveryConfigFile.readAsStringSync();

  logWriter.v('Start parsing .yaml file');
  final DeliveryConfig deliveryConfig;
  try {
    final parsedYaml = checkedYamlDecode<Map?>(
      deliveryConfigData,
      (map) => map,
      allowNull: true,
    );

    logWriter.v('Parsed yaml data: $parsedYaml');

    logWriter.v('Start parsing config to Dart class');

    deliveryConfig = DeliveryConfig.fromJson(parsedYaml!);
  } on ParsedYamlException catch (e) {
    logWriter
      ..e('$_deliveryConfigFileName parsing was failed')
      ..e('Reason: ${e.message}');

    exit(2);
  } on CheckedFromJsonException catch (e) {
    logWriter
      ..e('$_deliveryConfigFileName parsing was failed')
      ..e(e.toString());

    exit(2);
  }

  importConfigProgress.finish(message: 'Config imported!');

  logWriter.v('Getting job from the config');
  final DeliveryConfigJob deliveryConfigJob;
  try {
    final jobKey = argResults[_jobOption];
    final maybeJob = deliveryConfig.jobs[jobKey];

    if (maybeJob == null) {
      logWriter.e(
        'Failed to get job "$jobKey" from $_deliveryConfigFileName\nMake sure you have such job key in the config file',
      );
      exit(2);
    }

    deliveryConfigJob = maybeJob;
  } on Exception catch (e) {
    logWriter
      ..e('Failed to get job from yaml-config')
      ..e('Reason: $e');

    exit(2);
  }

  logWriter.v('Start working with job "${argResults[_jobOption]}"');

  final Job job;
  try {
    job = Job(
      id: argResults[_jobOption],
      name: deliveryConfigJob.name,
      targets: _createDeliveryTargets(
        from: deliveryConfigJob,
        // Using of fvm is false by default.
        useFvmByConfig: deliveryConfig.useFvm ?? false,
      ),
    );

    logWriter.v('Job was created');
  } on Exception catch (e) {
    logWriter
      ..e('Failed to create the job')
      ..e('Reason: $e');

    exit(2);
  }

  final jobProcess = logWriter.p('Starting job ${job.name ?? job.id}...');

  for (final target in job.targets) {
    final targetProcess =
        logWriter.p('Start working with target "${target.name}"');

    final deliveryExecutor = target.executor;

    logWriter.v('Start execution process of "${deliveryExecutor.runtimeType}"');

    try {
      await deliveryExecutor.execute();
      logWriter.i('Successful delivery of target "${target.name}"');
    } on BuildExecutionException catch (e) {
      logWriter
        ..e('Failed to execute delivery ${deliveryExecutor.runtimeType} of target ${target.name}')
        ..e(e.errorMessage.toString());
    } on Exception catch (e) {
      logWriter
        ..e('Failed to execute delivery ${deliveryExecutor.runtimeType} of target ${target.name}')
        ..e('Reason: $e');
    }

    targetProcess.finish(
      message: 'Target ${target.name} is finished.',
      showTiming: true,
    );
  }

  jobProcess.finish(message: 'Finish working with job.', showTiming: true);
}

List<DeliveryTarget> _createDeliveryTargets({
  required DeliveryConfigJob from,
  required bool useFvmByConfig,
}) {
  final useFvmByJob = useFvmByConfig || (from.useFvm ?? false);

  return from.targets.map((targetConfig) {
    final useFvmByTarget = useFvmByJob || (targetConfig.useFvm ?? false);

    final DeliveryExecutor executor;

    switch (targetConfig.to) {
      case DeliveryConfigTargetDestination.local:
        executor = LocalDeliveryExecutor(BuildExecutor.createBuildExecutor(
          configTargetType: targetConfig.type,
          additionalArguments: targetConfig.args,
          useFvm: useFvmByTarget,
        ));
        break;
      case DeliveryConfigTargetDestination.firebase:
        throw UnimplementedError('No yet');
      case DeliveryConfigTargetDestination.playConsole:
        throw UnimplementedError('No yet');
      case DeliveryConfigTargetDestination.testFlight:
        throw UnimplementedError('No yet');
    }

    return DeliveryTarget(name: targetConfig.name, executor: executor);
  }).toList();
}
