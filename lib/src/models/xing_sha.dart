import 'package:bazi_core/bazi_core.dart';

/// 18星煞详情描述映射
const Map<String, String> starDescriptions = {
  '贵人': '既代表帮扶的贵人，也代表自身荣耀尊贵程度。甲戊见丑未，乙己见子申，丙丁见亥酉，庚辛见午寅，壬癸见卯巳。',
  '食禄': '即禄神，显示财福禄、享受、积蓄。甲禄寅，乙禄卯，丙戊禄巳，丁己禄午，庚禄申，辛禄酉，壬禄亥，癸禄子。',
  '羊刃': '双刃剑，功名权力与婚姻伤害并存，也示意外。甲刃卯，乙刃寅，丙戊刃午，丁己刃巳，庚刃酉，辛刃申，壬刃子，癸刃亥。',
  '驿马': '奔波远行之星。申子辰马在寅，巳酉丑马在亥，寅午戌马在申，亥卯未马在巳。',
  '桃花': '感情、名望、知名度。申子辰见酉，巳酉丑见午，寅午戌见卯，亥卯未见子。',
  '华盖': '聪明、孤僻、迷神秘。申子辰见辰，巳酉丑见丑，寅午戌见戌，亥卯未见未。月日支最重。',
  '劫煞': '阻滞、障碍、小人。申子辰在巳，巳酉丑在寅，寅午戌在亥，亥卯未在申。',
  '灾煞': '突发变故、短期障碍。申子辰在午，巳酉丑在卯，寅午戌在子，亥卯未在酉。',
  '将星': '领导才能、统领。申子辰在子，巳酉丑在酉，寅午戌在午，亥卯未在卯。以日支查。',
  '文昌': '技能、实操、思维。甲巳，乙午，丙戊申，丁己酉，庚亥，辛子，壬寅，癸卯。',
  '学堂': '学习机缘、求知欲。金(庚辛)见巳，木(甲乙)见亥，水(壬癸)见申，土(戊己)见申，火(丙丁)见寅。',
  '天医': '与医有缘，或体质易病。月支顺推一位（如卯月见寅）。',
  '天喜': '喜庆、娱乐、热闹。季节三合局的墓库对冲位。寅卯辰见戌，巳午未见丑，申酉戌见辰，亥子丑见未。',
  '孤辰寡宿': '孤独、单身。亥子丑见寅为孤，见戌为寡；寅卯辰见巳为孤，见丑为寡；巳午未见申为孤，见辰为寡；申酉戌见亥为孤，见未为寡。以年支查。',
  '阴差阳错': '婚姻感情波折。日柱为丙子、丙午、丁丑、丁未、戊寅、戊申、辛卯、辛酉、壬辰、壬戌、癸巳、癸亥。',
  '魁罡': '领导力，也易招官非。日柱为庚辰、庚戌、壬辰、戊戌。',
  '天罗地网': '体质欠佳。男命原局或大运流年与原局构成辰巳同见为天罗；女命戌亥同见为地网。',
  '四废': '颓废、徒劳。春(寅卯辰)见庚申辛酉，夏见壬子癸亥，秋见甲寅乙卯，冬见丙午丁巳。',
};

/// 自定义神煞基类（可直接复用原库的 ShenSha，这里独立一份以保持隔离）
abstract class MyShenSha {
  final String name;
  const MyShenSha(this.name);
  bool check(BaziChart chart, GanZhi gz, PillarType type);
}

// ---------- 1. 贵人类 ----------
class GuiRen extends MyShenSha {
  const GuiRen() : super('贵人');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final dayGan = chart.bazi.day.gan;
    final zhi = gz.zhi;
    switch (dayGan) {
      case TianGan.jia:
      case TianGan.wu:
        return zhi == DiZhi.chou || zhi == DiZhi.wei;
      case TianGan.yi:
      case TianGan.ji:
        return zhi == DiZhi.zi || zhi == DiZhi.shen;
      case TianGan.bing:
      case TianGan.ding:
        return zhi == DiZhi.hai || zhi == DiZhi.you;
      case TianGan.geng:
      case TianGan.xin:
        return zhi == DiZhi.wu || zhi == DiZhi.yin;
      case TianGan.ren:
      case TianGan.gui:
        return zhi == DiZhi.mao || zhi == DiZhi.si;
    }
  }
}

