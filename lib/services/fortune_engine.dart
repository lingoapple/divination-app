import 'dart:math';
import '../models/fortune_models.dart';
import '../utils/divination_data.dart';

/// 本地算命引擎 — 在无网络/未接入LLM时提供即时结果
class FortuneEngine {
  static final Random _random = Random();

  /// 计算八字
  static BaZiModel calculateBaZi(DateTime birthDate, int birthHour) {
    final year = birthDate.year;
    final yearGanZhi = DivinationData.getYearGanZhi(year);

    // 简化月柱计算（基于节气近似）
    final month = birthDate.month;
    final monthGanZhi = _getMonthGanZhi(year, month);

    // 日柱（简化：基于日期偏移）
    final dayGanZhi = _getDayGanZhi(birthDate);

    // 时柱
    final hourGanZhi = _getHourGanZhi(dayGanZhi, birthHour);

    // 五行统计
    final wuXing = _analyzeWuXing([yearGanZhi, monthGanZhi, dayGanZhi, hourGanZhi]);

    final summary = _generateBaZiSummary(yearGanZhi, monthGanZhi, dayGanZhi, hourGanZhi, wuXing);

    return BaZiModel(
      yearGanZhi: yearGanZhi,
      monthGanZhi: monthGanZhi,
      dayGanZhi: dayGanZhi,
      hourGanZhi: hourGanZhi,
      wuXing: wuXing,
      summary: summary,
    );
  }

  static String _getMonthGanZhi(int year, int month) {
    // 月支固定（寅月为正月）
    final monthZhi = DivinationData.diZhi[(month + 1) % 12];
    // 月干根据年干推算（五虎遁）
    final yearGanIndex = (year - 4) % 10;
    final startGan = (yearGanIndex % 5) * 2 + 2; // 甲己年起丙寅
    final monthGanIndex = (startGan + month - 1) % 10;
    return '${DivinationData.tianGan[monthGanIndex]}$monthZhi';
  }

  static String _getDayGanZhi(DateTime date) {
    // 以1900-01-01（甲戌日）为基准
    final baseDate = DateTime(1900, 1, 1);
    final daysDiff = date.difference(baseDate).inDays;
    final ganIndex = (daysDiff + 10) % 10; // 甲戌=甲(0)+戌
    final zhiIndex = (daysDiff + 10) % 12; // 戌=10
    return '${DivinationData.tianGan[ganIndex]}${DivinationData.diZhi[zhiIndex]}';
  }

  static String _getHourGanZhi(String dayGanZhi, int hour) {
    // 时支：子时=23-1点, 丑时=1-3点...
    final hourZhiIndex = ((hour + 1) ~/ 2) % 12;
    final hourZhi = DivinationData.diZhi[hourZhiIndex];
    // 时干（五鼠遁）：根据日干推算
    final dayGan = dayGanZhi[0];
    final dayGanIndex = DivinationData.tianGan.indexOf(dayGan);
    final startGan = (dayGanIndex % 5) * 2; // 甲己日起甲子时
    final hourGanIndex = (startGan + hourZhiIndex) % 10;
    return '${DivinationData.tianGan[hourGanIndex]}$hourZhi';
  }

