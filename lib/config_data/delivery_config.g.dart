// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryConfig _$DeliveryConfigFromJson(Map json) => $checkedCreate(
      'DeliveryConfig',
      json,
      ($checkedConvert) {
        final val = DeliveryConfig(
          useFvm: $checkedConvert('use_fvm', (v) => v as bool?),
          outputPath: $checkedConvert('output_path', (v) => v as String?),
          buildArgs: $checkedConvert(
              'build_args',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
          jobs: $checkedConvert(
              'jobs',
              (v) => (v as Map).map(
                    (k, e) => MapEntry(
                        k as String,
                        DeliveryConfigJob.fromJson(
                            Map<String, dynamic>.from(e as Map))),
                  )),
        );
        return val;
      },
      fieldKeyMap: const {
        'useFvm': 'use_fvm',
        'outputPath': 'output_path',
        'buildArgs': 'build_args'
      },
    );

Map<String, dynamic> _$DeliveryConfigToJson(DeliveryConfig instance) =>
    <String, dynamic>{
      'use_fvm': instance.useFvm,
      'output_path': instance.outputPath,
      'build_args': instance.buildArgs,
      'jobs': instance.jobs,
    };

DeliveryConfigJob _$DeliveryConfigJobFromJson(Map json) => $checkedCreate(
      'DeliveryConfigJob',
      json,
      ($checkedConvert) {
        final val = DeliveryConfigJob(
          name: $checkedConvert('name', (v) => v as String?),
          useFvm: $checkedConvert('use_fvm', (v) => v as bool?),
          targets: $checkedConvert(
              'targets',
              (v) => (v as List<dynamic>)
                  .map((e) => DeliveryConfigTarget.fromJson(
                      Map<String, dynamic>.from(e as Map)))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'useFvm': 'use_fvm'},
    );

Map<String, dynamic> _$DeliveryConfigJobToJson(DeliveryConfigJob instance) =>
    <String, dynamic>{
      'name': instance.name,
      'use_fvm': instance.useFvm,
      'targets': instance.targets,
    };

DeliveryConfigTarget _$DeliveryConfigTargetFromJson(Map json) => $checkedCreate(
      'DeliveryConfigTarget',
      json,
      ($checkedConvert) {
        final val = DeliveryConfigTarget(
          $checkedConvert('name', (v) => v as String),
          $checkedConvert(
              'type', (v) => $enumDecode(_$DeliveryConfigTargetTypeEnumMap, v)),
          $checkedConvert('to',
              (v) => $enumDecode(_$DeliveryConfigTargetDestinationEnumMap, v)),
          $checkedConvert('args',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          $checkedConvert('use_fvm', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {'useFvm': 'use_fvm'},
    );

Map<String, dynamic> _$DeliveryConfigTargetToJson(
        DeliveryConfigTarget instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': _$DeliveryConfigTargetTypeEnumMap[instance.type]!,
      'to': _$DeliveryConfigTargetDestinationEnumMap[instance.to]!,
      'args': instance.args,
      'use_fvm': instance.useFvm,
    };

const _$DeliveryConfigTargetTypeEnumMap = {
  DeliveryConfigTargetType.apk: 'apk',
  DeliveryConfigTargetType.appBundle: 'appbundle',
  DeliveryConfigTargetType.ipa: 'ipa',
};

const _$DeliveryConfigTargetDestinationEnumMap = {
  DeliveryConfigTargetDestination.local: 'local',
  DeliveryConfigTargetDestination.firebase: 'firebase',
  DeliveryConfigTargetDestination.playConsole: 'play_console',
  DeliveryConfigTargetDestination.testFlight: 'test_flight',
};
