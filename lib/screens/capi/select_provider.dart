import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaporal/models/providers/provider_type.dart';
import 'package:kaporal/providers/profile_provider.dart';
import 'package:kaporal/screens/capi/AWS/create_aws_profile.dart';
import 'package:kaporal/screens/capi/create_provider_profile.dart';
import 'package:kaporal/screens/home/error.dart';
import 'package:kaporal/ui_components/custom_app_bar.dart';
import 'package:kaporal/ui_components/provider_list_tile.dart';
import 'package:kaporal/ui_components/provider_profile_selector.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class SelectProviderPage extends ConsumerStatefulWidget {
  const SelectProviderPage({super.key});
  final bool enableAws = true;
  final bool enableAzure = false;
  final bool enableGcp = false;

  @override
  ConsumerState<SelectProviderPage> createState() => _SelectProviderPageState();
}

class _SelectProviderPageState extends ConsumerState<SelectProviderPage> {
  ProviderType _newProviderType = ProviderType.unknown;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _drawerNavigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final profileProviderRef = ref.watch(profileProvider);

    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: Drawer(
        child: Scaffold(
          body: Navigator(
            key: _drawerNavigatorKey,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/configure-aws-provider':
                  return MaterialPageRoute(
                    settings: settings,
                    builder: (context) => const CreateAWSProfilePage(),
                  );
                case '/configure-azure-provider':
                case '/configure-gcp-provider':
                default:
                  return MaterialPageRoute(
                    settings: settings,
                    builder: (context) =>
                        CreateProviderProfile(providerType: _newProviderType),
                  );
              }
            },
          ),
        ),
      ),
      //
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: profileProviderRef.when(
        error: (error, stackTrace) => const ErrorPage(),
        loading: () => const CircularProgressIndicator(),
        data: (providerProfiles) {
          return SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, AppMargins.L, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 767,
                      child: ProviderProfileSelector(
                        providerProfiles: providerProfiles,
                      ),
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
                          mainAxisSize: MainAxisSize.min,
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
                                children: [
                                  InkWell(
                                    enableFeedback: widget.enableAws,
                                    onTap: () {
                                      setState(() {
                                        _newProviderType = ProviderType.aws;
                                      });
                                      if (widget.enableAws &&
                                          _scaffoldKey.currentState != null &&
                                          _newProviderType !=
                                              ProviderType.unknown) {
                                        _scaffoldKey.currentState!
                                            .openEndDrawer();
                                      }
                                    },
                                    child: ProviderSelectionTile(
                                      providerType: ProviderType.aws,
                                      enabled: widget.enableAws,
                                    ),
                                  ),
                                  InkWell(
                                    enableFeedback: widget.enableAzure,
                                    onTap: () {
                                      setState(() {
                                        _newProviderType = ProviderType.azure;
                                      });
                                      if (widget.enableAzure &&
                                          _scaffoldKey.currentState != null &&
                                          _newProviderType !=
                                              ProviderType.unknown) {
                                        _scaffoldKey.currentState!
                                            .openEndDrawer();
                                      }
                                    },
                                    child: ProviderSelectionTile(
                                        providerType: ProviderType.azure,
                                        enabled: widget.enableAzure),
                                  ),
                                  InkWell(
                                    enableFeedback: widget.enableGcp,
                                    onTap: () {
                                      setState(() {
                                        _newProviderType = ProviderType.gcp;
                                      });
                                      if (widget.enableGcp &&
                                          _scaffoldKey.currentState != null &&
                                          _newProviderType !=
                                              ProviderType.unknown) {
                                        _scaffoldKey.currentState!
                                            .openEndDrawer();
                                      }
                                    },
                                    child: ProviderSelectionTile(
                                        providerType: ProviderType.gcp,
                                        enabled: widget.enableGcp),
                                  ),
                                ],
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
        },
      ),
    );
  }
}
