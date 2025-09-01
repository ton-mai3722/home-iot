import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../features/home/domain/entities/device.dart';

class DeviceCard extends StatelessWidget {
  final Device device;
  final Function(bool)? onToggle;
  final VoidCallback? onTap;

  const DeviceCard({
    super.key,
    required this.device,
    this.onToggle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Device Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getDeviceColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getDeviceIcon(),
                  color: _getDeviceColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Device Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          _getStatusIcon(),
                          size: 16,
                          color: _getStatusColor(),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _getStatusText(),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: _getStatusColor()),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          device.typeDisplayName,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Device Switch
              if (onToggle != null)
                Switch(
                  value: device.isOn,
                  onChanged: device.status == DeviceStatus.online
                      ? onToggle
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getDeviceIcon() {
    switch (device.type) {
      case DeviceType.light:
        return Icons.lightbulb_outline;
      case DeviceType.airConditioner:
        return Icons.ac_unit;
      case DeviceType.fan:
        return Icons.wind_power;
      case DeviceType.camera:
        return Icons.videocam_outlined;
      case DeviceType.smartTV:
        return Icons.tv;
      case DeviceType.speaker:
        return Icons.speaker;
      case DeviceType.other:
        return Icons.device_unknown;
    }
  }

  Color _getDeviceColor() {
    if (device.status != DeviceStatus.online) {
      return AppColors.deviceOff;
    }

    switch (device.type) {
      case DeviceType.light:
        return device.isOn ? Colors.amber : AppColors.deviceOff;
      case DeviceType.airConditioner:
        return device.isOn ? Colors.blue : AppColors.deviceOff;
      case DeviceType.fan:
        return device.isOn ? Colors.cyan : AppColors.deviceOff;
      case DeviceType.camera:
        return device.isOn ? Colors.red : AppColors.deviceOff;
      case DeviceType.smartTV:
        return device.isOn ? Colors.purple : AppColors.deviceOff;
      case DeviceType.speaker:
        return device.isOn ? Colors.green : AppColors.deviceOff;
      case DeviceType.other:
        return device.isOn ? AppColors.primary : AppColors.deviceOff;
    }
  }

  IconData _getStatusIcon() {
    switch (device.status) {
      case DeviceStatus.online:
        return Icons.wifi;
      case DeviceStatus.offline:
        return Icons.wifi_off;
      case DeviceStatus.error:
        return Icons.error_outline;
    }
  }

  Color _getStatusColor() {
    switch (device.status) {
      case DeviceStatus.online:
        return AppColors.deviceOn;
      case DeviceStatus.offline:
        return AppColors.deviceOff;
      case DeviceStatus.error:
        return AppColors.deviceError;
    }
  }

  String _getStatusText() {
    switch (device.status) {
      case DeviceStatus.online:
        return device.isOn ? 'เปิด' : 'ปิด';
      case DeviceStatus.offline:
        return 'ออฟไลน์';
      case DeviceStatus.error:
        return 'ข้อผิดพลาด';
    }
  }
}
