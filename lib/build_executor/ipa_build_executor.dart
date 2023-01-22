import 'package:flutter_delivery_tool/build_executor/ios_build_executor.dart';

class IpaBuildExecutor extends IosBuildExecutor {
  @override
  String get buildTargetName => 'ipa';

  @override
  final List<String> additionalArguments;

  @override
  final bool useFvm;

  IpaBuildExecutor(this.additionalArguments, this.useFvm);
}
