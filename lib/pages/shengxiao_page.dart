import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/divination_data.dart';

/// 生肖运程页
class ShengXiaoPage extends StatefulWidget {
  const ShengXiaoPage({super.key});
  @override
  State<ShengXiaoPage> createState() => _ShengXiaoPageState();
}

class _ShengXiaoPageState extends State<ShengXiaoPage> {
  int _year = 2000;
  String _shengXiao = '';
  Map<String, dynamic>? _fortune;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('生肖运程')),
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
            _buildYearSelector(),
            if (_fortune != null) ...[
              const SizedBox(height: 16),
              _buildResultCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildYearSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('选择出生年份', style: TextStyle(fontSize: 16, color: AppTheme.textSecondary)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => setState(() {
                    _year--;
                    _updateShengXiao();
                  }),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$_year', style: TextStyle(
                  fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.accent)),
                IconButton(
                  onPressed: () => setState(() {
                    _year++;
                    _updateShengXiao();
                  }),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 快速选择
            Wrap(
              spacing: 8, runSpacing: 8,
              children: DivinationData.shengXiao.asMap().entries.map((e) {
                final year = 2008 - e.key; // 2008年鼠年
                return GestureDetector(
                  onTap: () => setState(() {
                    _year = year;
                    _updateShengXiao();
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _year == year ? AppTheme.primary : AppTheme.bgDark,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('${e.value}', style: TextStyle(
                      fontSize: 13, color: _year == year ? Colors.white : AppTheme.textSecondary)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _updateShengXiao() {
    _shengXiao = DivinationData.getShengXiao(_year);
    _fortune = DivinationData.shengXiaoFortune[_shengXiao];
  }

  Widget _buildResultCard() {
    final f = _fortune!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // 生肖大图标
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [AppTheme.accent, AppTheme.primary]),
              ),
              child: Center(
                child: Text(_shengXiao, style: const TextStyle(
                  fontSize: 44, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
            Text('属$_shengXiao · ${_year}年', style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('五行：${f['element']}', style: TextStyle(
                fontSize: 13, color: AppTheme.accent)),
            ),
            const SizedBox(height: 20),
            // 运势描述
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.bgDark.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(f['overall'], style: TextStyle(
                fontSize: 15, color: AppTheme.textPrimary, height: 1.6),
                textAlign: TextAlign.center),
            ),
            const SizedBox(height: 16),
            // 幸运色
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('幸运颜色：', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                Text(f['lucky'], style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.accent)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
