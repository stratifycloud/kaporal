import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaporal/models/providers/provider_profile.dart';
import 'package:kaporal/models/providers/provider_type.dart';
import 'package:kaporal/providers/shared_preference_provider.dart';
import 'package:kaporal/ui_components/ui_specs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderProfileSelector extends ConsumerStatefulWidget {
  final Map<ProviderType, List<ProviderProfile>> providerProfiles;

  const ProviderProfileSelector({super.key, required this.providerProfiles});

  @override
  ConsumerState<ProviderProfileSelector> createState() =>
      _ProviderProfileSelectorState();
}

class _ProviderProfileSelectorState
    extends ConsumerState<ProviderProfileSelector> {
  late final SharedPreferences prefs;
  late final String? providerProfileUid;
  late final ProviderType providerType;
  ProviderProfile? _selectedProvider;

  late List<ProviderType> providerTypes;
  bool _confirmEnabled = false;

  @override
  void initState() {
    super.initState();
    providerTypes = widget.providerProfiles.keys.toList();
    providerTypes.sort();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();

    providerProfileUid = prefs.getString("providerProfileUid");

    switch (prefs.getString("providerType")) {
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

    if (providerTypes.contains(providerType)) {
      for (var provider in widget.providerProfiles[providerType]!) {
        if (provider.uid == providerProfileUid) {
          _selectedProvider = provider;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return providerTypes.isNotEmpty
        ? Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                children: [
                  const Text(
                    "Select one of your existing provider profiles:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Opacity(
                    opacity: (_confirmEnabled && _selectedProvider != null)
                        ? 1
                        : 0.5,
                    child: TextButton.icon(
                        onPressed: () async {
                          if (_confirmEnabled && _selectedProvider != null) {
                            await prefs.setString(
                                'providerProfileUid', _selectedProvider!.uid);
                            await prefs.setString(
                                'providerProfileName', _selectedProvider!.name);
                            await prefs.setString('providerType',
                                _selectedProvider!.providerType.name);
                            if (mounted) {
                              ref.refresh(currentProfileProvider);
                              Navigator.of(context).pushNamed('/');
                            }
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text("Confirm")),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(AppMargins.M),
                  child: Card(
                    child: ListView.builder(
                      itemCount: providerTypes.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                            // TODO: make a prettier name for these enum values
                            title: Text(
                                "${providerTypes[index].name} (${widget.providerProfiles[providerTypes[index]]!.length})"),
                            children: [
                              Wrap(
                                children: List.generate(
                                    widget
                                        .providerProfiles[providerTypes[index]]!
                                        .length, (profilesIndex) {
                                  return ListTile(
                                    leading: Radio<ProviderProfile>(
                                      value: widget.providerProfiles[
                                          providerTypes[index]]![profilesIndex],
                                      groupValue: _selectedProvider,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedProvider = value;
                                          _confirmEnabled = true;
                                        });
                                      },
                                    ),
                                    title: Text(
                                      widget
                                          .providerProfiles[providerTypes[
                                              index]]![profilesIndex]
                                          .name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }),
                              ),
                            ]);
                      },
                    ),
                  ))
            ]),
          )
        : Container();
  }
}
