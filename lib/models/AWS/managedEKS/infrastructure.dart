import 'package:kaporal/models/common/infrastructure.dart';

class AWSManagedCluster extends Infrastructure {
  @override
  String kind = 'AWSManagedCluster';

  @override
  String name;

  @override
  Map<String, dynamic> metadata = {};

  AWSManagedCluster({
    required this.name,
    List<String>? labels,
  }) {
    metadata['name'] = name;
    metadata['labels'] = '';
    metadata['labels'] = labels ?? <String>[];
  }
  
  @override
  Map<String, dynamic> spec = {};
}

class ManagedAWSInfrastructureRef extends InfrastructureRef {
  @override
  String kind = 'AWSManagedCluster';
  @override
  String name;

  ManagedAWSInfrastructureRef({required this.name});
}