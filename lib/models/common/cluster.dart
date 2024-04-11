import 'package:kaporal/models/common/infrastructure.dart';

class Cluster {
  String apiVersion = 'cluster.x-k8s.io/v1beta1';
  String kind = 'Cluster';
  Map<String, Object> metadata = {};
  InfrastructureRef infrastructureRef;

  Cluster({
    required String name,
    List<String>? labels,
    required this.infrastructureRef,
  }) {
    metadata['name'] = name;
    metadata['labels'] = labels ?? <String>[];
  }
}