// ---------- 2. 食禄 ----------
class ShiLu extends MyShenSha {
  const ShiLu() : super('食禄');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final dayGan = chart.bazi.day.gan;
    final zhi = gz.zhi;
    switch (dayGan) {
      case TianGan.jia:
        return zhi == DiZhi.yin;
      case TianGan.yi:
        return zhi == DiZhi.mao;
      case TianGan.bing:
      case TianGan.wu:
        return zhi == DiZhi.si;
      case TianGan.ding:
      case TianGan.ji:
        return zhi == DiZhi.wu;
      case TianGan.geng:
        return zhi == DiZhi.shen;
      case TianGan.xin:
        return zhi == DiZhi.you;
      case TianGan.ren:
        return zhi == DiZhi.hai;
      case TianGan.gui:
        return zhi == DiZhi.zi;
    }
  }
}

// ---------- 3. 羊刃 ----------
class YangRen extends MyShenSha {
  const YangRen() : super('羊刃');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final dayGan = chart.bazi.day.gan;
    final zhi = gz.zhi;
    switch (dayGan) {
      case TianGan.jia:
        return zhi == DiZhi.mao;
      case TianGan.yi:
        return zhi == DiZhi.yin;
      case TianGan.bing:
      case TianGan.wu:
        return zhi == DiZhi.wu;
      case TianGan.ding:
      case TianGan.ji:
        return zhi == DiZhi.si;
      case TianGan.geng:
        return zhi == DiZhi.you;
      case TianGan.xin:
        return zhi == DiZhi.shen;
      case TianGan.ren:
        return zhi == DiZhi.zi;
      case TianGan.gui:
        return zhi == DiZhi.hai;
    }
  }
}

// ---------- 4. 驿马 ----------
class YiMa extends MyShenSha {
  const YiMa() : super('驿马');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final zhi = gz.zhi;
    // 年支、日支均可查，这里取并集
    bool match(DiZhi base) {
      if (base == DiZhi.shen || base == DiZhi.zi || base == DiZhi.chen)
        return zhi == DiZhi.yin;
      if (base == DiZhi.si || base == DiZhi.you || base == DiZhi.chou)
        return zhi == DiZhi.hai;
      if (base == DiZhi.yin || base == DiZhi.wu || base == DiZhi.xu)
        return zhi == DiZhi.shen;
      if (base == DiZhi.hai || base == DiZhi.mao || base == DiZhi.wei)
        return zhi == DiZhi.si;
      return false;
    }

    return match(chart.bazi.year.zhi) || match(chart.bazi.day.zhi);
  }
}

// ---------- 5. 桃花 ----------
class TaoHua extends MyShenSha {
  const TaoHua() : super('桃花');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final zhi = gz.zhi;
    bool match(DiZhi base) {
      if (base == DiZhi.shen || base == DiZhi.zi || base == DiZhi.chen)
        return zhi == DiZhi.you;
      if (base == DiZhi.si || base == DiZhi.you || base == DiZhi.chou)
        return zhi == DiZhi.wu;
      if (base == DiZhi.yin || base == DiZhi.wu || base == DiZhi.xu)
        return zhi == DiZhi.mao;
      if (base == DiZhi.hai || base == DiZhi.mao || base == DiZhi.wei)
        return zhi == DiZhi.zi;
      return false;
    }

    return match(chart.bazi.year.zhi) || match(chart.bazi.day.zhi);
  }
}

// ---------- 6. 华盖 ----------
class HuaGai extends MyShenSha {
  const HuaGai() : super('华盖');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    // 仅日支、月支查才定性，但我们也统计柱位，这里按规则检测即可
    final zhi = gz.zhi;
    bool match(DiZhi base) {
      if (base == DiZhi.shen || base == DiZhi.zi || base == DiZhi.chen)
        return zhi == DiZhi.chen;
      if (base == DiZhi.si || base == DiZhi.you || base == DiZhi.chou)
        return zhi == DiZhi.chou;
      if (base == DiZhi.yin || base == DiZhi.wu || base == DiZhi.xu)
        return zhi == DiZhi.xu;
      if (base == DiZhi.hai || base == DiZhi.mao || base == DiZhi.wei)
        return zhi == DiZhi.wei;
      return false;
    }

    return match(chart.bazi.day.zhi) || match(chart.bazi.month.zhi);
  }
}

// ---------- 7. 劫煞 ----------
class JieSha extends MyShenSha {
  const JieSha() : super('劫煞');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final zhi = gz.zhi;
    bool match(DiZhi base) {
      if (base == DiZhi.shen || base == DiZhi.zi || base == DiZhi.chen)
        return zhi == DiZhi.si;
      if (base == DiZhi.si || base == DiZhi.you || base == DiZhi.chou)
        return zhi == DiZhi.yin;
      if (base == DiZhi.yin || base == DiZhi.wu || base == DiZhi.xu)
        return zhi == DiZhi.hai;
      if (base == DiZhi.hai || base == DiZhi.mao || base == DiZhi.wei)
        return zhi == DiZhi.shen;
      return false;
    }

