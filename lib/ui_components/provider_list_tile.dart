import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaporal/models/providers/provider_type.dart';
import 'package:kaporal/ui_components/ui_specs.dart';
import 'package:kaporal/ui_components/ui_constants.dart';

class ProviderSelectionTile extends StatelessWidget {
  final ProviderType providerType;
  final bool enabled;
  const ProviderSelectionTile(
      {super.key, required this.providerType, required this.enabled});

  @override
  Widget build(BuildContext context) {
    String imageSource;
    String title;

    switch (providerType) {
      case ProviderType.aws:
        imageSource = awsLogoPath;
        title = 'Amazon Web Services';
        break;
      case ProviderType.azure:
        imageSource = azureLogoPath;
        title = 'Azure';
        break;
      case ProviderType.gcp:
        imageSource = gcpLogoPath;
        title = 'Google Cloud Platform';
        break;
      default:
        imageSource = 'assets/images/unknown.png';
        title = 'unknown';
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(AppMargins.S),
      child: SizedBox(
        height: 180,
        width: 150,
        child: Opacity(
          opacity: enabled ? 1 : 0.7,
          child: Card(
            color: Colors.white,
            child: ClipRect(
              child: Center(
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(AppFontSizes.S),
                      child: SvgPicture.asset(
                        imageSource,
                        height: 100,
                      )),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: enabled ? Colors.black : Colors.grey),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
