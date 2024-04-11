abstract class ControlPlane {
  String apiVersion = 'controlplane.cluster.x-k8s.io/v1beta2';
  abstract String kind;
  abstract String name;
  abstract Map<String, dynamic> metadata;
  abstract Map<String, dynamic> spec;
}

abstract class ControlPlaneRef {
  String apiVersion = 'controlplane.cluster.x-k8s.io/v1beta2';
  abstract String name;
}
