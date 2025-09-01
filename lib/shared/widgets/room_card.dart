import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../features/home/domain/entities/room.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  final VoidCallback? onTap;

  const RoomCard({super.key, required this.room, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room Header
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getRoomColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      _getRoomIcon(),
                      color: _getRoomColor(),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      room.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Room Stats
              Row(
                children: [
                  Icon(Icons.devices, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${room.totalDevices} อุปกรณ์',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // Active devices indicator
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: room.activeDevices > 0
                          ? AppColors.deviceOn
                          : AppColors.deviceOff,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${room.activeDevices} เปิดอยู่',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: room.activeDevices > 0
                          ? AppColors.deviceOn
                          : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getRoomIcon() {
    switch (room.type) {
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

  Color _getRoomColor() {
    switch (room.type) {
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
