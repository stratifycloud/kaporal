abstract class Constants {
  static final alNumRegExp = RegExp(r'^[a-zA-Z0-9]+$');
  static final nameRegExp = RegExp(r'^[a-zA-Z][a-zA-Z\-]*[a-zA-Z]$');
  static const timeoutDuration = Duration(seconds: 5);
}

List<String> awsRegions = ['eu-west-1', 'us-east-1'];
List<String> azureRegions = ['mock'];
List<String> gcpRegions = ['mock'];

List<String> awsMachineFlavors = ['t3.medium', 'r6.large', 'r6.xlarge'];
List<String> azureMachineFlavors = ['mock'];
List<String> gcpMachineFlavors = ['mock'];
