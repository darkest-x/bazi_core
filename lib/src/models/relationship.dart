import 'package:bazi_core/bazi_core.dart';

//增加地支十神表

class Relationship {
  // 当日主为“阳干”时，目标干与日主的位移(0-9)对应的十神
  static const List<ShiShen> _yangMasterTb = [
    ShiShen.biJian, // +0 (甲见甲)
    ShiShen.jieCai, // +1 (甲见乙)
    ShiShen.shiShen, // +2 (甲见丙)
    ShiShen.shangGuan, // +3 (甲见丁)
    ShiShen.zhengCai, // +4 (甲见戊)
    ShiShen.pianCai, // +5 (甲见己)
    ShiShen.qiSha, // +6 (甲见庚)
    ShiShen.zhengGuan, // +7 (甲见辛)
    ShiShen.pianYin, // +8 (甲见壬)
    ShiShen.zhengYin, // +9 (甲见癸)
  ];

  // 当日主为“阴干”时，目标干与日主的位移(0-9)对应的十神
  static const List<ShiShen> _yinMasterTb = [
    ShiShen.biJian, // +0 (乙见乙)
    ShiShen.shangGuan, // +1 (乙见丙)
    ShiShen.shiShen, // +2 (乙见丁)
    ShiShen.pianCai, // +3 (乙见戊)
    ShiShen.zhengCai, // +4 (乙见己)
    ShiShen.zhengGuan, // +5 (乙见庚)
    ShiShen.qiSha, // +6 (乙见辛)
    ShiShen.zhengYin, // +7 (乙见壬)
    ShiShen.pianYin, // +8 (乙见癸)
    ShiShen.jieCai, // +9 (乙见甲)
  ];

  /// 地支十神相位表 (地支十神)
  /// 行: [阳干, 阴干]
  /// 列: 12地支 (子, 丑, 寅, 卯, 辰, 巳, 午, 未, 申, 酉, 戌, 亥)
  /// 遵循: 同性生克为实，日干与地支同性相克为实、日干与地支同性相生为实
  /// 阳干: 甲、丙、戊、庚、壬
  /// 阴干: 乙、丁、己、辛、癸
  static const List<ShiShen> _yangDiZhiShiShenTb = [
    // --- 阳干行 (甲、丙、戊、庚、壬) ---
    ShiShen.zhengYin, // 子 (阳干+阳支 = 正印，水生木)
    ShiShen.pianCai, // 丑 (阳干+阴支 = 正财，土克水)
    ShiShen.biJian, // 寅 (阳干+阳支 = 比肩，木同木)
    ShiShen.jieCai, // 卯 (阳干+阴支 = 劫财，木同木)
    ShiShen.zhengCai, // 辰 (阳干+阳支 = 偏财，土克水)
    ShiShen.shiShen, // 巳 (阳干+阴支 = 食神，火生土)
    ShiShen.shangGuan, // 午 (阳干+阳支 = 伤官，火生土)
    ShiShen.pianCai, // 未 (阳干+阴支 = 正财，土克水)
    ShiShen.qiSha, // 申 (阳干+阳支 = 七杀，金克木)
    ShiShen.zhengGuan, // 酉 (阳干+阴支 = 正官，金克木)
    ShiShen.zhengCai, // 戌 (阳干+阳支 = 偏财，土克水)
    ShiShen.pianYin, // 亥 (阳干+阴支 = 偏印，水生木)
  ];
  // --- 阴干行 (乙、丁、己、辛、癸) ---
  static const List<ShiShen> _yinDiZhiShiShenTb = [
    ShiShen.pianYin, // 子 (阴干+阳支 = 偏印，水生木)
    ShiShen.zhengCai, // 丑 (阴干+阴支 = 偏财，土克水)
    ShiShen.jieCai, // 寅 (阴干+阳支 = 劫财，木同木)
    ShiShen.biJian, // 卯 (阴干+阴支 = 比肩，木同木)
    ShiShen.pianCai, // 辰 (阴干+阳支 = 正财，土克水)
    ShiShen.shangGuan, // 巳 (阴干+阴支 = 伤官，火生土)
    ShiShen.shiShen, // 午 (阴干+阳支 = 食神，火生土)
    ShiShen.zhengCai, // 未 (阴干+阴支 = 偏财，土克水)
    ShiShen.zhengGuan, // 申 (阴干+阳支 = 正官，金克木)
    ShiShen.qiSha, // 酉 (阴干+阴支 = 七杀，金克木)
    ShiShen.pianCai, // 戌 (阴干+阳支 = 正财，土克水)
    ShiShen.zhengYin, // 亥 (阴干+阴支 = 正印，水生木)
  ];

