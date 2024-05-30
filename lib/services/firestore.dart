import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaporal/models/providers/AWS/aws_profile.dart';
import 'package:kaporal/models/providers/provider_profile.dart';
import 'package:kaporal/models/providers/provider_type.dart';

class FirestoreService {
  static Future<void> addUser(User user) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Call the user's CollectionReference to add a new user
    return users
        .doc(user.uid)
        .set({
          'uid': user.uid,
          'email': user.email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<void> addProviderProfile(ProviderProfile profile) async {
    CollectionReference providerProfiles = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('provider-profiles');

    providerProfiles.doc(profile.uid).set(profile.toJson());
    // handleProviderSensitiveData(profile);
  }

  static Future<Map<ProviderType, List<ProviderProfile>>>
      getUserProviderProfiles() async {
    Map<ProviderType, List<ProviderProfile>> providerProfiles = {};

    CollectionReference providerProfileCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('provider-profiles');

    var profileSnapshot = await providerProfileCollection.get();
    for (var doc in profileSnapshot.docs) {
      Map<String, dynamic> jsonData = doc.data() as Map<String, dynamic>;

      var type = ProviderType.values.byName(jsonData['type']);
      switch (type) {
        case ProviderType.aws:
          var profile = AWSProviderProfile.fromJson(jsonData);
          if (providerProfiles[ProviderType.aws] == null) {
            providerProfiles[ProviderType.aws] = <ProviderProfile>[];
          }
          providerProfiles[ProviderType.aws]!.add(profile);
          break;
        default:
          continue;
      }
    }

    return providerProfiles;
  }

  static Map<String, List<String>> getAvailableFlavors() {
    Map<String, List<String>> flavors = {};

    // TODO: fetch from firestore
    flavors = {
      'aws': ['r5.xlarge', 't3.medium', 't3.xlarge'],
      'azure': ['mock']
    };

    return flavors;
  }
}
