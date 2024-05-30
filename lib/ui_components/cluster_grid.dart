import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kaporal/models/common/cluster.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class ClusterGrid extends StatelessWidget {
  final List<Cluster> clusters;

  const ClusterGrid({super.key, required this.clusters});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: clusters.length,
      padding: const EdgeInsets.all(AppMargins.XL),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300),
      itemBuilder: (BuildContext context, int index) {
        return ClusterGridTile(
          cluster: clusters[index],
        );
      },
    );
  }
}

class ClusterGridTile extends StatelessWidget {
  final Cluster cluster;
  const ClusterGridTile({super.key, required this.cluster});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 290,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2xQcwKitRgXfqdi34DYlocPSEXD2G2zZipg&s',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Text(
                  cluster.metadata['name'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      cluster.metadata['type'] as String? ??
                          'Unknown cluster type',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
