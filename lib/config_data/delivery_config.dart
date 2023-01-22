// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:checked_yaml/checked_yaml.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

part 'delivery_config.g.dart';

/// Data-class for delivery config.
///
/// Using delivery_config.yaml data.
@JsonSerializable()
class DeliveryConfig {
  /// Will add `fvm` to every flutter call.
  ///
  /// Can be overrided by child config properties.
  final bool? useFvm;

  /// Where build artifacts will lie.
  final String? outputPath;

  /// Build args that will be added to every job by default.
  final List<String> buildArgs;

  final Map<String, DeliveryConfigJob> jobs;

  /// Creates instance.
  DeliveryConfig({
    this.useFvm,
    this.outputPath,
    this.buildArgs = const [],
    required this.jobs,
  });

  factory DeliveryConfig.fromJson(Map json) => _$DeliveryConfigFromJson(json);
}

@JsonSerializable()
class DeliveryConfigJob {
  final String? name;

  final bool? useFvm;

  final List<DeliveryConfigTarget> targets;

  /// Creates instance.
  DeliveryConfigJob({
    this.name,
    this.useFvm,
    required this.targets,
  });

  factory DeliveryConfigJob.fromJson(Map<String, dynamic> json) =>
      _$DeliveryConfigJobFromJson(json);
}

@JsonSerializable()
class DeliveryConfigTarget {
  final String name;

  final DeliveryConfigTargetType type;

  final DeliveryConfigTargetDestination to;

  final List<String> args;

  final bool? useFvm;

  DeliveryConfigTarget(this.name, this.type, this.to, this.args, this.useFvm);

  factory DeliveryConfigTarget.fromJson(Map<String, dynamic> json) =>
      _$DeliveryConfigTargetFromJson(json);
}

enum DeliveryConfigTargetDestination {
  @JsonValue('local')
  local,

  @JsonValue('firebase')
  firebase,

  @JsonValue('play_console')
  playConsole,

  @JsonValue('test_flight')
  testFlight,
}

enum DeliveryConfigTargetType {
  @JsonValue('apk')
  apk,

  @JsonValue('appbundle')
  appBundle,

  @JsonValue('ipa')
  ipa,
}
