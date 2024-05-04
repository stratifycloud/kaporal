import 'package:flutter/material.dart';
import 'package:kaporal/models/providers/AWS/aws_profile.dart';
import 'package:kaporal/models/providers/provider_profile.dart';
import 'package:kaporal/models/providers/provider_type.dart';
import 'package:kaporal/ui_components/custom_app_bar.dart';
import 'package:kaporal/ui_components/provider_list_tile.dart';
import 'package:kaporal/ui_components/provider_profile_selector.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class SelectProviderPage extends StatefulWidget {
  const SelectProviderPage({super.key});

  @override
  State<SelectProviderPage> createState() => _ConfigureProviderPageState();
}

class _ConfigureProviderPageState extends State<SelectProviderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, AppMargins.L, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 767,
                child: ProviderProfileSelector(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppMargins.M),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 767,
                child: Card(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(AppMargins.S),
                        child: Text(
                          "Configure a new provider profile",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppMargins.M),
                        child: Wrap(
                          children: providerGridTiles,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

List<Widget> providerGridTiles = [
  const ProviderSelectionTile(providerType: ProviderType.aws, enabled: true),
  const ProviderSelectionTile(providerType: ProviderType.azure, enabled: false),
  const ProviderSelectionTile(providerType: ProviderType.gcp, enabled: false),
];
