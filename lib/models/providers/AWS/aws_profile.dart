import 'package:kaporal/models/providers/provider_profile.dart';
import 'package:kaporal/models/providers/provider_type.dart';

class AWSProviderProfile implements ProviderProfile {
  @override
  ProviderType providerType = ProviderType.aws;

  @override
  String? defaultMachineSize;

  // Only non-sensitive data is stored in this model
  String awsRegion;
  bool mfaEnabled;

  @override
  String name;
  @override
  String uid;

  AWSProviderProfile({
    required this.uid,
    required this.name,
    required this.awsRegion,
    this.mfaEnabled = false,
    this.defaultMachineSize,
  });

  factory AWSProviderProfile.fromJson(Map<String, Object?> json) {
    return AWSProviderProfile(
      uid: json['uid'] as String,
      name: json['name'] as String,
      awsRegion: json['awsRegion'] as String,
      mfaEnabled: json['mfaEnabled'] as bool,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'awsRegion': awsRegion,
      'mfaEnabled': mfaEnabled,
      'type': providerType.name,
    };
  }
}
