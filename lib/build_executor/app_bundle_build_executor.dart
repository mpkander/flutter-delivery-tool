import 'package:flutter_delivery_tool/build_executor/android_build_executor.dart';

class AppBundleBuildExecutor extends AndroidBuildExecutor {
  @override
  String get buildTargetName => 'appbundle';

  @override
  final List<String> additionalArguments;

  @override
  final bool useFvm;

  AppBundleBuildExecutor(this.additionalArguments, this.useFvm);
}
