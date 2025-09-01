import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/widgets/device_card.dart';
import '../../../../shared/widgets/room_card.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../home/domain/entities/device.dart';
import '../../../home/domain/entities/room.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // Mock data for demonstration
  List<Room> get _mockRooms => [
    Room(
      id: '1',
      name: AppStrings.livingRoom,
      type: RoomType.livingRoom,
      devices: _mockDevices.where((d) => d.roomId == '1').toList(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Room(
      id: '2',
      name: AppStrings.bedroom,
      type: RoomType.bedroom,
      devices: _mockDevices.where((d) => d.roomId == '2').toList(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Room(
      id: '3',
      name: AppStrings.kitchen,
      type: RoomType.kitchen,
      devices: _mockDevices.where((d) => d.roomId == '3').toList(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  List<Device> get _mockDevices => [
    Device(
      id: '1',
      name: 'หลอดไฟห้องนั่งเล่น',
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
      id: '3',
      name: 'หลอดไฟห้องนอน',
      type: DeviceType.light,
      roomId: '2',
      isOn: false,
      status: DeviceStatus.online,
      properties: {'brightness': 0},
      lastUpdated: DateTime.now(),
    ),
    Device(
      id: '4',
      name: 'พัดลมห้องนอน',
      type: DeviceType.fan,
      roomId: '2',
      isOn: true,
      status: DeviceStatus.online,
      properties: {'speed': 2},
      lastUpdated: DateTime.now(),
    ),
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
  ];

  @override
  Widget build(BuildContext context) {
    final rooms = _mockRooms;
    final devices = _mockDevices;
    final totalDevices = devices.length;
    final activeDevices = devices.where((d) => d.isOn).length;
    final onlineDevices = devices
        .where((d) => d.status == DeviceStatus.online)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.dashboard),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'profile') {
                context.go('/profile');
              } else if (value == 'logout') {
                context.read<AuthBloc>().add(const LogoutRequested());
                context.go('/login');
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text(AppStrings.profile),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text(AppStrings.logout),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh logic
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dashboard Summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.dashboard,
                            size: 32,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'สถานะระบบ',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  'ภาพรวมอุปกรณ์ในบ้าน',
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                              'ทั้งหมด',
                              totalDevices.toString(),
                              Icons.devices,
                              AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildStatCard(
                              context,
                              'เปิดอยู่',
                              activeDevices.toString(),
                              Icons.power_settings_new,
                              AppColors.deviceOn,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildStatCard(
                              context,
                              'ออนไลน์',
                              onlineDevices.toString(),
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

              // Quick Actions
              Text(
                'การควบคุมด่วน',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Turn off all devices
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('ปิดอุปกรณ์ทั้งหมดแล้ว'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.power_off),
                      label: const Text(AppStrings.turnOffAll),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deviceOff,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Turn on all devices
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('เปิดอุปกรณ์ทั้งหมดแล้ว'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.power),
                      label: const Text(AppStrings.turnOnAll),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Rooms Section
              Text(
                AppStrings.rooms,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return RoomCard(
                    room: room,
                    onTap: () {
                      context.go('/room/${room.id}');
                    },
                  );
                },
              ),
              const SizedBox(height: 24),

              // Recent Devices
              Text(
                'อุปกรณ์ล่าสุด',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: devices.take(3).length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return DeviceCard(
                    device: device,
                    onToggle: (value) {
                      // TODO: Toggle device
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${device.name} ${value ? "เปิด" : "ปิด"}แล้ว',
                          ),
                        ),
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
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
