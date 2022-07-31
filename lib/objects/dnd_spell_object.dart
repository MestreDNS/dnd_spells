class DndSpellObj {
  String nameEn;
  // String nameBr;
  // String dlcName;
  List<dynamic> spellCasters;
  int level;
  String school;
  String castingTime;
  // String castingType;
  // String target;
  String range;
  // String rangeType;
  bool concentration;
  String duration;
  // String durationType;
  List<dynamic> components;
  String componentsDescEn;
  // List<dynamic> componentsDescBr;
  List<dynamic> descEn;
  // String descBr;
  List<dynamic> atHigherLevelsEn;
  // String atHigherLevelsBr;

  DndSpellObj({
    required this.nameEn,
    // required this.nameBr,
    // required this.dlcName,
    required this.spellCasters,
    required this.level,
    required this.school,
    required this.castingTime,
    // required this.castingType,
    // required this.target,
    required this.range,
    // required this.rangeType,
    required this.concentration,
    required this.duration,
    // required this.durationType,
    required this.components,
    required this.componentsDescEn,
    // required this.componentsDescBr,
    required this.descEn,
    // required this.descBr,
    required this.atHigherLevelsEn,
    // required this.atHigherLevelsBr,
  });

  factory DndSpellObj.fromJson(Map<String, dynamic> json) => DndSpellObj(
        nameEn: json['name'],
        // nameBr: json['name_br'],
        // dlcName: json['dlc_name'],
        spellCasters: json['classes'],
        level: json['level'],
        school: json['school']['name'],
        castingTime: json['casting_time'],
        // castingType: json['casting_type'],
        // target: json['target'],
        range: json['range'],
        // rangeType: json['range_type'],
        concentration: json['concentration'],
        duration: json['duration'],
        // durationType: json['duration_type'],
        components: json['components'],
        componentsDescEn: json['material'] ?? '',
        // componentsDescBr: json['components_desc_br'],
        descEn: json['desc'],
        // descBr: "json['desc_br']",
        atHigherLevelsEn: json['higher_level'],
        // atHigherLevelsBr: json['at_higher_levels_br'],
      );
}
