/// 八字数据模型
class BaZiModel {
  final String yearGanZhi;   // 年柱
  final String monthGanZhi;  // 月柱
  final String dayGanZhi;    // 日柱
  final String hourGanZhi;   // 时柱
  final String wuXing;       // 五行分析
  final String summary;      // 命理摘要

  BaZiModel({
    required this.yearGanZhi,
    required this.monthGanZhi,
    required this.dayGanZhi,
    required this.hourGanZhi,
    required this.wuXing,
    required this.summary,
  });

  factory BaZiModel.fromJson(Map<String, dynamic> json) {
    return BaZiModel(
      yearGanZhi: json['yearGanZhi'] ?? '',
      monthGanZhi: json['monthGanZhi'] ?? '',
      dayGanZhi: json['dayGanZhi'] ?? '',
      hourGanZhi: json['hourGanZhi'] ?? '',
      wuXing: json['wuXing'] ?? '',
      summary: json['summary'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'yearGanZhi': yearGanZhi,
    'monthGanZhi': monthGanZhi,
    'dayGanZhi': dayGanZhi,
    'hourGanZhi': hourGanZhi,
    'wuXing': wuXing,
    'summary': summary,
  };
}

/// 塔罗牌数据模型
class TarotCard {
  final String name;
  final String nameEn;
  final int number;
  final bool isReversed;
  final String uprightMeaning;   // 正位含义
  final String reversedMeaning;  // 逆位含义
  final String imageAsset;

  TarotCard({
    required this.name,
    required this.nameEn,
    required this.number,
    this.isReversed = false,
    required this.uprightMeaning,
    required this.reversedMeaning,
    this.imageAsset = '',
  });

  String get currentMeaning => isReversed ? reversedMeaning : uprightMeaning;
}

/// 星座模型
class ZodiacSign {
  final String name;
  final String nameEn;
  final String dateRange;
  final String element;       // 元素：火/土/风/水
  final String ruler;         // 守护星
  final String symbol;        // 符号
  final int iconCode;         // emoji code

  ZodiacSign({
    required this.name,
    required this.nameEn,
    required this.dateRange,
    required this.element,
    required this.ruler,
    required this.symbol,
    required this.iconCode,
  });
}

/// 每日运势模型
class DailyFortune {
  final int loveScore;       // 桃花运 0-100
  final int wealthScore;     // 财运
  final int healthScore;     // 健康运
  final int careerScore;     // 事业运
  final String luckyColor;   // 幸运色
  final String luckyNumber;  // 幸运数字
  final String luckyDirection; // 幸运方位
  final String advice;       // 建议

  DailyFortune({
    required this.loveScore,
    required this.wealthScore,
    required this.healthScore,
    required this.careerScore,
    required this.luckyColor,
    required this.luckyNumber,
    required this.luckyDirection,
    required this.advice,
  });
}
