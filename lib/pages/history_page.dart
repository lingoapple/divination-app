import 'package:flutter/material.dart';
import '../utils/theme.dart';

/// 历史记录页（接入云服务后从云端拉取）
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 本地模拟数据 — 接入云服务后替换为云端记录
    final records = [
      {'type': '八字命理', 'date': '2026-11-17', 'summary': '甲子年 丙寅月 戊午日...'},
      {'type': '塔罗占卜', 'date': '2026-11-16', 'summary': '愚者(正) · 魔术师(逆) · 星星(正)'},
      {'type': '星座运势', 'date': '2026-11-16', 'summary': '天蝎座 桃花78 财运65'},
      {'type': 'MBTI测试', 'date': '2026-11-15', 'summary': 'INFJ · 建筑师'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('历史记录')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [AppTheme.bgDark, AppTheme.primaryDark],
          ),
        ),
        child: records.isEmpty
          ? Center(child: Text('暂无记录', style: TextStyle(color: AppTheme.textSecondary)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: records.length,
              itemBuilder: (ctx, i) {
                final r = records[i];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primary.withOpacity(0.2),
                      ),
                      child: Icon(Icons.auto_awesome, color: AppTheme.accent, size: 20),
                    ),
                    title: Text(r['type']!, style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(r['summary']!, style: TextStyle(
                          fontSize: 13, color: AppTheme.textSecondary)),
                        Text(r['date']!, style: TextStyle(
                          fontSize: 11, color: AppTheme.textSecondary.withOpacity(0.6))),
                      ],
                    ),
                    trailing: Icon(Icons.chevron_right, color: AppTheme.textSecondary),
                  ),
                );
              },
            ),
      ),
    );
  }
}
