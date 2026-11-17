import 'package:flutter/material.dart';
import '../utils/theme.dart';

/// 首页 — 功能导航
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.bgDark, AppTheme.primaryDark, AppTheme.bgDark],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // 顶部 Logo 区
              SliverToBoxAdapter(
                child: _buildHeader(),
              ),
              // 今日运势快捷入口
              SliverToBoxAdapter(
                child: _buildDailyCard(context),
              ),
              // 功能网格
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => _buildFeatureCard(ctx, _features[i]),
                    childCount: _features.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.0,
                  ),
                ),
              ),
              // 底部信息
              SliverToBoxAdapter(
                child: _buildFooter(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 20),
      child: Column(
        children: [
          // 星空装饰
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                Icons.star,
                size: 12 + (i % 3) * 4,
                color: AppTheme.starGold.withOpacity(0.4 + (i % 3) * 0.2),
              ),
            )),
          ),
          const SizedBox(height: 16),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppTheme.accent, AppTheme.primary, AppTheme.starGold],
            ).createShader(bounds),
            child: const Text(
              '天 机 阁',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 8,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '探索命运的奥秘',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '八字 · 紫微 · 星座 · 塔罗 · 生肖',
              style: TextStyle(fontSize: 11, color: AppTheme.accent.withOpacity(0.8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primary.withOpacity(0.3), AppTheme.bgCard],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.accent.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('今日运势', style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                const SizedBox(height: 4),
                Text('查看你今天的桃花、财运、事业', style: TextStyle(
                  fontSize: 12, color: AppTheme.textSecondary)),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/daily'),
                  icon: const Icon(Icons.auto_awesome, size: 18),
                  label: const Text('立即查看'),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppTheme.accent, AppTheme.primary],
              ),
            ),
            child: const Icon(Icons.favorite, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, _FeatureItem item) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, item.route),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: item.color.withOpacity(0.15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.color.withOpacity(0.15),
              ),
              child: Icon(item.icon, color: item.color, size: 26),
            ),
            const SizedBox(height: 12),
            Text(item.title, style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
            const SizedBox(height: 4),
            Text(item.subtitle, style: TextStyle(
              fontSize: 11, color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavButton(context, Icons.history, '历史记录', '/history'),
          _buildNavButton(context, Icons.person, '个人中心', '/profile'),
        ],
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.textSecondary, size: 24),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}

class _FeatureItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;

  _FeatureItem(this.title, this.subtitle, this.icon, this.color, this.route);
}

final List<_FeatureItem> _features = [
  _FeatureItem('八字命理', '生辰八字推算', Icons.cake, Color(0xFF8B5CF6), '/bazi'),
  _FeatureItem('星座运势', '十二星座解析', Icons.auto_awesome, Color(0xFF3B82F6), '/zodiac'),
  _FeatureItem('塔罗占卜', '抽牌解读命运', Icons.style, Color(0xFFEC4899), '/tarot'),
  _FeatureItem('生肖运程', '十二生肖运势', Icons.pets, Color(0xFFF59E0B), '/shengxiao'),
  _FeatureItem('每日运势', '今日运势详解', Icons.today, Color(0xFF10B981), '/daily'),
  _FeatureItem('MBTI测试', '性格命运测试', Icons.psychology, Color(0xFF6366F1), '/mbti'),
  _FeatureItem('起名测名', '姓名打分分析', Icons.edit_note, Color(0xFFEF4444), '/name'),
  _FeatureItem('紫微斗数', '紫微星盘推算', Icons.grid_view, Color(0xFFA855F7), '/bazi'),
];
