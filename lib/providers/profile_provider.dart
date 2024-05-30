import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaporal/models/providers/provider_profile.dart';
import 'package:kaporal/models/providers/provider_type.dart';
import 'package:kaporal/services/firestore.dart';

final profileProvider =
    FutureProvider<Map<ProviderType, List<ProviderProfile>>>((ref) async {
  final providerProfiles = await FirestoreService.getUserProviderProfiles();
  return providerProfiles;
});
