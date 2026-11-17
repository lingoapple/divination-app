import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../services/fortune_engine.dart';

/// MBTI 性格测试页
class MBTIPage extends StatefulWidget {
  const MBTIPage({super.key});
  @override
  State<MBTIPage> createState() => _MBTIPageState();
}

class _MBTIPageState extends State<MBTIPage> {
  int _currentQ = 0;
  List<String> _answers = [];
  String? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MBTI 测试')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [AppTheme.bgDark, AppTheme.primaryDark],
          ),
        ),
        child: _result != null ? _buildResultView() : _buildQuestionView(),
      ),
    );
  }

  Widget _buildQuestionView() {
    final questions = FortuneEngine.mbtiQuestions;
    final q = questions[_currentQ];
    final progress = (_currentQ + 1) / questions.length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // 进度条
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.bgCard,
            color: AppTheme.accent,
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 8),
        Text('第 ${_currentQ + 1} / ${questions.length} 题', style: TextStyle(
          fontSize: 13, color: AppTheme.textSecondary)),
        const SizedBox(height: 32),
        // 问题
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(q['q'], style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
                const SizedBox(height: 20),
                _buildOption('A', q['a'], () => _answer('a')),
                const SizedBox(height: 12),
                _buildOption('B', q['b'], () => _answer('b')),
              ],
            ),
          ),
        ),
        if (_currentQ > 0) ...[
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => setState(() {
              _currentQ--;
              _answers.removeLast();
            }),
            icon: const Icon(Icons.arrow_back),
            label: const Text('上一题'),
          ),
        ],
      ],
    );
  }

  Widget _buildOption(String label, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.bgDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primary.withOpacity(0.3),
              ),
              child: Center(
                child: Text(label, style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.accent)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(text, style: TextStyle(
              fontSize: 15, color: AppTheme.textPrimary))),
          ],
        ),
      ),
    );
  }

  void _answer(String choice) {
    _answers.add(choice);
    if (_currentQ < FortuneEngine.mbtiQuestions.length - 1) {
      setState(() => _currentQ++);
    } else {
      final result = FortuneEngine.calculateMBTI(_answers);
      setState(() => _result = result);
    }
  }

  Widget _buildResultView() {
    final desc = FortuneEngine.mbtiDescriptions[_result!]!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120, height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.accent]),
              ),
              child: Center(
                child: Text(_result!, style: const TextStyle(
                  fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 24),
            Text(desc['name']!, style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.accent)),
            const SizedBox(height: 12),
            Text(desc['desc']!, style: TextStyle(
              fontSize: 16, color: AppTheme.textPrimary, height: 1.6),
              textAlign: TextAlign.center),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => setState(() {
                _result = null;
                _currentQ = 0;
                _answers = [];
              }),
              child: const Text('重新测试'),
            ),
          ],
        ),
      ),
    );
  }
}
