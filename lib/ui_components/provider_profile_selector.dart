import 'package:flutter/material.dart';
import 'package:kaporal/models/providers/AWS/aws_profile.dart';
import 'package:kaporal/models/providers/provider_profile.dart';
import 'package:kaporal/models/providers/provider_type.dart';
import 'package:kaporal/services/firestore.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class ProviderProfileSelector extends StatefulWidget {
  const ProviderProfileSelector({super.key});

  @override
  State<ProviderProfileSelector> createState() =>
      _ProviderProfileSelectorState();
}

class _ProviderProfileSelectorState extends State<ProviderProfileSelector> {
  late List<ProviderType> providerTypes;
  // late Future<Map<ProviderType, List<ProviderProfile>>> _providerProfiles;

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    // _providerProfiles = FirestoreService.getUserProviderProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreService.getUserProviderProfiles(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<ProviderType, List<ProviderProfile>> providerProfiles =
                snapshot.data!;

            providerTypes = providerProfiles.keys.toList();
            providerTypes.sort();
            return providerTypes.isNotEmpty
                ? Card(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text(
                      "Select one of your existing provider profiles:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(AppMargins.M),
                        child: Card(
                          child: ListView.builder(
                            itemCount: providerTypes.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ExpansionTile(
                                  // TODO: make a prettier name for these enum values
                                  title: Text(
                                      "${providerTypes[index].name} (${providerProfiles[providerTypes[index]]!.length})"),
                                  children: [
                                    Wrap(
                                      children: List.generate(
                                          providerProfiles[
                                                  providerTypes[index]]!
                                              .length, (profilesIndex) {
                                        return SizedBox(
                                            child: Card(
                                          child: Column(
                                            children: [
                                              Text(
                                                providerProfiles[providerTypes[
                                                        index]]![profilesIndex]
                                                    .name,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ));
                                      }),
                                    ),
                                  ]);
                            },
                          ),
                        ))
                  ]))
                : Container();
          } else if (snapshot.hasError) {
            Navigator.pushNamed(context, '/error',
                arguments: {'message': snapshot.error.toString()});
          }
          return const Card(
            child: CircularProgressIndicator(),
          );
        });
  }
}
