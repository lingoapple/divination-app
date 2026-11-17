/// 算命模块数据 — 天干地支、星座、塔罗牌、生肖等静态数据

class DivinationData {
  // 天干
  static const List<String> tianGan = [
    '甲', '乙', '丙', '丁', '戊', '己', '庚', '辛', '壬', '癸'
  ];

  // 地支
  static const List<String> diZhi = [
    '子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'
  ];

  // 生肖
  static const List<String> shengXiao = [
    '鼠', '牛', '虎', '兔', '龙', '蛇', '马', '羊', '猴', '鸡', '狗', '猪'
  ];

  // 五行对应
  static const Map<String, String> wuXingMap = {
    '甲': '木', '乙': '木',
    '丙': '火', '丁': '火',
    '戊': '土', '己': '土',
    '庚': '金', '辛': '金',
    '壬': '水', '癸': '水',
    '子': '水', '丑': '土',
    '寅': '木', '卯': '木',
    '辰': '土', '巳': '火',
    '午': '火', '未': '土',
    '申': '金', '酉': '金',
    '戌': '土', '亥': '水',
  };

  // 十二星座
  static const List<Map<String, dynamic>> zodiacSigns = [
    {'name': '白羊座', 'nameEn': 'Aries', 'dateRange': '3.21-4.19', 'element': '火', 'ruler': '火星', 'symbol': '♈', 'icon': 0x2648},
    {'name': '金牛座', 'nameEn': 'Taurus', 'dateRange': '4.20-5.20', 'element': '土', 'ruler': '金星', 'symbol': '♉', 'icon': 0x2649},
    {'name': '双子座', 'nameEn': 'Gemini', 'dateRange': '5.21-6.21', 'element': '风', 'ruler': '水星', 'symbol': '♊', 'icon': 0x264A},
    {'name': '巨蟹座', 'nameEn': 'Cancer', 'dateRange': '6.22-7.22', 'element': '水', 'ruler': '月亮', 'symbol': '♋', 'icon': 0x264B},
    {'name': '狮子座', 'nameEn': 'Leo', 'dateRange': '7.23-8.22', 'element': '火', 'ruler': '太阳', 'symbol': '♌', 'icon': 0x264C},
    {'name': '处女座', 'nameEn': 'Virgo', 'dateRange': '8.23-9.22', 'element': '土', 'ruler': '水星', 'symbol': '♍', 'icon': 0x264D},
    {'name': '天秤座', 'nameEn': 'Libra', 'dateRange': '9.23-10.23', 'element': '风', 'ruler': '金星', 'symbol': '♎', 'icon': 0x264E},
    {'name': '天蝎座', 'nameEn': 'Scorpio', 'dateRange': '10.24-11.22', 'element': '水', 'ruler': '冥王星', 'symbol': '♏', 'icon': 0x264F},
    {'name': '射手座', 'nameEn': 'Sagittarius', 'dateRange': '11.23-12.21', 'element': '火', 'ruler': '木星', 'symbol': '♐', 'icon': 0x2650},
    {'name': '摩羯座', 'nameEn': 'Capricorn', 'dateRange': '12.22-1.19', 'element': '土', 'ruler': '土星', 'symbol': '♑', 'icon': 0x2651},
    {'name': '水瓶座', 'nameEn': 'Aquarius', 'dateRange': '1.20-2.18', 'element': '风', 'ruler': '天王星', 'symbol': '♒', 'icon': 0x2652},
    {'name': '双鱼座', 'nameEn': 'Pisces', 'dateRange': '2.19-3.20', 'element': '水', 'ruler': '海王星', 'symbol': '♓', 'icon': 0x2653},
  ];

