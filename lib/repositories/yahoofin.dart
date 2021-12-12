import 'package:yahoofin/src/models/stock_chart.dart';
import 'package:yahoofin/yahoofin.dart';

class NeededValues{
  NeededValues(this.stockHistory,this.stockChart){
  }
  StockHistory stockHistory;
  StockChart stockChart;
}

class YahooFinRepo {
  YahooFin? yfin;
  bool inited = false;

  YahooFinRepo(){
    yfin = YahooFin();
  }

  Future<NeededValues> initForTicker(String ticker, StockInterval interval, StockRange stockRange) async{
    StockHistory hist = yfin!.initStockHistory(ticker: ticker);
    StockChart chart = await yfin!.getChartQuotes(
        stockHistory: hist,
        interval: interval,
        period: stockRange);
    return NeededValues(hist,chart);
  }
}

