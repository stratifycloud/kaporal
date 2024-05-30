import 'package:kaporal/models/providers/provider_type.dart';

abstract class ProviderProfile {
  ProviderType providerType = ProviderType.unknown;
  String name = '';
  String uid = '';
  String? defaultMachineSize;

  ProviderProfile(
      {required this.providerType,
      required this.name,
      this.defaultMachineSize});

  ProviderProfile.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
