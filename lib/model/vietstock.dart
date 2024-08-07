import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_chart/logger_custom.dart';
import 'package:stock_chart/model/viet_stock_khoi_ngoai/viet_stock_khoi_ngoai.dart';
import 'package:stock_chart/model/vietstock2/vietstock2.dart';

class VietStock {
  static Future<void> getGiaoDichKhoiNgoai() async {
    var url = Uri.parse(
        'https://finance.vietstock.vn/data/KQGDThongKeTuDoanhStockPaging');

    var headers = {
      'Accept': '*/*',
      'Accept-Language': 'en-US,en;q=0.9',
      'Connection': 'keep-alive',
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'Cookie':
          'language=vi-VN; Theme=Light; AnonymousNotification=; ASP.NET_SessionId=rbpdsabfmpxjju2scwbitiry; __RequestVerificationToken=O0Uk2pTVoEg5DxVMundTu5uWXL2YA7LXiK7wTocEd_Pfcv92CmdVLItv6HUGtpawNfmKMV4haUN6wCs-QS4zncnxYTTbzUNbRHcYafvXnyc1; _cc_id=6e3f5838398c8f9fb73dec0c2a1c112b; panoramaId_expiry=1709982143410; panoramaId=76a8b16b238d6997600460e2280e16d539388798c4a091210f74569b90675a7b; panoramaIdType=panoIndiv; FCNEC=%5B%5B%22AKsRol8ex8VU6n2FMJbmkZhKIIf0euYfHpINRIZfd-UaFsv3hkfvtGyi0FWCHlCOHxyGx2qCz21FBEmlAVjc87Ubvd1EQU5nEwDWDAxHcCM_6yaR531BdenldbqguAeMWZNsiVXNp-3IOmDXI93uy7hkIGmzTss3xg%3D%3D%22%5D%5D; _gid=GA1.2.37490525.1709698581; vts_usr_lg=404EB984604E0111B17D9DB06EE1E688CCFEA5B593CA2D7BA8B6A66B05FAFDFED407034DF1EC46E03136767751E4C2BEB31B1A1FA69D3339CABED19E2668213ED844CDC570D8140E20859FFE4FEB49D98AAB3F19630E7B7960CC227BF7866093E86D64A525CB12B1A760FAF5E814CA52BFBCE14DF1C4542066A2D6C5D59CE430; vst_usr_lg_token=sTy33TCaB02/ALTx9HEHlw==; _ga=GA1.2.239100682.1708359232; _ga_EXMM0DKVEX=GS1.1.1709745188.14.1.1709746510.54.0.0',
      'Origin': 'https://finance.vietstock.vn',
      'Referer':
          'https://finance.vietstock.vn/ket-qua-giao-dich?tab=gd-td&exchange=1&code=12698',
      'Sec-Fetch-Dest': 'empty',
      'Sec-Fetch-Mode': 'cors',
      'Sec-Fetch-Site': 'same-origin',
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
      'X-Requested-With': 'XMLHttpRequest',
      'sec-ch-ua':
          '"Chromium";v="122", "Not(A:Brand";v="24", "Google Chrome";v="122"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"macOS"'
    };

    var data = {
      'page': '1',
      'pageSize': '1000',
      'catID': '1',
      'stockID': '12698',
      'fromDate': '2024-01-01',
      'toDate': '2024-03-07',
      '__RequestVerificationToken':
          '2xp7WOCGmeNjdu8_8Z2vK-Zleap7DAJpkGgwg5mEFqegD_HwY8hmejxXF5ENH4D-MlTDXiqfNcYnHlVm5npQ0hxQvx8Rt11ACt2J_kYYBqDLj0dxhvVIlM26HTE-Q0Ii0'
    };

    var response = await http.post(url, headers: headers, body: data);

    CustomLogger().debug('Response status: ${response.statusCode}');
    CustomLogger().debug('Response body: ${response.body}');

    String jsonString = response.body;

    var jsonData = jsonDecode(jsonString);
    CustomLogger().debug("jsonData: $jsonData");

    var data1 = jsonData[0];
    var vietStockKhoiNgoaiData = (VietStockKhoiNgoai.fromJson(data1[0]));
    CustomLogger().debug("vietStockKhoiNgoaiData: $vietStockKhoiNgoaiData");

    var giaoDichKhoiNgoai =
        jsonData[1].map((e) => KhoiNgoaiGD.fromJson(e)).toList();
  }
}
