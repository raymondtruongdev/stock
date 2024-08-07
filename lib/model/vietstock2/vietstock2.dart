import 'package:intl/intl.dart';

class KhoiNgoaiGD {
  String? tradingDate;
  String? stockCode;
  String? financeUrl;
  String? stockName;
  int? buyVol;
  double? buyVal;
  int? sellVol;
  double? sellVal;
  int? klBuyTotal;
  int? klSellTotal;
  double? gtBuyTotal;
  double? gtSellTotal;
  int? klRongTotal;
  double? gtRongTotal;
  int? buyPutVol;
  double? buyPutVal;
  int? sellPutVol;
  double? sellPutVal;
  dynamic stockNameEn;
  int? row;
  num? timestamp;

  KhoiNgoaiGD({
    this.tradingDate,
    this.stockCode,
    this.financeUrl,
    this.stockName,
    this.buyVol,
    this.buyVal,
    this.sellVol,
    this.sellVal,
    this.klBuyTotal,
    this.klSellTotal,
    this.gtBuyTotal,
    this.gtSellTotal,
    this.klRongTotal,
    this.gtRongTotal,
    this.buyPutVol,
    this.buyPutVal,
    this.sellPutVol,
    this.sellPutVal,
    this.stockNameEn,
    this.row,
    this.timestamp,
  });

  factory KhoiNgoaiGD.fromJson(Map<String, dynamic> json) => KhoiNgoaiGD(
        tradingDate: convertTime((json['TradingDate'] as String?)),
        timestamp: extractTimestamp((json['TradingDate'] as String?)),
        stockCode: json['StockCode'] as String?,
        financeUrl: json['FinanceURL'] as String?,
        stockName: json['StockName'] as String?,
        buyVol: json['BuyVol'] as int?,
        buyVal: (json['BuyVal'] as num?)?.toDouble(),
        sellVol: json['SellVol'] as int?,
        sellVal: json['SellVal'] as double?,
        klBuyTotal: json['KLBuy_Total'] as int?,
        klSellTotal: json['KLSell_Total'] as int?,
        gtBuyTotal: (json['GTBuy_Total'] as num?)?.toDouble(),
        gtSellTotal: json['GTSell_Total'] as double?,
        klRongTotal: json['KLRong_Total'] as int?,
        gtRongTotal: (json['GTRong_Total'] as num?)?.toDouble(),
        buyPutVol: json['BuyPutVol'] as int?,
        buyPutVal: json['BuyPutVal'] as double?,
        sellPutVol: json['SellPutVol'] as int?,
        sellPutVal: json['SellPutVal'] as double?,
        stockNameEn: json['StockNameEn'] as dynamic,
        row: json['Row'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'TradingDate': tradingDate,
        'StockCode': stockCode,
        'FinanceURL': financeUrl,
        'StockName': stockName,
        'BuyVol': buyVol,
        'BuyVal': buyVal,
        'SellVol': sellVol,
        'SellVal': sellVal,
        'KLBuy_Total': klBuyTotal,
        'KLSell_Total': klSellTotal,
        'GTBuy_Total': gtBuyTotal,
        'GTSell_Total': gtSellTotal,
        'KLRong_Total': klRongTotal,
        'GTRong_Total': gtRongTotal,
        'BuyPutVol': buyPutVol,
        'BuyPutVal': buyPutVal,
        'SellPutVol': sellPutVol,
        'SellPutVal': sellPutVal,
        'StockNameEn': stockNameEn,
        'Row': row,
        'timestamp': timestamp,
      };
}

String? convertTime(String? dateString) {
  if (dateString == null) {
    return null;
  }
  num timestamp = extractTimestamp(dateString) ?? 0;
  return DateFormat('dd/MM/yyyy')
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt()));
}

num? extractTimestamp(String? dateString) {
  if (dateString == null) {
    return null;
  }
  // Extract the numeric part between "( )" in the string
  String numericPart = dateString.substring(6, dateString.length - 2);
  // Convert the numeric part to a num type
  num timestamp = num.parse(numericPart);
  return timestamp;
}
