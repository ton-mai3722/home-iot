import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/widgets/device_card.dart';
import '../../../home/domain/entities/device.dart';
import '../../../home/domain/entities/room.dart';

class RoomPage extends StatelessWidget {
  final String roomId;

  const RoomPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return RoomView(roomId: roomId);
  }
}

class RoomView extends StatefulWidget {
  final String roomId;

  const RoomView({super.key, required this.roomId});

  @override
  State<RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<RoomView> {
  // Mock room data based on roomId
  Room? get _room {
    switch (widget.roomId) {
      case '1':
        return Room(
          id: '1',
          name: 'ห้องนั่งเล่น',
          type: RoomType.livingRoom,
          devices: [
            Device(
              id: '1',
              name: 'หลอดไฟเพดาน',
              type: DeviceType.light,
              roomId: '1',
              isOn: true,
              status: DeviceStatus.online,
              properties: {'brightness': 80},
              lastUpdated: DateTime.now(),
            ),
            Device(
              id: '2',
              name: 'แอร์ห้องนั่งเล่น',
              type: DeviceType.airConditioner,
              roomId: '1',
              isOn: false,
              status: DeviceStatus.online,
              properties: {'temperature': 25},
              lastUpdated: DateTime.now(),
            ),
            Device(
              id: '11',
              name: 'Smart TV',
              type: DeviceType.smartTV,
              roomId: '1',
              isOn: true,
              status: DeviceStatus.online,
              properties: {'volume': 15},
              lastUpdated: DateTime.now(),
            ),
          ],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      case '2':
        return Room(
          id: '2',
          name: 'ห้องนอน',
          type: RoomType.bedroom,
          devices: [
            Device(
              id: '3',
              name: 'หลอดไฟข้างเตียง',
              type: DeviceType.light,
              roomId: '2',
              isOn: false,
              status: DeviceStatus.online,
              properties: {'brightness': 0},
              lastUpdated: DateTime.now(),
            ),
            Device(
              id: '4',
              name: 'พัดลมเพดาน',
              type: DeviceType.fan,
              roomId: '2',
              isOn: true,
              status: DeviceStatus.online,
              properties: {'speed': 2},
              lastUpdated: DateTime.now(),
            ),
            Device(
              id: '12',
              name: 'แอร์ห้องนอน',
              type: DeviceType.airConditioner,
              roomId: '2',
              isOn: true,
              status: DeviceStatus.online,
              properties: {'temperature': 23},
              lastUpdated: DateTime.now(),
            ),
          ],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      case '3':
        return Room(
          id: '3',
          name: 'ห้องครัว',
          type: RoomType.kitchen,
          devices: [
            Device(
              id: '5',
              name: 'หลอดไฟห้องครัว',
              type: DeviceType.light,
              roomId: '3',
              isOn: true,
              status: DeviceStatus.online,
              properties: {'brightness': 100},
              lastUpdated: DateTime.now(),
            ),
            Device(
              id: '13',
              name: 'พัดลมดูดอากาศ',
              type: DeviceType.fan,
              roomId: '3',
              isOn: false,
              status: DeviceStatus.online,
              properties: {'speed': 0},
              lastUpdated: DateTime.now(),
            ),
          ],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final room = _room;

    if (room == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('ไม่พบห้อง')),
        body: const Center(child: Text('ไม่พบข้อมูลห้องนี้')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(room.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                // TODO: Implement edit room
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                );
              } else if (value == 'settings') {
                // TODO: Implement room settings
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('แก้ไขห้อง'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 8),
                    Text('ตั้งค่า'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {});
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room Summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: _getRoomColor(room.type).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              _getRoomIcon(room.type),
                              size: 32,
                              color: _getRoomColor(room.type),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  room.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  room.typeDisplayName,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              context,
                              'อุปกรณ์ทั้งหมด',
                              room.totalDevices.toString(),
                              Icons.devices,
                              AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              context,
                              'เปิดอยู่',
                              room.activeDevices.toString(),
                              Icons.power_settings_new,
                              AppColors.deviceOn,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              context,
                              'ออนไลน์',
                              room.onlineDevices.toString(),
                              Icons.wifi,
                              AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Quick Controls
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'เปิดอุปกรณ์ทั้งหมดใน${room.name}แล้ว',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.power),
                      label: const Text('เปิดทั้งหมด'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'ปิดอุปกรณ์ทั้งหมดใน${room.name}แล้ว',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.power_off),
                      label: const Text('ปิดทั้งหมด'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deviceOff,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Devices List
              Text(
                'อุปกรณ์ในห้อง',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              if (room.devices.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.device_unknown,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'ไม่มีอุปกรณ์ในห้องนี้',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'เพิ่มอุปกรณ์ใหม่เพื่อเริ่มควบคุม',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: room.devices.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final device = room.devices[index];
                    return DeviceCard(
                      device: device,
                      onToggle: (value) {
                        setState(() {
                          // Update device state (in real app, this would call API)
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${device.name} ${value ? "เปิด" : "ปิด"}แล้ว',
                            ),
                          ),
                        );
                      },
                      onTap: () {
                        // TODO: Navigate to device details
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('รายละเอียด ${device.name}')),
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  IconData _getRoomIcon(RoomType type) {
    switch (type) {
      case RoomType.bedroom:
        return Icons.bed;
      case RoomType.livingRoom:
        return Icons.living;
      case RoomType.kitchen:
        return Icons.kitchen;
      case RoomType.bathroom:
        return Icons.bathroom;
      case RoomType.garage:
        return Icons.garage;
      case RoomType.other:
        return Icons.room;
    }
  }

  Color _getRoomColor(RoomType type) {
    switch (type) {
      case RoomType.bedroom:
        return AppColors.bedroom;
      case RoomType.livingRoom:
        return AppColors.livingRoom;
      case RoomType.kitchen:
        return AppColors.kitchen;
      case RoomType.bathroom:
        return AppColors.bathroom;
      case RoomType.garage:
        return AppColors.garage;
      case RoomType.other:
        return AppColors.primary;
    }
  }
}