    return match(chart.bazi.year.zhi) || match(chart.bazi.day.zhi);
  }
}

// ---------- 8. 灾煞 ----------
class ZaiSha extends MyShenSha {
  const ZaiSha() : super('灾煞');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final zhi = gz.zhi;
    bool match(DiZhi base) {
      if (base == DiZhi.shen || base == DiZhi.zi || base == DiZhi.chen)
        return zhi == DiZhi.wu;
      if (base == DiZhi.si || base == DiZhi.you || base == DiZhi.chou)
        return zhi == DiZhi.mao;
      if (base == DiZhi.yin || base == DiZhi.wu || base == DiZhi.xu)
        return zhi == DiZhi.zi;
      if (base == DiZhi.hai || base == DiZhi.mao || base == DiZhi.wei)
        return zhi == DiZhi.you;
      return false;
    }

    return match(chart.bazi.year.zhi) || match(chart.bazi.day.zhi);
  }
}

// ---------- 9. 将星 ----------
class JiangXing extends MyShenSha {
  const JiangXing() : super('将星');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final zhi = gz.zhi;
    bool match(DiZhi base) {
      if (base == DiZhi.shen || base == DiZhi.zi || base == DiZhi.chen)
        return zhi == DiZhi.zi;
      if (base == DiZhi.si || base == DiZhi.you || base == DiZhi.chou)
        return zhi == DiZhi.you;
      if (base == DiZhi.yin || base == DiZhi.wu || base == DiZhi.xu)
        return zhi == DiZhi.wu;
      if (base == DiZhi.hai || base == DiZhi.mao || base == DiZhi.wei)
        return zhi == DiZhi.mao;
      return false;
    }

    return match(chart.bazi.day.zhi); // 仅日支
  }
}

// ---------- 10. 文昌 ----------
class WenChang extends MyShenSha {
  const WenChang() : super('文昌');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final dayGan = chart.bazi.day.gan;
    final zhi = gz.zhi;
    switch (dayGan) {
      case TianGan.jia:
        return zhi == DiZhi.si;
      case TianGan.yi:
        return zhi == DiZhi.wu;
      case TianGan.bing:
      case TianGan.wu:
        return zhi == DiZhi.shen;
      case TianGan.ding:
      case TianGan.ji:
        return zhi == DiZhi.you;
      case TianGan.geng:
        return zhi == DiZhi.hai;
      case TianGan.xin:
        return zhi == DiZhi.zi;
      case TianGan.ren:
        return zhi == DiZhi.yin;
      case TianGan.gui:
        return zhi == DiZhi.mao;
    }
  }
}

// ---------- 11. 学堂 ----------
class XueTang extends MyShenSha {
  const XueTang() : super('学堂');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final dayGan = chart.bazi.day.gan;
    final wx = BaziTable.getWuXingOfGan(dayGan);
    final zhi = gz.zhi;
    switch (wx) {
      case WuXing.metal:
        return zhi == DiZhi.si;
      case WuXing.wood:
        return zhi == DiZhi.hai;
      case WuXing.water:
        return zhi == DiZhi.shen;
      case WuXing.fire:
        return zhi == DiZhi.yin;
      case WuXing.earth:
        return zhi == DiZhi.shen; // 土同水
    }
  }
}

// ---------- 12. 天医 ----------
class TianYi extends MyShenSha {
  const TianYi() : super('天医');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final monthZhi = chart.bazi.month.zhi;
    // 月支顺推一位（即 index - 1 取模）
    final target = DiZhi.values[(monthZhi.index - 1 + 12) % 12];
    return gz.zhi == target;
  }
}

// ---------- 13. 天喜 ----------
class TianXi extends MyShenSha {
  const TianXi() : super('天喜');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final monthZhi = chart.bazi.month.zhi;
    final zhi = gz.zhi;
    // 寅卯辰月，天喜在戌；巳午未月，在丑；申酉戌月，在辰；亥子丑月，在未
    if (monthZhi == DiZhi.yin ||
        monthZhi == DiZhi.mao ||
        monthZhi == DiZhi.chen)
      return zhi == DiZhi.xu;
    if (monthZhi == DiZhi.si || monthZhi == DiZhi.wu || monthZhi == DiZhi.wei)
      return zhi == DiZhi.chou;
    if (monthZhi == DiZhi.shen || monthZhi == DiZhi.you || monthZhi == DiZhi.xu)
      return zhi == DiZhi.chen;
    if (monthZhi == DiZhi.hai || monthZhi == DiZhi.zi || monthZhi == DiZhi.chou)
      return zhi == DiZhi.wei;
    return false;
  }
}

