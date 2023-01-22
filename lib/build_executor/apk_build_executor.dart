import 'package:flutter_delivery_tool/build_executor/android_build_executor.dart';

class ApkBuildExecutor extends AndroidBuildExecutor {
  @override
  String get buildTargetName => 'apk';

  @override
  final List<String> additionalArguments;

  @override
  final bool useFvm;

  ApkBuildExecutor(this.additionalArguments, this.useFvm);
}
