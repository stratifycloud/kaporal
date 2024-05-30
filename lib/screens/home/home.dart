import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaporal/models/AWS/managedEKS/infrastructure.dart';
import 'package:kaporal/models/common/cluster.dart';
import 'package:kaporal/models/providers/provider_type.dart';
import 'package:kaporal/providers/shared_preference_provider.dart';
import 'package:kaporal/screens/capi/select_provider.dart';
import 'package:kaporal/screens/home/error.dart';
import 'package:kaporal/ui_components/cluster_grid.dart';
import 'package:kaporal/ui_components/custom_app_bar.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late List<Cluster>? _clusters;

  @override
  void initState() {
    super.initState();
    // TODO: fetch clusters for current provider here
    _clusters = clusters;
  }

  @override
  Widget build(BuildContext context) {
    final providerRef = ref.watch(currentProfileProvider);
    return providerRef.when(
      error: (error, stack) {
        return const ErrorPage();
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      data: (providerData) {
        final providerType = providerData['type'] as ProviderType;
        if (providerType == ProviderType.unknown ||
            providerData['uid'] == 'unknown') {
          return const SelectProviderPage();
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const CustomAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 6,
                  vertical: AppMargins.XL),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 170),
                        child: ElevatedButton.icon(
                            icon: const Icon(Icons.change_circle_outlined),
                            label: const Text("Change profile"),
                            onPressed: () {
                              Navigator.pushNamed(context, '/select-provider');
                            }),
                      ),
                      const SizedBox(
                        width: AppMargins.M,
                      ),
                      Flexible(
                        child: Text(
                          "Current profile: ${providerType.name} - ${providerData['name']}",
                        ),
                      ),
                      const SizedBox(
                        width: AppMargins.M,
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 170),
                        child: ElevatedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text("Create cluster"),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/create-cluster',
                                arguments: providerData,
                              );
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppMargins.S,
                  ),
                  ClusterGrid(clusters: clusters)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// List<Cluster> clusters = [];
List<Cluster> clusters = [
  Cluster(
    name: 'EKS Cluster 1',
    type: "AWS Managed Cluster",
    infrastructureRef: ManagedAWSInfrastructureRef(name: "AWSCluster1"),
  ),
  Cluster(
    name: 'EKS Cluster 2',
    type: "AWS Managed Cluster",
    infrastructureRef: ManagedAWSInfrastructureRef(name: "AWSCluster2"),
  ),
  Cluster(
    name: 'EKS Cluster 3',
    type: "AWS Managed Cluster",
    infrastructureRef: ManagedAWSInfrastructureRef(name: "AWSCluster3"),
  ),
];
