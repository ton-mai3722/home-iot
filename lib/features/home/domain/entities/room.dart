import 'package:equatable/equatable.dart';
import 'device.dart';

enum RoomType { bedroom, livingRoom, kitchen, bathroom, garage, other }

class Room extends Equatable {
  final String id;
  final String name;
  final RoomType type;
  final String? icon;
  final List<Device> devices;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Room({
    required this.id,
    required this.name,
    required this.type,
    this.icon,
    required this.devices,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    type,
    icon,
    devices,
    createdAt,
    updatedAt,
  ];

  Room copyWith({
    String? id,
    String? name,
    RoomType? type,
    String? icon,
    List<Device>? devices,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      devices: devices ?? this.devices,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  int get totalDevices => devices.length;
  int get onlineDevices =>
      devices.where((d) => d.status == DeviceStatus.online).length;
  int get activeDevices => devices.where((d) => d.isOn).length;

  String get typeDisplayName {
    switch (type) {
      case RoomType.bedroom:
        return 'ห้องนอน';
      case RoomType.livingRoom:
        return 'ห้องนั่งเล่น';
      case RoomType.kitchen:
        return 'ห้องครัว';
      case RoomType.bathroom:
        return 'ห้องน้ำ';
      case RoomType.garage:
        return 'โรงรถ';
      case RoomType.other:
        return 'อื่นๆ';
    }
  }
}
