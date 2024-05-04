import 'package:kaporal/models/common/cluster.dart';
import 'package:kaporal/models/common/control_plane.dart';
import 'package:kaporal/models/common/infrastructure.dart';
import 'package:kaporal/models/common/machine_pool.dart';
import 'package:uuid/uuid.dart';

class Deployment {
  String uuid = const Uuid().v4();

  Cluster cluster;

  ControlPlane controlPlane;
  ControlPlaneRef controlPlaneRef;

  Infrastructure infrastructure;
  InfrastructureRef infrastructureRef;

  MachinePool machinePool;
  MachinePoolInfrastructureRef machinePoolInfrastructureRef;

  Deployment({
    required this.cluster,
    required this.controlPlane,
    required this.controlPlaneRef,
    required this.infrastructure,
    required this.infrastructureRef,
    required this.machinePool,
    required this.machinePoolInfrastructureRef,
  });
}