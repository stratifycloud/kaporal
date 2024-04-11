import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kaporal/models/common/cluster.dart';
import 'package:kaporal/ui_components/cluster_grid.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.moonstone,
        title: const Text("Kaporal"),
      ),
      body: GridView.builder(
            itemCount: clusters.length,
            padding: const EdgeInsets.all(AppMargins.XL),
            gridDelegate: ClusterGridDelegate(dimension: 240.0),
            // Try uncommenting some of these properties to see the effect on the grid:
            // itemCount: 20, // The default is that the number of grid tiles is infinite.
            // scrollDirection: Axis.horizontal, // The default is vertical.
            // reverse: true, // The default is false, going down (or left to right).
            itemBuilder: (BuildContext context, int index) {
              return ClusterGridTile(cluster: clusters[index],);
            },
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