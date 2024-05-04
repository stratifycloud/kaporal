import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaporal/models/providers/AWS/aws_profile.dart';
import 'package:kaporal/services/constants.dart';
import 'package:kaporal/services/firestore.dart';
import 'package:kaporal/ui_components/custom_app_bar.dart';
import 'package:kaporal/ui_components/custom_button.dart';
import 'package:kaporal/ui_components/loading_snack_bar.dart';
import 'package:kaporal/ui_components/ui_constants.dart';
import 'package:kaporal/ui_components/ui_specs.dart';
import 'package:uuid/uuid.dart';

class CreateAWSProfilePage extends StatefulWidget {
  const CreateAWSProfilePage({super.key});

  @override
  State<CreateAWSProfilePage> createState() => _CreateAWSProfilePageState();
}

class _CreateAWSProfilePageState extends State<CreateAWSProfilePage> {
  final _createAWSProviderProfileFormKey = GlobalKey<FormState>();
  late bool _mfaEnabled;
  String? _selectedMachineFlavor;

  double widthRatio = 1.3;

  @override
  void initState() {
    super.initState();
    _mfaEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final String providerName = arguments['name'];
    final String providerRegion = arguments['region'];

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppMargins.M),
            child: SizedBox(
              width: 300,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppMargins.M),
                  child: Form(
                      key: _createAWSProviderProfileFormKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                                padding: EdgeInsets.all(AppMargins.M)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  widthRatio,
                              child: SvgPicture.asset(
                                awsLogoPath,
                                height: 100,
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.all(AppMargins.S)),
                            Text(
                              'AWS provider: [ $providerName ] - [ $providerRegion ]',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Padding(
                                padding: EdgeInsets.all(AppMargins.S)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    widthRatio,
                                child: CheckboxListTile(
                                  // TODO: change this when MFA is supported
                                  enabled: false,
                                  title: const Text("MFA Enabled"),
                                  value: _mfaEnabled,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _mfaEnabled = newValue ?? false;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity
                                      .leading, //  <-- leading Checkbox
                                )),
                            const Padding(
                                padding: EdgeInsets.all(AppMargins.XS)),
                            DropdownSearch(
                              items: awsMachineFlavors,
                              onChanged: (String? item) {
                                setState(() {
                                  _selectedMachineFlavor = item;
                                });
                              },
                              selectedItem: _selectedMachineFlavor,
                              validator: (String? item) {
                                if (item == null ||
                                    !(awsMachineFlavors.contains(item))) {
                                  return "Please select a machine flavor";
                                }
                                return null;
                              },
                            ),
                            Padding(
                                padding: const EdgeInsets.all(AppMargins.M),
                                child: CustomButton(
                                    onPressed: () async {
                                      if (_createAWSProviderProfileFormKey
                                          .currentState!
                                          .validate()) {
                                        try {
                                          FirestoreService.addProviderProfile(
                                            AWSProviderProfile(
                                              uid: const Uuid().v4(),
                                              name: providerName,
                                              awsRegion: providerRegion,
                                              defaultMachineSize:
                                                  _selectedMachineFlavor,
                                              mfaEnabled: _mfaEnabled,
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor:
                                                      AppColors.burntSienna,
                                                  content: Text(
                                                    e.toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )));
                                        }

                                        if (mounted) {
                                          showLoadingSnackBar(context,
                                              "Creating AWS provider profile...",
                                              color: AppColors.aero,
                                              durationSeconds: 2);
                                          Navigator.pushNamed(context, '/');
                                        }
                                      }
                                    },
                                    text: "Create")),
                          ])),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
