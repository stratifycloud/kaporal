abstract class Infrastructure {
  String apiVersion = 'infrastructure.cluster.x-k8s.io/v1beta2';
  abstract String kind;
  abstract String name;
  abstract Map<String, dynamic> metadata;
  abstract Map<String, dynamic> spec;
}

abstract class InfrastructureRef {
  String apiVersion = 'infrastructure.cluster.x-k8s.io/v1beta2';
  abstract String kind;
  abstract String name;
}