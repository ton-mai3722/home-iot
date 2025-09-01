import 'package:equatable/equatable.dart';

enum DeviceType { light, airConditioner, fan, camera, smartTV, speaker, other }

enum DeviceStatus { online, offline, error }

class Device extends Equatable {
  final String id;
  final String name;
  final DeviceType type;
  final String roomId;
  final bool isOn;
  final DeviceStatus status;
  final Map<String, dynamic> properties;
  final DateTime lastUpdated;

  const Device({
    required this.id,
    required this.name,
    required this.type,
    required this.roomId,
    required this.isOn,
    required this.status,
    required this.properties,
    required this.lastUpdated,
  });

  @override
  List<Object> get props => [
    id,
    name,
    type,
    roomId,
    isOn,
    status,
    properties,
    lastUpdated,
  ];

  Device copyWith({
    String? id,
    String? name,
    DeviceType? type,
    String? roomId,
    bool? isOn,
    DeviceStatus? status,
    Map<String, dynamic>? properties,
    DateTime? lastUpdated,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      roomId: roomId ?? this.roomId,
      isOn: isOn ?? this.isOn,
      status: status ?? this.status,
      properties: properties ?? this.properties,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  String get typeDisplayName {
    switch (type) {
      case DeviceType.light:
        return 'ไฟ';
      case DeviceType.airConditioner:
        return 'แอร์';
      case DeviceType.fan:
        return 'พัดลม';
      case DeviceType.camera:
        return 'กล้อง';
      case DeviceType.smartTV:
        return 'Smart TV';
      case DeviceType.speaker:
        return 'ลำโพง';
      case DeviceType.other:
        return 'อื่นๆ';
    }
  }
}
