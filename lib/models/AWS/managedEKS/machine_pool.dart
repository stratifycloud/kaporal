import 'package:kaporal/models/common/machine_pool.dart';

class AWSManagedMachinePoolRef extends MachinePoolInfrastructureRef {
  @override
  String kind = 'AWSManagedMachinePool';
  @override
  String name;

  AWSManagedMachinePoolRef({required this.name});
}

class AWSManagedMachinePool {
  String kind = 'AWSManagedMachinePool';

  Map<String, dynamic> metadata = {};

  Map<String, dynamic> spec = {};

  AWSManagedMachinePool({
    required String name,
    List<String>? labels,
    required String instanceType,
    required String minSize,
    required String maxSize,
  }) {
    metadata['name'] = name;
    metadata['labels'] = labels ?? [];

    spec['instanceType'] = instanceType;
    spec['scaling'] = {
      'minSize': minSize,
      'maxSize': maxSize,
    };
  }
}