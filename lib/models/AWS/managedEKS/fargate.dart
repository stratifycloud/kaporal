class AWSFargateProfile {
  String apiVersion = 'infrastructure.cluster.x-k8s.io/v1beta2';
  String kind = 'AWSFargateProfile';

  Map<String, dynamic> metadata = {};

  Map<String, dynamic> spec = {};

  AWSFargateProfile({
    required String name,
    List<String>? labels,
    required String clusterName,
    String namespace = 'default',
    Map<String, String>? selectorLabels,
  }) {
    metadata['name'] = name;
    metadata['labels'] = labels ?? [];

    spec['clusterName'] = clusterName;
    spec['selectors'] = [{
      'namespace': namespace,
      'labels': {
        selectorLabels
      }
    }];
  }
}