  /// 获取天干相对于日主的十神关系
  static ShiShen getShiShen(TianGan dayMaster, TianGan targetGan) {
    // 统一计算位移 d (0-9)
    int d = (targetGan.index - dayMaster.index + 10) % 10;

    if (BaziTable.getYinYangOfGan(dayMaster) == YinYang.yang) {
      return _yangMasterTb[d];
    } else {
      return _yinMasterTb[d];
    }
  }

  /// 获取地支相对于日主的十神
  /// [dayMaster] 日干
  /// [targetZhi] 目标地支
  /// 规则：以日干五行为基准，看地支五行，按生克+同性异性定十神
  static ShiShen getDiZhiShiShen(TianGan dayMaster, DiZhi targetZhi) {
    final dmWx = BaziTable.getWuXingOfGan(dayMaster); // 日干五行
    final dmYy = BaziTable.getYinYangOfGan(dayMaster); // 日干阴阳
    final zhiWx = BaziTable.getWuXingOfZhi(targetZhi); // 地支五行
    final zhiYy = BaziTable.getYinYangOfZhi(targetZhi); // 地支阴阳

    final sameYinYang = (dmYy == zhiYy); // 同性为 true

    if (dmWx == zhiWx) {
      // 五行相同 → 比劫
      return sameYinYang ? ShiShen.biJian : ShiShen.jieCai;
    } else if (_woSheng(dmWx) == zhiWx) {
      // 我生者 → 食伤
      return sameYinYang ? ShiShen.shiShen : ShiShen.shangGuan;
    } else if (_woKe(dmWx) == zhiWx) {
      // 我克者 → 财
      return sameYinYang ? ShiShen.pianCai : ShiShen.zhengCai;
    } else if (_keWo(dmWx) == zhiWx) {
      // 克我者 → 官杀
      return sameYinYang ? ShiShen.qiSha : ShiShen.zhengGuan;
    } else {
      // 生我者 → 印
      return sameYinYang ? ShiShen.pianYin : ShiShen.zhengYin;
    }
  }

  // 五行相生：我生者
  static WuXing _woSheng(WuXing w) {
    switch (w) {
      case WuXing.wood:
        return WuXing.fire;
      case WuXing.fire:
        return WuXing.earth;
      case WuXing.earth:
        return WuXing.metal;
      case WuXing.metal:
        return WuXing.water;
      case WuXing.water:
        return WuXing.wood;
    }
  }

  // 五行相克：我克者
  static WuXing _woKe(WuXing w) {
    switch (w) {
      case WuXing.wood:
        return WuXing.earth;
      case WuXing.fire:
        return WuXing.metal;
      case WuXing.earth:
        return WuXing.water;
      case WuXing.metal:
        return WuXing.wood;
      case WuXing.water:
        return WuXing.fire;
    }
  }

  // 克我者
  static WuXing _keWo(WuXing w) {
    switch (w) {
      case WuXing.wood:
        return WuXing.metal;
      case WuXing.fire:
        return WuXing.water;
      case WuXing.earth:
        return WuXing.wood;
      case WuXing.metal:
        return WuXing.fire;
      case WuXing.water:
        return WuXing.earth;
    }
  }

  /// 获取地支藏干相对于日主的十神列表
  static List<ShiShen> getCangGanShiShen(TianGan dayMaster, DiZhi targetZhi) {
    return BaziTable.getCangGan(
      targetZhi,
    ).map((gan) => getShiShen(dayMaster, gan)).toList();
  }
}