  // 塔罗牌大阿卡纳（22张）
  static const List<Map<String, dynamic>> majorArcana = [
    {'name': '愚者', 'nameEn': 'The Fool', 'number': 0, 'upright': '新的开始、冒险、自由、天真', 'reversed': '鲁莽、冲动、缺乏计划'},
    {'name': '魔术师', 'nameEn': 'The Magician', 'number': 1, 'upright': '创造力、意志力、技能、掌控', 'reversed': '操纵、未发挥才能、欺骗'},
    {'name': '女祭司', 'nameEn': 'The High Priestess', 'number': 2, 'upright': '直觉、神秘、潜意识、智慧', 'reversed': '秘密被揭露、直觉忽略'},
    {'name': '皇后', 'nameEn': 'The Empress', 'number': 3, 'upright': '丰盛、母性、创造力、自然', 'reversed': '依赖、过度保护、创造力受阻'},
    {'name': '皇帝', 'nameEn': 'The Emperor', 'number': 4, 'upright': '权威、结构、控制、父亲', 'reversed': '专横、僵化、缺乏自律'},
    {'name': '教皇', 'nameEn': 'The Hierophant', 'number': 5, 'upright': '传统、信仰、教育、指导', 'reversed': '反叛、非传统、自由思想'},
    {'name': '恋人', 'nameEn': 'The Lovers', 'number': 6, 'upright': '爱情、选择、和谐、价值观', 'reversed': '不和谐、失衡、错误选择'},
    {'name': '战车', 'nameEn': 'The Chariot', 'number': 7, 'upright': '胜利、意志力、控制、前进', 'reversed': '失控、缺乏方向、攻击性'},
    {'name': '力量', 'nameEn': 'Strength', 'number': 8, 'upright': '勇气、耐心、内在力量、温柔', 'reversed': '自我怀疑、软弱、缺乏勇气'},
    {'name': '隐士', 'nameEn': 'The Hermit', 'number': 9, 'upright': '内省、独处、寻求答案、智慧', 'reversed': '孤立、退缩、拒绝指导'},
    {'name': '命运之轮', 'nameEn': 'Wheel of Fortune', 'number': 10, 'upright': '命运、转折、机遇、循环', 'reversed': '厄运、阻力、失控'},
    {'name': '正义', 'nameEn': 'Justice', 'number': 11, 'upright': '公平、真相、法律、因果', 'reversed': '不公、偏颇、逃避责任'},
    {'name': '倒吊人', 'nameEn': 'The Hanged Man', 'number': 12, 'upright': '牺牲、等待、新视角、放手', 'reversed': '无谓牺牲、停滞、抗拒改变'},
    {'name': '死神', 'nameEn': 'Death', 'number': 13, 'upright': '终结、转变、重生、放下过去', 'reversed': '抗拒变化、停滞、无法前进'},
    {'name': '节制', 'nameEn': 'Temperance', 'number': 14, 'upright': '平衡、适度、耐心、调和', 'reversed': '失衡、过度、缺乏耐心'},
    {'name': '恶魔', 'nameEn': 'The Devil', 'number': 15, 'upright': '束缚、欲望、物质主义、执念', 'reversed': '解脱、觉醒、释放束缚'},
    {'name': '高塔', 'nameEn': 'The Tower', 'number': 16, 'upright': '突变、瓦解、启示、觉醒', 'reversed': '避免灾难、恐惧改变、内在转变'},
    {'name': '星星', 'nameEn': 'The Star', 'number': 17, 'upright': '希望、灵感、宁静、信念', 'reversed': '绝望、失去信心、悲观'},
    {'name': '月亮', 'nameEn': 'The Moon', 'number': 18, 'upright': '幻觉、恐惧、潜意识、直觉', 'reversed': '释放恐惧、真相揭露、内在困惑'},
    {'name': '太阳', 'nameEn': 'The Sun', 'number': 19, 'upright': '快乐、成功、活力、积极', 'reversed': '暂时的阴霾、过度乐观、延迟成功'},
    {'name': '审判', 'nameEn': 'Judgement', 'number': 20, 'upright': '重生、觉醒、救赎、决定', 'reversed': '自我怀疑、逃避呼唤、犹豫'},
    {'name': '世界', 'nameEn': 'The World', 'number': 21, 'upright': '圆满、完成、成就、旅程结束', 'reversed': '未完成、停滞、差一步'},
  ];

  // 生肖运势关键词
  static const Map<String, Map<String, dynamic>> shengXiaoFortune = {
    '鼠': {'overall': '机智灵活，善于把握机会', 'lucky': '蓝、白、金', 'element': '水'},
    '牛': {'overall': '勤劳踏实，厚积薄发', 'lucky': '黄、橙、棕', 'element': '土'},
    '虎': {'overall': '气势如虹，勇往直前', 'lucky': '蓝、灰、白', 'element': '木'},
    '兔': {'overall': '温和聪慧，贵人相助', 'lucky': '粉、绿、蓝', 'element': '木'},
    '龙': {'overall': '运势旺盛，大展宏图', 'lucky': '金、银、白', 'element': '土'},
    '蛇': {'overall': '智慧深邃，运筹帷幄', 'lucky': '红、黄、黑', 'element': '火'},
    '马': {'overall': '精力充沛，驰骋千里', 'lucky': '红、紫、橙', 'element': '火'},
    '羊': {'overall': '心平气和，福气自来', 'lucky': '绿、红、紫', 'element': '土'},
    '猴': {'overall': '机灵多变，好事连连', 'lucky': '白、蓝、金', 'element': '金'},
    '鸡': {'overall': '勤奋精明，收获丰厚', 'lucky': '金、棕、黄', 'element': '金'},
    '狗': {'overall': '忠诚可靠，稳步前进', 'lucky': '绿、红、橙', 'element': '土'},
    '猪': {'overall': '福气满满，心想事成', 'lucky': '黄、灰、棕', 'element': '水'},
  };

  /// 根据出生年份计算天干地支（年柱）
  static String getYearGanZhi(int year) {
    // 1900年为庚子年，庚=6(0-indexed: 6), 子=0
    int ganIndex = (year - 4) % 10;  // 4年为甲子年
    int zhiIndex = (year - 4) % 12;
    if (ganIndex < 0) ganIndex += 10;
    if (zhiIndex < 0) zhiIndex += 12;
    return '${tianGan[ganIndex]}${diZhi[zhiIndex]}';
  }

  /// 根据年份获取生肖
  static String getShengXiao(int year) {
    // 0=鼠, 1900年鼠
    int index = (year - 4) % 12;
    if (index < 0) index += 12;
    return shengXiao[index];
  }

  /// 根据出生月份日期获取星座
  static Map<String, dynamic> getZodiac(int month, int day) {
    List<List<int>> ranges = [
      [321, 419], [420, 520], [521, 621], [622, 722],
      [723, 822], [823, 922], [923, 1023], [1024, 1122],
      [1123, 1221], [1222, 1231], [101, 119], [220, 320],
    ];
    int md = month * 100 + day;
    // 摩羯座跨年
    if (md >= 1222 || md <= 119) return zodiacSigns[9];
    for (int i = 0; i < 9; i++) {
      if (md >= ranges[i][0] && md <= ranges[i][1]) return zodiacSigns[i];
    }
    // 水瓶 1.20-2.18
    if (md >= 120 && md <= 218) return zodiacSigns[10];
    // 双鱼 2.19-3.20
    if (md >= 219 && md <= 320) return zodiacSigns[11];
    return zodiacSigns[0];
  }
}
