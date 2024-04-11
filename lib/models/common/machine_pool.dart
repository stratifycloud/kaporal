abstract class MachinePool {
  String apiVersion = 'cluster.x-k8s.io/v1beta1';
  String kind = 'MachinePool';

  abstract Map<String, dynamic> metadata;
  abstract Map<String, dynamic> spec;

  MachinePool({
    required String name,
    List<String>? labels,
    required String clusterName,
    required String dataSecretName,
    required MachinePoolInfrastructureRef machinePoolInfrastructureRef,
  }) {
    metadata['name'] = name;
    metadata['labels'] = labels ?? [];

    spec['clusterName'] = clusterName;

    Map<String, dynamic> templateSpec = {};

    templateSpec['bootstrap'] = { 'dataSecretName': dataSecretName };
    templateSpec['clusterName'] = clusterName;
    templateSpec['infrastructureRef'] = machinePoolInfrastructureRef;
  
    spec['template'] = { 'spec': templateSpec };
  }
}

abstract class MachinePoolInfrastructureRef {
  String apiVersion = 'infrastructure.cluster.x-k8s.io/v1beta2';
  abstract String kind;
  abstract String name;
}
