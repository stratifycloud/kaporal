import 'package:kaporal/models/common/control_plane.dart';

class AWSManagedControlPlane extends ControlPlane {
  @override
  String kind = 'AWSManagedControlPlane';

  @override
  String name;

  @override
  Map<String, dynamic> metadata = {};

  @override
  Map<String, dynamic> spec = {};

  AWSManagedControlPlane({
    required this.name,
    List<String>? labels,
    required String eksClusterName,
    required String version,
    required String region,
    required String sshKeyName,
    List<String>? addons,
    Map<String, dynamic>? encryptionConfig,
    Map<String, dynamic>? endpointAccess,
    Map<String, dynamic>? iamAuthenticatorConfig,
    Map<String, dynamic>? logging,
    Map<String, dynamic>? network,
  }) {
    metadata['name'] = name;
    metadata['labels'] = labels ?? <String>[];

    spec['eksClusterName'] = eksClusterName;
    spec['version'] = version;
    spec['region'] = region;
    spec['sshKeyName'] = sshKeyName;
    spec['addons'] = addons ?? [];
    spec['encryptionConfig'] = encryptionConfig ?? {};
    spec['endpointAccess'] = endpointAccess ?? {};
    spec['iamAuthenticatorConfig'] = iamAuthenticatorConfig ?? {};
    spec['logging'] = logging ?? {};
    spec['network'] = network ?? {};
  }
}

class ManagedAWSControlPlaneRef extends ControlPlaneRef {
  String kind = 'AWSManagedControlPlane';
  @override
  String name;

  ManagedAWSControlPlaneRef({required this.name});
}