// ---------- 14. 孤辰寡宿 ----------
class GuChenGuaSu extends MyShenSha {
  const GuChenGuaSu() : super('孤辰寡宿');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final yearZhi = chart.bazi.year.zhi;
    final zhi = gz.zhi;
    // 孤寡都算，名称为“孤辰寡宿”
    if (yearZhi == DiZhi.hai || yearZhi == DiZhi.zi || yearZhi == DiZhi.chou) {
      return zhi == DiZhi.yin || zhi == DiZhi.xu;
    }
    if (yearZhi == DiZhi.yin || yearZhi == DiZhi.mao || yearZhi == DiZhi.chen) {
      return zhi == DiZhi.si || zhi == DiZhi.chou;
    }
    if (yearZhi == DiZhi.si || yearZhi == DiZhi.wu || yearZhi == DiZhi.wei) {
      return zhi == DiZhi.shen || zhi == DiZhi.chen;
    }
    if (yearZhi == DiZhi.shen || yearZhi == DiZhi.you || yearZhi == DiZhi.xu) {
      return zhi == DiZhi.hai || zhi == DiZhi.wei;
    }
    return false;
  }
}

// ---------- 15. 阴差阳错 ----------
class YinChaYangCuo extends MyShenSha {
  const YinChaYangCuo() : super('阴差阳错');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    if (type != PillarType.day) return false;
    final str = gz.toString();
    const targets = [
      '丙子',
      '丙午',
      '丁丑',
      '丁未',
      '戊寅',
      '戊申',
      '辛卯',
      '辛酉',
      '壬辰',
      '壬戌',
      '癸巳',
      '癸亥',
    ];
    return targets.contains(str);
  }
}

// ---------- 16. 魁罡 ----------
class KuiGang extends MyShenSha {
  const KuiGang() : super('魁罡');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    if (type != PillarType.day) return false;
    final str = gz.toString();
    const targets = ['庚辰', '庚戌', '壬辰', '戊戌'];
    return targets.contains(str);
  }
}

// ---------- 17. 天罗地网 ----------
class TianLuoDiWang extends MyShenSha {
  const TianLuoDiWang() : super('天罗地网');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    // 需要辰巳同见（男）或戌亥同见（女），这里仅作标记：若当前柱为辰或巳（男）且原局有另一字，或女同。我们简化：检查原局含全部所需支即可。
    final branches = {
      chart.bazi.year.zhi,
      chart.bazi.month.zhi,
      chart.bazi.day.zhi,
      chart.bazi.time.zhi,
    };
    final isMale = chart.gender == Gender.male;
    if (isMale) {
      if (branches.contains(DiZhi.chen) && branches.contains(DiZhi.si))
        return true;
    } else {
      if (branches.contains(DiZhi.xu) && branches.contains(DiZhi.hai))
        return true;
    }
    return false;
  }
}

// ---------- 18. 四废 ----------
class SiFei extends MyShenSha {
  const SiFei() : super('四废');
  @override
  bool check(BaziChart chart, GanZhi gz, PillarType type) {
    final monthZhi = chart.bazi.month.zhi;
    final str = gz.toString();
    if (monthZhi == DiZhi.yin ||
        monthZhi == DiZhi.mao ||
        monthZhi == DiZhi.chen)
      return str == '庚申' || str == '辛酉';
    if (monthZhi == DiZhi.si || monthZhi == DiZhi.wu || monthZhi == DiZhi.wei)
      return str == '壬子' || str == '癸亥';
    if (monthZhi == DiZhi.shen || monthZhi == DiZhi.you || monthZhi == DiZhi.xu)
      return str == '甲寅' || str == '乙卯';
    if (monthZhi == DiZhi.hai || monthZhi == DiZhi.zi || monthZhi == DiZhi.chou)
      return str == '丙午' || str == '丁巳';
    return false;
  }
}

// 自定义神煞列表
const List<MyShenSha> myShenShaList = [
  GuiRen(),
  ShiLu(),
  YangRen(),
  YiMa(),
  TaoHua(),
  HuaGai(),
  JieSha(),
  ZaiSha(),
  JiangXing(),
  WenChang(),
  XueTang(),
  TianYi(),
  TianXi(),
  GuChenGuaSu(),
  YinChaYangCuo(),
  KuiGang(),
  TianLuoDiWang(),
  SiFei(),
];
