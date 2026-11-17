import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../services/fortune_engine.dart';
import '../models/fortune_models.dart';

/// 八字命理页
class BaZiPage extends StatefulWidget {
  const BaZiPage({super.key});
  @override
  State<BaZiPage> createState() => _BaZiPageState();
}

class _BaZiPageState extends State<BaZiPage> {
  DateTime? _birthDate;
  int _birthHour = 12;
  BaZiModel? _result;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('八字命理')),
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
            _buildInputCard(),
            if (_result != null) ...[
              const SizedBox(height: 16),
              _buildResultCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.cake, color: AppTheme.accent, size: 24),
                const SizedBox(width: 8),
                Text('请输入出生信息', style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
              ],
            ),
            const SizedBox(height: 20),
            // 日期选择
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  builder: (ctx, child) => Theme(
                    data: Theme.of(ctx).copyWith(
                      colorScheme: const ColorScheme.dark(primary: AppTheme.primary)),
                    child: child!),
                );
                if (date != null) setState(() => _birthDate = date);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppTheme.bgDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.primary.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: AppTheme.textSecondary, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      _birthDate == null
                        ? '选择出生日期'
                        : '${_birthDate!.year}年${_birthDate!.month}月${_birthDate!.day}日',
                      style: TextStyle(fontSize: 15, color: AppTheme.textPrimary)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 时辰选择
            Text('出生时辰', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: List.generate(12, (i) {
                final zhi = ['子','丑','寅','卯','辰','巳','午','未','申','酉','戌','亥'][i];
                final timeRange = ['23-1','1-3','3-5','5-7','7-9','9-11','11-13','13-15','15-17','17-19','19-21','21-23'][i];
                final isSelected = _birthHour == i * 2 + 1;
                return GestureDetector(
                  onTap: () => setState(() => _birthHour = i * 2 + 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primary : AppTheme.bgDark,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isSelected ? AppTheme.accent : AppTheme.primary.withOpacity(0.2)),
                    ),
                    child: Text('$zhi时($timeRange)', style: TextStyle(
                      fontSize: 11, color: isSelected ? Colors.white : AppTheme.textSecondary)),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _birthDate == null || _loading ? null : _calculate,
                child: _loading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('开始排盘'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculate() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    final result = FortuneEngine.calculateBaZi(_birthDate!, _birthHour);
    setState(() {
      _result = result;
      _loading = false;
    });
  }

  Widget _buildResultCard() {
    final r = _result!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 四柱
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPillar('年柱', r.yearGanZhi),
                  _buildPillar('月柱', r.monthGanZhi),
                  _buildPillar('日柱', r.dayGanZhi),
                  _buildPillar('时柱', r.hourGanZhi),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 五行分析
            _buildSection('五行分析', r.wuXing),
            const SizedBox(height: 16),
            // 命理摘要
            _buildSection('命理分析', r.summary),
          ],
        ),
      ),
    );
  }

  Widget _buildPillar(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
        const SizedBox(height: 8),
        Container(
          width: 56, height: 72,
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
          ),
          child: Center(
            child: Text(value, style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.accent)),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.accent)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.bgDark.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(content, style: TextStyle(fontSize: 14, color: AppTheme.textPrimary, height: 1.6)),
        ),
      ],
    );
  }
}
