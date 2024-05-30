import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaporal/models/providers/provider_type.dart';
import 'package:kaporal/services/constants.dart';
import 'package:kaporal/ui_components/custom_button.dart';
import 'package:kaporal/ui_components/custom_textfield.dart';
import 'package:kaporal/ui_components/ui_constants.dart';
import 'package:kaporal/ui_components/ui_specs.dart';

class CreateProviderProfile extends StatefulWidget {
  final ProviderType providerType;

  const CreateProviderProfile({super.key, required this.providerType});

  @override
  State<CreateProviderProfile> createState() => _CreateProviderProfileState();
}

class _CreateProviderProfileState extends State<CreateProviderProfile> {
  final _createProviderProfileFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedRegion;

  double widthRatio = 1.3;

  @override
  void initState() {
    super.initState();
    _selectedRegion = 'Region...';
  }

  @override
  Widget build(BuildContext context) {
    String providerConfigurationPageRoute = '/';
    String providerLogoImageSource = 'assets/images/logo.png';
    List<String> availableRegions = [];

    switch (widget.providerType) {
      case ProviderType.aws:
        providerConfigurationPageRoute = '/configure-aws-provider';
        providerLogoImageSource = awsLogoPath;
        availableRegions = awsRegions;
        break;
      case ProviderType.azure:
        providerConfigurationPageRoute = '/configure-azure-provider';
        providerLogoImageSource = azureLogoPath;
        availableRegions = azureRegions;
        break;
      case ProviderType.gcp:
        providerConfigurationPageRoute = '/configure-gcp-provider';
        providerLogoImageSource = gcpLogoPath;
        availableRegions = gcpRegions;
        break;
      case ProviderType.unknown:
        // TODO: handle this case better
        break;
    }

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(AppMargins.L),
            child: Form(
                key: _createProviderProfileFormKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.all(AppMargins.M)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / widthRatio,
                        child: SvgPicture.asset(
                          providerLogoImageSource,
                          height: 100,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(AppMargins.S)),
                      Text(
                        'Configure new ${widget.providerType.name} provider:',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Padding(padding: EdgeInsets.all(AppMargins.S)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / widthRatio,
                        child: CustomTextField(
                          label: "Name",
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return "An name is required";
                            }
                            // TODO: change regexp to support other chars (e.g. hyphens)
                            if (!RegExp(r'\S+').hasMatch(val)) {
                              return "The name must only contain alphanumeric values";
                            }
                            // Return null if the entered name is valid
                            return null;
                          },
                          controller: _nameController,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(AppMargins.XS)),
                      DropdownSearch(
                        items: availableRegions,
                        onChanged: (String? item) {
                          setState(() {
                            _selectedRegion = item;
                          });
                        },
                        selectedItem: _selectedRegion,
                        validator: (String? item) {
                          if (item == null ||
                              !(availableRegions.contains(item))) {
                            return "Please select a region";
                          }
                          return null;
                        },
                      ),
                      Padding(
                          padding: const EdgeInsets.all(AppMargins.M),
                          child: CustomButton(
                              onPressed: () async {
                                if (_createProviderProfileFormKey.currentState!
                                    .validate()) {
                                  if (mounted) {
                                    Navigator.pushNamed(
                                        context, providerConfigurationPageRoute,
                                        arguments: {
                                          'name': _nameController.text,
                                          'region': _selectedRegion,
                                        });
                                  }
                                }
                              },
                              text: "Continue")),
                    ])),
          ),
        ),
      ),
    );
  }
}
