import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';
import 'services/fortune_engine.dart';
import 'pages/home_page.dart';
import 'pages/bazi_page.dart';
import 'pages/zodiac_page.dart';
import 'pages/tarot_page.dart';
import 'pages/shengxiao_page.dart';
import 'pages/daily_fortune_page.dart';
import 'pages/mbti_page.dart';
import 'pages/name_page.dart';
import 'pages/history_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const DivinationApp());
}

class DivinationApp extends StatelessWidget {
  const DivinationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '天机阁 · 综合算命',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (ctx) => const HomePage(),
        '/bazi': (ctx) => const BaZiPage(),
        '/zodiac': (ctx) => const ZodiacPage(),
        '/tarot': (ctx) => const TarotPage(),
        '/shengxiao': (ctx) => const ShengXiaoPage(),
        '/daily': (ctx) => const DailyFortunePage(),
        '/mbti': (ctx) => const MBTIPage(),
        '/name': (ctx) => const NamePage(),
        '/history': (ctx) => const HistoryPage(),
        '/profile': (ctx) => const ProfilePage(),
      },
    );
  }
}
