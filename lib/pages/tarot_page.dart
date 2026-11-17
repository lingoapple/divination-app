import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../services/fortune_engine.dart';
import '../models/fortune_models.dart';

/// 塔罗占卜页
class TarotPage extends StatefulWidget {
  const TarotPage({super.key});
  @override
  State<TarotPage> createState() => _TarotPageState();
}

class _TarotPageState extends State<TarotPage> with TickerControllerMixin {
  List<TarotCard> _cards = [];
  bool _drawing = false;
  int _revealedIndex = -1;
  late AnimationController _shuffleController;
  late AnimationController _flipController;

  @override
  void initState() {
    super.initState();
    _shuffleController = AnimationController(
      duration: const Duration(milliseconds: 1500), vsync: this);
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 600), vsync: this);
  }

  @override
  void dispose() {
    _shuffleController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('塔罗占卜')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [AppTheme.bgDark, Color(0xFF2D1B4E)],
          ),
        ),
        child: _cards.isEmpty ? _buildStartView() : _buildResultView(),
      ),
    );
  }

  Widget _buildStartView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 装饰性塔罗牌堆
          Stack(
            alignment: Alignment.center,
            children: List.generate(5, (i) => Transform.translate(
              offset: Offset((i - 2) * 8.0, (i - 2) * 4.0),
              child: _buildCardBack(80, 130),
            )),
          ),
          const SizedBox(height: 40),
          Text('塔罗牌占卜', style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
          const SizedBox(height: 8),
          Text('冥想你的问题，然后抽取三张牌', style: TextStyle(
            fontSize: 14, color: AppTheme.textSecondary)),
          const SizedBox(height: 8),
          Text('过去 · 现在 · 未来', style: TextStyle(
            fontSize: 13, color: AppTheme.accent)),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _drawing ? null : _drawCards,
            icon: Icon(_drawing ? Icons.shuffle : Icons.style),
            label: Text(_drawing ? '洗牌中...' : '开始抽牌'),
          ),
        ],
      ),
    );
  }

  void _drawCards() async {
    setState(() => _drawing = true);
    _shuffleController.repeat();
    await Future.delayed(const Duration(milliseconds: 1800));
    _shuffleController.stop();
    final cards = FortuneEngine.drawTarotCards(count: 3);
    setState(() {
      _cards = cards;
      _drawing = false;
      _revealedIndex = -1;
    });
  }

  Widget _buildResultView() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['过去', '现在', '未来'].asMap().entries.map((entry) {
            int i = entry.key;
            String label = entry.value;
            return GestureDetector(
              onTap: () => _revealCard(i),
              child: Column(
                children: [
                  Text(label, style: TextStyle(
                    fontSize: 14, color: AppTheme.textSecondary)),
                  const SizedBox(height: 8),
                  _revealedIndex >= i
                    ? _buildRevealedCard(_cards[i], 90, 150)
                    : _buildCardBack(90, 150),
                ],
              ),
            );
          }).toList(),
        ),
        if (_revealedIndex >= 0) ...[
          const SizedBox(height: 24),
          _buildCardDetail(_cards[_revealedIndex]),
        ],
        const SizedBox(height: 24),
        OutlinedButton(
          onPressed: () => setState(() {
            _cards = [];
            _revealedIndex = -1;
          }),
          style: OutlinedButton.styleFrom(foregroundColor: AppTheme.accent),
          child: const Text('重新占卜'),
        ),
      ],
    );
  }

  void _revealCard(int i) {
    if (_revealedIndex < i) {
      setState(() => _revealedIndex = i);
    } else {
      setState(() => _revealedIndex = i);
    }
  }

  Widget _buildCardBack(double w, double h) {
    return Container(
      width: w, height: h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [AppTheme.primary, AppTheme.primaryDark],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accent.withOpacity(0.4), width: 2),
      ),
      child: Center(
        child: Icon(Icons.auto_awesome, color: AppTheme.accent.withOpacity(0.5), size: 32),
      ),
    );
  }

  Widget _buildRevealedCard(TarotCard card, double w, double h) {
    return Container(
      width: w, height: h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [AppTheme.bgCard, AppTheme.primaryDark],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.accent, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${card.number}', style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.accent)),
          const SizedBox(height: 4),
          Text(card.name, style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
          if (card.isReversed)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('逆位', style: TextStyle(fontSize: 10, color: AppTheme.textSecondary)),
            ),
        ],
      ),
    );
  }

  Widget _buildCardDetail(TarotCard card) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text('${card.number}', style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.accent)),
              const SizedBox(width: 12),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(card.name, style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                  Text(card.nameEn, style: TextStyle(
                    fontSize: 12, color: AppTheme.textSecondary)),
                ],
              )),
              if (card.isReversed)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.textSecondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                  child: Text('逆位', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary))),
            ]),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.bgDark.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: card.isReversed ? AppTheme.textSecondary.withOpacity(0.3) : AppTheme.accent.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(card.isReversed ? '逆位含义' : '正位含义', style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w600,
                    color: card.isReversed ? AppTheme.textSecondary : AppTheme.accent)),
                  const SizedBox(height: 8),
                  Text(card.currentMeaning, style: TextStyle(
                    fontSize: 15, color: AppTheme.textPrimary, height: 1.6)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
