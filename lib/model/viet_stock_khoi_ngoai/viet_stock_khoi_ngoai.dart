class VietStockKhoiNgoai {
  double? closeIndex;
  double? priorIndex;
  double? change;
  double? perChange;
  String? changeColor;
  String? changeText;
  String? trDate;
  int? tranNo;

  VietStockKhoiNgoai({
    this.closeIndex,
    this.priorIndex,
    this.change,
    this.perChange,
    this.changeColor,
    this.changeText,
    this.trDate,
    this.tranNo,
  });

  factory VietStockKhoiNgoai.fromJson(Map<String, dynamic> json) {
    return VietStockKhoiNgoai(
      closeIndex: (json['CloseIndex'] as num?)?.toDouble(),
      priorIndex: (json['PriorIndex'] as num?)?.toDouble(),
      change: (json['Change'] as num?)?.toDouble(),
      perChange: (json['PerChange'] as num?)?.toDouble(),
      changeColor: json['ChangeColor'] as String?,
      changeText: json['ChangeText'] as String?,
      trDate: json['TrDate'] as String?,
      tranNo: json['TranNo'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'CloseIndex': closeIndex,
        'PriorIndex': priorIndex,
        'Change': change,
        'PerChange': perChange,
        'ChangeColor': changeColor,
        'ChangeText': changeText,
        'TrDate': trDate,
        'TranNo': tranNo,
      };
}
