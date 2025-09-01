import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/colors.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/domain/entities/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileView();
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  // Mock user data
  User get _mockUser => User(
    id: '1',
    username: 'Test User',
    email: 'test@test.com',
    profileImage: null,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    final user = _mockUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Profile Avatar
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      backgroundImage: user.profileImage != null
                          ? NetworkImage(user.profileImage!)
                          : null,
                      child: user.profileImage == null
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: AppColors.primary,
                            )
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // User Info
                    Text(
                      user.username,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),

                    // Edit Profile Button
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Navigate to edit profile
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text(AppStrings.editProfile),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Settings Section
            _buildSectionTitle(context, AppStrings.settings),
            const SizedBox(height: 12),

            _buildSettingItem(
              context,
              icon: Icons.language,
              title: AppStrings.language,
              subtitle: 'ภาษาไทย',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                );
              },
            ),

            _buildSettingItem(
              context,
              icon: Icons.palette,
              title: AppStrings.theme,
              subtitle: 'สว่าง',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                );
              },
            ),

            _buildSettingItem(
              context,
              icon: Icons.notifications,
              title: AppStrings.notifications,
              subtitle: 'เปิดใช้งาน',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                );
              },
            ),

            const SizedBox(height: 24),

            // Device Management Section
            _buildSectionTitle(context, 'จัดการอุปกรณ์'),
            const SizedBox(height: 12),

            _buildSettingItem(
              context,
              icon: Icons.add_circle_outline,
              title: 'เพิ่มอุปกรณ์ใหม่',
              subtitle: 'เชื่อมต่ออุปกรณ์ IoT',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                );
              },
            ),

            _buildSettingItem(
              context,
              icon: Icons.room_preferences,
              title: 'จัดการห้อง',
              subtitle: 'เพิ่ม แก้ไข หรือลบห้อง',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                );
              },
            ),

            _buildSettingItem(
              context,
              icon: Icons.schedule,
              title: 'ตั้งเวลาอัตโนมัติ',
              subtitle: 'กำหนดเวลาเปิด-ปิดอุปกรณ์',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                );
              },
            ),

            const SizedBox(height: 24),

            // Security Section
            _buildSectionTitle(context, 'ความปลอดภัย'),
            const SizedBox(height: 12),

            _buildSettingItem(
              context,
              icon: Icons.lock,
              title: 'เปลี่ยนรหัสผ่าน',
              subtitle: 'อัปเดตรหัสผ่านของคุณ',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                );
              },
            ),

            _buildSettingItem(
              context,
              icon: Icons.security,
              title: 'การยืนยันตัวตน',
              subtitle: 'ตั้งค่าการยืนยันด้วยลายนิ้วมือ',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                );
              },
            ),

            const SizedBox(height: 24),

            // About Section
            _buildSectionTitle(context, 'เกี่ยวกับ'),
            const SizedBox(height: 12),

            _buildSettingItem(
              context,
              icon: Icons.info,
              title: 'เกี่ยวกับแอป',
              subtitle: 'เวอร์ชัน 1.0.0',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Home IoT v1.0.0')),
                );
              },
            ),

            _buildSettingItem(
              context,
              icon: Icons.help,
              title: 'ความช่วยเหลือ',
              subtitle: 'คำถามที่พบบ่อยและการสนับสนุน',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ฟีเจอร์นี้กำลังพัฒนา')),
                );
              },
            ),

            const SizedBox(height: 32),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text(AppStrings.logout),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ออกจากระบบ'),
        content: const Text('คุณต้องการออกจากระบบหรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ยกเลิก'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthBloc>().add(const LogoutRequested());
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('ออกจากระบบ'),
          ),
        ],
      ),
    );
  }
}
