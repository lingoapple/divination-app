import 'package:flutter/material.dart';
import '../utils/theme.dart';

/// 个人中心页
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('个人中心')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [AppTheme.bgDark, AppTheme.primaryDark],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // 用户信息卡
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
                      ),
                      child: const Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text('未登录', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // 接入云服务后跳转登录页
                      },
                      child: const Text('登录 / 注册'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 功能列表
            _buildMenuItem(Icons.history, '占卜历史', () {}),
            _buildMenuItem(Icons.favorite, '我的收藏', () {}),
            _buildMenuItem(Icons.notifications, '运势提醒', () {}),
            _buildMenuItem(Icons.palette, '主题设置', () {}),
            _buildMenuItem(Icons.share, '分享给好友', () {}),
            _buildMenuItem(Icons.info_outline, '关于天机阁', () {}),
            const SizedBox(height: 24),
            Text('天机阁 v1.0.0', style: TextStyle(
              fontSize: 12, color: AppTheme.textSecondary.withOpacity(0.5)),
              textAlign: TextAlign.center),
            Text('仅供娱乐参考，命运掌握在自己手中', style: TextStyle(
              fontSize: 11, color: AppTheme.textSecondary.withOpacity(0.4)),
              textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppTheme.accent, size: 22),
        title: Text(title, style: TextStyle(fontSize: 15, color: AppTheme.textPrimary)),
        trailing: Icon(Icons.chevron_right, color: AppTheme.textSecondary),
        onTap: onTap,
      ),
    );
  }
}