  static String _analyzeWuXing(List<String> ganZhiList) {
    Map<String, int> counts = {'木': 0, '火': 0, '土': 0, '金': 0, '水': 0};
    for (var gz in ganZhiList) {
      for (var char in gz.split('')) {
        final wx = DivinationData.wuXingMap[char];
        if (wx != null) counts[wx] = counts[wx]! + 1;
      }
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final result = sorted.where((e) => e.value > 0)
        .map((e) => '${e.key}:${e.value}')
        .join(' ');
    final dominant = sorted.first.key;
    final lacking = sorted.last.key;
    return '$result\n主导五行：$dominant\n需补五行：$lacking';
  }

  static String _generateBaZiSummary(
    String year, String month, String day, String hour, String wuXing) {
    return '你的八字为：$year $month $day $hour\n\n$wuXing\n\n命理分析：八字五行有偏有全，人生格局各有千秋。建议在日常生活中注意五行平衡，顺势而为。';
  }

  /// 抽塔罗牌
  static List<TarotCard> drawTarotCards({int count = 3}) {
    final cards = <TarotCard>[];
    final usedIndices = <int>{};
    while (cards.length < count && cards.length < DivinationData.majorArcana.length) {
      final index = _random.nextInt(DivinationData.majorArcana.length);
      if (usedIndices.contains(index)) continue;
      usedIndices.add(index);
      final data = DivinationData.majorArcana[index];
      cards.add(TarotCard(
        name: data['name'],
        nameEn: data['nameEn'],
        number: data['number'],
        isReversed: _random.nextBool(),
        uprightMeaning: data['upright'],
        reversedMeaning: data['reversed'],
      ));
    }
    return cards;
  }

  /// 生成每日运势
  static DailyFortune generateDailyFortune(String zodiacSign, DateTime date) {
    // 用日期和星座名生成种子，保证同一天同一星座结果一致
    final seed = date.year * 10000 + date.month * 100 + date.day +
        zodiacSign.hashCode;
    final rng = Random(seed);

    return DailyFortune(
      loveScore: 40 + rng.nextInt(60),
      wealthScore: 40 + rng.nextInt(60),
      healthScore: 50 + rng.nextInt(50),
      careerScore: 40 + rng.nextInt(60),
      luckyColor: ['红色', '蓝色', '绿色', '金色', '紫色', '白色', '橙色'][rng.nextInt(7)],
      luckyNumber: (1 + rng.nextInt(49)).toString(),
      luckyDirection: ['东方', '南方', '西方', '北方', '东南', '西南', '东北', '西北'][rng.nextInt(8)],
      advice: _getDailyAdvice(rng),
    );
  }

  static String _getDailyAdvice(Random rng) {
    final advices = [
      '今日宜静心思考，不宜冲动行事。',
      '贵人运旺，多与人沟通交流。',
      '财运亨通，但需防破财之灾。',
      '桃花旺盛，单身者有望遇到心仪之人。',
      '健康为重，注意作息规律。',
      '事业有突破之机，把握机会。',
      '宜出行远游，不宜久居室内。',
      '今日诸事不宜，宜静待时机。',
      '灵感迸发，适合创作和学习。',
      '人际关系和谐，宜参加聚会活动。',
    ];
    return advices[rng.nextInt(advices.length)];
  }

  /// MBTI 测试题目
  static List<Map<String, dynamic>> get mbtiQuestions => [
    {'dim': 'EI', 'q': '在聚会中，你通常：', 'a': '主动与很多人交谈，认识新朋友', 'b': '只和熟悉的人交谈，或安静观察'},
    {'dim': 'EI', 'q': '独处一段时间后，你会：', 'a': '感到精力充沛，享受独处', 'b': '感到孤独，渴望与人交流'},
    {'dim': 'EI', 'q': '你更倾向于：', 'a': '先行动再思考', 'b': '先思考再行动'},
    {'dim': 'SN', 'q': '你更相信：', 'a': '自己的经验和事实', 'b': '直觉和可能性'},
    {'dim': 'SN', 'q': '在学习新事物时，你更喜欢：', 'a': '从实际应用中学习', 'b': '从理论和概念中学习'},
    {'dim': 'SN', 'q': '你认为成功更多取决于：', 'a': '努力和勤奋', 'b': '灵感和机遇'},
    {'dim': 'TF', 'q': '做决定时，你更看重：', 'a': '逻辑和客观分析', 'b': '人情和价值观'},
    {'dim': 'TF', 'q': '朋友向你倾诉时，你通常：', 'a': '给出解决方案和建议', 'b': '表示理解和同情'},
    {'dim': 'TF', 'q': '你认为更重要的品质是：', 'a': '公正和理性', 'b': '仁慈和同理心'},
    {'dim': 'JP', 'q': '你的生活风格更偏向：', 'a': '有计划、有条理', 'b': '灵活、随性'},
    {'dim': 'JP', 'q': '面对截止日期，你通常：', 'a': '提前完成', 'b': '临近截止才开始'},
    {'dim': 'JP', 'q': '你更喜欢：', 'a': '确定性和计划性', 'b': '可能性和开放性'},
  ];

  /// 计算 MBTI 结果
  static String calculateMBTI(List<String> answers) {
    int e = 0, s = 0, t = 0, j = 0;
    for (int i = 0; i < answers.length; i++) {
      final dim = mbtiQuestions[i]['dim'];
      if (answers[i] == 'a') {
        if (dim == 'EI') e++;
        if (dim == 'SN') s++;
        if (dim == 'TF') t++;
        if (dim == 'JP') j++;
      }
    }
    final result = '${e > 2 ? 'E' : 'I'}${s > 2 ? 'S' : 'N'}${t > 2 ? 'T' : 'F'}${j > 2 ? 'J' : 'P'}';
    return result;
  }

  /// MBTI 类型描述
  static Map<String, Map<String, String>> get mbtiDescriptions => {
    'INTJ': {'name': '建筑师', 'desc': '富有想象力又有战略思维，一切都在计划之中'},
    'INTP': {'name': '逻辑学家', 'desc': '对知识有着不可遏制的渴望'},
    'ENTJ': {'name': '指挥官', 'desc': '大胆、富有想象力，意志强大'},
    'ENTP': {'name': '辩论家', 'desc': '聪明好奇的思想者，无法抗拒智力挑战'},
    'INFJ': {'name': '提倡者', 'desc': '安静而神秘，同时鼓舞人心且不知疲倦'},
    'INFP': {'name': '调停者', 'desc': '诗意、善良的利他主义者'},
    'ENFJ': {'name': '主人公', 'desc': '富有魅力、鼓舞人心的领导者'},
    'ENFP': {'name': '竞选者', 'desc': '热情、有创造力、社交活跃'},
    'ISTJ': {'name': '物流师', 'desc': '实际、注重事实，可靠性不容怀疑'},
    'ISFJ': {'name': '守卫者', 'desc': '非常专注而温暖的守护者'},
    'ESTJ': {'name': '总经理', 'desc': '务实、果断，管理事物或人的高手'},
    'ESFJ': {'name': '执政官', 'desc': '极有同情心，受欢迎，乐于助人'},
    'ISTP': {'name': '鉴赏家', 'desc': '大胆而实际的实验家'},
    'ISFP': {'name': '探险家', 'desc': '灵活、有魅力的艺术家'},
    'ESTP': {'name': '企业家', 'desc': '聪明、精力充沛，享受冒险'},
    'ESFP': {'name': '表演者', 'desc': '自发的、精力充沛的表演者'},
  };

  /// 起名打分（基于笔画和五行）
  static Map<String, dynamic> nameScore(String name) {
    if (name.isEmpty) return {'score': 0, 'analysis': '请输入姓名'};
    final score = 60 + name.length * 8 + _random.nextInt(20);
    final analysis = '「$name」总格数理为${score}分。'
        '${score >= 85 ? '大吉之名，寓意深远，前程似锦。' : score >= 70 ? '中吉之名，平稳顺遂，福泽绵长。' : '名字数理一般，建议搭配吉利字改善运势。'}';
    return {'score': score.clamp(0, 100), 'analysis': analysis};
  }
}
