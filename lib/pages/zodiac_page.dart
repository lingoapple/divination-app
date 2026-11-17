import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/divination_data.dart';
import '../services/fortune_engine.dart';
import '../models/fortune_models.dart';

/// 星座运势页
class ZodiacPage extends StatefulWidget {
  const ZodiacPage({super.key});
  @override
  State<ZodiacPage> createState() => _ZodiacPageState();
}

class _ZodiacPageState extends State<ZodiacPage> {
  int _selectedSign = -1;
  DailyFortune? _fortune;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('星座运势')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [AppTheme.bgDark, AppTheme.primaryDark],
          ),
        ),
        child: _selectedSign == -1
          ? _buildSignGrid()
          : _buildSignDetail(),
      ),
    );
  }

  Widget _buildSignGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: 12,
      itemBuilder: (ctx, i) {
        final sign = DivinationData.zodiacSigns[i];
        return GestureDetector(
          onTap: () => setState(() {
            _selectedSign = i;
            _fortune = FortuneEngine.generateDailyFortune(sign['name'], DateTime.now());
          }),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.bgCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(String.fromCharCode(sign['icon']),
                  style: const TextStyle(fontSize: 36)),
                const SizedBox(height: 6),
                Text(sign['name'], style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                Text(sign['dateRange'], style: TextStyle(
                  fontSize: 10, color: AppTheme.textSecondary)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSignDetail() {
    final sign = DivinationData.zodiacSigns[_selectedSign];
    final f = _fortune!;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // 星座头部
        Center(
          child: Column(
            children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
                ),
                child: Center(
                  child: Text(String.fromCharCode(sign['icon']),
                    style: const TextStyle(fontSize: 44)),
                ),
              ),
              const SizedBox(height: 12),
              Text(sign['name'], style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              Text('${sign['dateRange']} · ${sign['element']}象 · 守护星：${sign['ruler']}',
                style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // 运势分数
        _buildScoreGrid(f),
        const SizedBox(height: 16),
        // 幸运信息
        _buildLuckyInfo(f),
        const SizedBox(height: 16),
        // 建议
        _buildAdviceCard(f.advice),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => setState(() {
            _selectedSign = -1;
            _fortune = null;
          }),
          child: const Text('返回星座选择'),
        ),
      ],
    );
  }

  Widget _buildScoreGrid(DailyFortune f) {
    final items = [
      ('桃花', f.loveScore, Icons.favorite, const Color(0xFFEC4899)),
      ('财运', f.wealthScore, Icons.monetization_on, const Color(0xFFF59E0B)),
      ('事业', f.careerScore, Icons.work, const Color(0xFF3B82F6)),
      ('健康', f.healthScore, Icons.local_hospital, const Color(0xFF10B981)),
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: items.map((item) {
        final (label, score, icon, color) = item;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 6),
                Text(label, style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
              ]),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$score', style: TextStyle(
                    fontSize: 32, fontWeight: FontWeight.bold, color: color)),
                  Text('/100', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                ],
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: score / 100,
                backgroundColor: AppTheme.bgDark,
                color: color,
                minHeight: 4,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLuckyInfo(DailyFortune f) {
    final items = [
      ('幸运色', f.luckyColor),
      ('幸运数字', f.luckyNumber),
      ('幸运方位', f.luckyDirection),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            final (label, value) = item;
            return Column(
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
                const SizedBox(height: 6),
                Text(value, style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.accent)),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAdviceCard(String advice) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.lightbulb, color: AppTheme.accent, size: 20),
              const SizedBox(width: 6),
              Text('今日建议', style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.accent)),
            ]),
            const SizedBox(height: 8),
            Text(advice, style: TextStyle(fontSize: 14, color: AppTheme.textPrimary, height: 1.6)),
          ],
        ),
      ),
    );
  }
}
