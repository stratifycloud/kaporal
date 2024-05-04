import 'package:flutter/material.dart';
import 'package:kaporal/models/common/cluster.dart';
import 'package:kaporal/models/providers/provider_type.dart';
import 'package:kaporal/ui_components/cluster_grid.dart';
import 'package:kaporal/ui_components/custom_app_bar.dart';
import 'package:kaporal/ui_components/custom_button.dart';
import 'package:kaporal/ui_components/ui_specs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final SharedPreferences prefs;
  late List<Cluster>? clusters;
  late String? providerProfileName;
  late ProviderType providerType;

  @override
  void initState() {
    super.initState();
    // TODO: fetch clusters for current provider here
    clusters = [];
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    prefs = await SharedPreferences.getInstance();

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

    providerProfileName = prefs.getString("providerProfileName");

    if (providerProfileName == null && mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/select-provider', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 6,
            vertical: AppMargins.XXL),
        child: Column(
          children: [
            AppBar(
              title: const Text("Current active provider: AWS"),
              actions: [
                CustomButton(
                    text: "+ Create",
                    onPressed: () {
                      Navigator.pushNamed(context, '/create-cluster');
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppMargins.M),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        MenuBar(children: [CustomButton(onPressed: () {})])
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [ClusterGrid(clusters: clusters ?? [])],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Cluster> clusters = [];
// List<Cluster> clusters = [
//   Cluster(
//     name: 'My AWS Cluster',
//     provider: 'AWS',
//     nodes: 1,
//     maxNodes: 3,
//   ),
//   Cluster(
//     name: 'My Azure Cluster',
//     provider: 'Azure',
//     nodes: 1,
//     maxNodes: 3,
//   ),
//   Cluster(
//     name: 'My GCP Cluster',
//     provider: 'GCP',
//     nodes: 1,
//     maxNodes: 3,
//   ),
// ];