import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/divination_data.dart';
import '../services/fortune_engine.dart';
import '../models/fortune_models.dart';

/// 每日运势页
class DailyFortunePage extends StatefulWidget {
  const DailyFortunePage({super.key});
  @override
  State<DailyFortunePage> createState() => _DailyFortunePageState();
}

class _DailyFortunePageState extends State<DailyFortunePage> {
  int _selectedSign = -1;
  DailyFortune? _fortune;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('每日运势')),
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
            // 日期显示
            Center(
              child: Text(
                '${DateTime.now().year}年${DateTime.now().month}月${DateTime.now().day}日',
                style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
              ),
            ),
            const SizedBox(height: 16),
            // 星座选择
            if (_selectedSign == -1) _buildSignSelector(),
            if (_fortune != null) ...[
              _buildScoreCards(),
              const SizedBox(height: 16),
              _buildLuckyCard(),
              const SizedBox(height: 16),
              _buildAdviceCard(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => setState(() {
                  _selectedSign = -1;
                  _fortune = null;
                }),
                child: const Text('切换星座'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSignSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('选择你的星座', style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: DivinationData.zodiacSigns.asMap().entries.map((e) {
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedSign = e.key;
                    _fortune = FortuneEngine.generateDailyFortune(
                      e.value['name'], DateTime.now());
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.bgDark,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
                    ),
                    child: Text(e.value['name'], style: TextStyle(
                      fontSize: 13, color: AppTheme.textPrimary)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCards() {
    final f = _fortune!;
    final items = [
      ('桃花', f.loveScore, Icons.favorite, const Color(0xFFEC4899)),
      ('财运', f.wealthScore, Icons.monetization_on, const Color(0xFFF59E0B)),
      ('事业', f.careerScore, Icons.work, const Color(0xFF3B82F6)),
      ('健康', f.healthScore, Icons.local_hospital, const Color(0xFF10B981)),
    ];
    return Column(
      children: items.map((item) {
        final (label, score, icon, color) = item;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.bgCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Text(label, style: TextStyle(fontSize: 15, color: AppTheme.textPrimary)),
              const Spacer(),
              SizedBox(
                width: 120,
                child: LinearProgressIndicator(
                  value: score / 100,
                  backgroundColor: AppTheme.bgDark,
                  color: color,
                  minHeight: 8,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 40,
                child: Text('$score', style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color),
                  textAlign: TextAlign.right),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLuckyCard() {
    final f = _fortune!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _luckyItem('幸运色', f.luckyColor),
            _luckyItem('数字', f.luckyNumber),
            _luckyItem('方位', f.luckyDirection),
          ],
        ),
      ),
    );
  }

  Widget _luckyItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        const SizedBox(height: 6),
        Text(value, style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.accent)),
      ],
    );
  }

  Widget _buildAdviceCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.lightbulb, color: AppTheme.accent, size: 20),
              const SizedBox(width: 6),
              Text('今日宜忌', style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.accent)),
            ]),
            const SizedBox(height: 8),
            Text(_fortune!.advice, style: TextStyle(
              fontSize: 14, color: AppTheme.textPrimary, height: 1.6)),
          ],
        ),
      ),
    );
  }
}
