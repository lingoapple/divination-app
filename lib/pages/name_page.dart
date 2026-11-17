import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../services/fortune_engine.dart';

/// 起名测名页
class NamePage extends StatefulWidget {
  const NamePage({super.key});
  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final _controller = TextEditingController();
  Map<String, dynamic>? _result;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('起名测名')),
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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(Icons.edit_note, color: AppTheme.accent, size: 40),
                    const SizedBox(height: 16),
                    Text('输入姓名进行打分', style: TextStyle(
                      fontSize: 16, color: AppTheme.textSecondary)),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: AppTheme.textPrimary),
                      decoration: InputDecoration(
                        hintText: '请输入姓名',
                        hintStyle: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5)),
                        filled: true,
                        fillColor: AppTheme.bgDark,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppTheme.primary.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppTheme.accent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final r = FortuneEngine.nameScore(_controller.text);
                          setState(() => _result = r);
                        },
                        child: const Text('开始测算'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_result != null) ...[
              const SizedBox(height: 16),
              _buildResultCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    final score = _result!['score'] as int;
    final analysis = _result!['analysis'] as String;
    final color = score >= 85 ? const Color(0xFF10B981)
      : score >= 70 ? AppTheme.accent
      : const Color(0xFFEF4444);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // 分数圆环
            SizedBox(
              width: 140, height: 140,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 140, height: 140,
                    child: CircularProgressIndicator(
                      value: score / 100,
                      strokeWidth: 10,
                      backgroundColor: AppTheme.bgDark,
                      color: color,
                    ),
                  ),
                  Column(
                    children: [
                      Text('$score', style: TextStyle(
                        fontSize: 42, fontWeight: FontWeight.bold, color: color)),
                      Text('分', style: TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.bgDark.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(analysis, style: TextStyle(
                fontSize: 15, color: AppTheme.textPrimary, height: 1.6),
                textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
