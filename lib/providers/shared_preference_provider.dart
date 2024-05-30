import 'package:kaporal/models/providers/provider_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesFutureProvider =
    FutureProvider<SharedPreferences>((ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences;
});

final currentProfileProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final sharedPreferences =
      await ref.watch(sharedPreferencesFutureProvider.future);

  ProviderType providerType;
  switch (sharedPreferences.getString("providerType")) {
    case 'aws':
      providerType = ProviderType.aws;
      break;
    case 'azure':
      providerType = ProviderType.azure;
      break;
    case 'gcp':
      providerType = ProviderType.gcp;
      break;
    default:
      providerType = ProviderType.unknown;
      break;
  }

  return {
    'name': sharedPreferences.getString('providerProfileName') ?? 'unknown',
    'uid': sharedPreferences.getString('providerProfileUid') ?? 'unknown',
    'type': providerType,
  };
});
