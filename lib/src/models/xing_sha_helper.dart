import 'package:bazi_core/bazi_core.dart';
import 'xing_sha.dart'; // 上述文件

class StarItem {
  final String name;
  final String description;
  const StarItem(this.name, this.description);
}

class MyShenShaResult {
  final Map<PillarType, List<StarItem>> pillarStars;
  MyShenShaResult(this.pillarStars);

  /// 获取所有柱位上的星煞名称（用于快速索引）
  List<String> get allNames =>
      pillarStars.values.expand((l) => l.map((e) => e.name)).toSet().toList();
}

class MyShenShaHelper {
  /// 分析全盘，返回每个柱位的星煞及描述
  static MyShenShaResult analyze(
    BaziChart chart, {
    bool includeMingGong = false,
    bool includeShenGong = false,
    bool includeTaiYuan = false,
    bool includeTaiXi = false,
  }) {
    final Map<PillarType, List<StarItem>> map = {};

    void add(PillarType type, GanZhi gz) {
      final items = <StarItem>[];
      for (final star in myShenShaList) {
        if (star.check(chart, gz, type)) {
          items.add(StarItem(star.name, starDescriptions[star.name] ?? ''));
        }
      }
      if (items.isNotEmpty) map[type] = items;
    }

    add(PillarType.year, chart.bazi.year);
    add(PillarType.month, chart.bazi.month);
    add(PillarType.day, chart.bazi.day);
    add(PillarType.hour, chart.bazi.time);
    if (includeMingGong) add(PillarType.mingGong, chart.mingGong);
    if (includeShenGong) add(PillarType.shenGong, chart.shenGong);
    if (includeTaiYuan) add(PillarType.taiYuan, chart.taiYuan);
    if (includeTaiXi) add(PillarType.taiXi, chart.taiXi);

    return MyShenShaResult(map);
  }

  /// 单柱查询
  static List<StarItem> getShenSha(
    BaziChart chart,
    GanZhi gz,
    PillarType type,
  ) {
    final items = <StarItem>[];
    for (final star in myShenShaList) {
      if (star.check(chart, gz, type)) {
        items.add(StarItem(star.name, starDescriptions[star.name] ?? ''));
      }
    }
    return items;
  }
}
