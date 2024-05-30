import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaporal/models/providers/AWS/aws_profile.dart';
import 'package:kaporal/models/providers/provider_profile.dart';
import 'package:kaporal/models/providers/provider_type.dart';
import 'package:kaporal/providers/profile_provider.dart';
import 'package:kaporal/screens/home/error.dart';
import 'package:kaporal/services/firestore.dart';
import 'package:kaporal/ui_components/custom_app_bar.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class CreateClusterPage extends ConsumerStatefulWidget {
  const CreateClusterPage({super.key});

  @override
  ConsumerState<CreateClusterPage> createState() => _CreateClusterPageState();
}

class _CreateClusterPageState extends ConsumerState<CreateClusterPage> {
  final _formKey = GlobalKey<FormState>();

  final _clusterNameController = TextEditingController();
  final _minNodesController = TextEditingController();
  final _maxNodesController = TextEditingController();
  String? _controlPlaneNodeFlavor;
  String? _workerNodeFlavor;
  late ProviderProfile _currentProviderProfile;

  Map<String, List<String>> _flavorOptions = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _flavorOptions = FirestoreService.getAvailableFlavors();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> currentProviderData =
        (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?) ??
            {};
    final currentProviderType = currentProviderData['type'] as ProviderType;

    final profileProviderRef = ref.watch(profileProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: profileProviderRef.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => const ErrorPage(),
        data: (data) {
          if (_controlPlaneNodeFlavor == null) {
            if (data[currentProviderType] != null) {
              try {
                _currentProviderProfile = data[currentProviderType]!.firstWhere(
                  (element) => element.uid = currentProviderData['uid'],
                );
                setState(() {
                  _controlPlaneNodeFlavor =
                      _currentProviderProfile.defaultMachineSize;
                });
                // ignore: empty_catches
              } catch (e) {}

              switch (currentProviderType) {
                default:
                  break;
              }
            }
          }
          if (_workerNodeFlavor == null) {}
          return SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(AppMargins.M),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            "Create a new cluster",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: AppMargins.M,
                          ),
                          Text(
                            "Using ${currentProviderType.name} provider profile:  ${currentProviderData['name']}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: AppMargins.M,
                          ),
                          Form(
                            key: _formKey,
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                // Cluster Name
                                TextFormField(
                                  controller: _clusterNameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Cluster name',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a cluster name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16.0),

                                // Min nodes and Max nodes
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
                                        controller: _minNodesController,
                                        decoration: const InputDecoration(
                                          labelText: 'Min nodes',
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter min nodes';
                                          }
                                          if (int.tryParse(value) == null) {
                                            return 'Please enter a valid number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _maxNodesController,
                                        decoration: const InputDecoration(
                                          labelText: 'Max nodes',
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter max nodes';
                                          }
                                          if (int.tryParse(value) == null) {
                                            return 'Please enter a valid number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),

                                // Control plane node flavor
                                DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: 'Control plane node flavor',
                                  ),
                                  value: _controlPlaneNodeFlavor,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        _controlPlaneNodeFlavor = newValue;
                                      });
                                    }
                                  },
                                  items:
                                      _flavorOptions[currentProviderType.name]!
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select a flavor';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16.0),

                                // Worker node flavor
                                DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: 'Worker node flavor',
                                  ),
                                  value: _workerNodeFlavor,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        _workerNodeFlavor = newValue;
                                      });
                                    }
                                  },
                                  items:
                                      _flavorOptions[currentProviderType.name]!
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select a flavor';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16.0),

                                // Submit button
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Process data
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                    }
                                  },
                                  child: const Text('Submit'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
