//
//  SP_Charts_DemoStockVC.swift
//  SuperApp
//
//  Created by 刘才德 on 2017/6/2.
//  Copyright © 2017年 Friends-Home. All rights reserved.
//

import UIKit
import Charts
class SP_Charts_DemoStockVC: UIViewController {
    //MARK:--- 初始化及生命周期 -----------------------------
    override class func initSPVC() -> SP_Charts_DemoStockVC {
        return UIStoryboard(name: "SP_Charts_Demo", bundle: nil).instantiateViewController(withIdentifier: "SP_Charts_DemoStockVC") as! SP_Charts_DemoStockVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        makeDelegate()
        
    }

    @IBOutlet weak var tableView: UITableView!
    func makeDelegate(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    func makeChartView(_ supView:UIView){
        guard supView.subviews.count == 0 else {
            return
        }
        
        makeCandleStickChartView(supView)
        makeLineChartView(supView)
    }
    
    //MARK:--- lineChartView -----------------------------
    lazy var lineChartView:LineChartView = {
        let view = LineChartView()
        //view.delegate = self
        view.chartDescription?.enabled = false
        view.dragEnabled = true
        view.setScaleEnabled(true)
        view.drawGridBackgroundEnabled = false
        view.pinchZoomEnabled = true
        view.backgroundColor = UIColor.clear
        return view
    }()
    func makeLineChartView(_ supView:UIView){
        supView.addSubview(lineChartView)
        lineChartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        /*
        let l = lineChartView.legend;
        l.form = .line;
        l.font = UIFont.systemFont(ofSize: 11)
        l.textColor = UIColor.white;
        l.horizontalAlignment = .left;
        l.verticalAlignment = .bottom;
        l.orientation = .horizontal;
        l.drawInside = false;
        */
        
        let xAxis = lineChartView.xAxis;
        xAxis.labelFont = UIFont.systemFont(ofSize: 11)
        xAxis.labelTextColor = UIColor.white;
        xAxis.drawGridLinesEnabled = false;
        xAxis.drawAxisLineEnabled = false;
        
        let leftAxis = lineChartView.leftAxis;
        leftAxis.labelTextColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        
        leftAxis.axisMaximum = 200.0;
        leftAxis.axisMinimum = 0.0;
        leftAxis.drawGridLinesEnabled = true;
        leftAxis.drawZeroLineEnabled = false;
        leftAxis.granularityEnabled = true;
        
        let rightAxis = lineChartView.rightAxis;
        rightAxis.labelTextColor = UIColor.red;
        rightAxis.axisMaximum = 900.0;
        rightAxis.axisMinimum = -200.0;
        rightAxis.drawGridLinesEnabled = false;
        rightAxis.granularityEnabled = false;
        
        lineChartView.animate(xAxisDuration: 0)
        
        setLineChartDataCount(40, range: 100.0)
    }
    //MARK:--- CandleStickChartView -----------------------------
    lazy var candleStickChartView:CandleStickChartView = {
        let view = CandleStickChartView()
        //view.delegate = self
        view.chartDescription?.enabled = false
        view.maxVisibleCount = 60
        view.drawGridBackgroundEnabled = false
        view.pinchZoomEnabled = true
        view.backgroundColor = UIColor.clear
        return view
    }()
    func makeCandleStickChartView(_ supView:UIView){
        supView.addSubview(candleStickChartView)
        candleStickChartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        let xAxis = candleStickChartView.xAxis;
//        xAxis.labelPosition = XAxisLabelPositionBottom;
//        xAxis.drawGridLinesEnabled = NO;
        
        let leftAxis = candleStickChartView.leftAxis;
        leftAxis.labelCount = 7;
        leftAxis.drawGridLinesEnabled = false;
        leftAxis.drawAxisLineEnabled = false;
        
        let rightAxis = candleStickChartView.rightAxis;
        rightAxis.enabled = false;
        
        candleStickChartView.legend.enabled = false;
        
        
        setcandleStickChartDataCount(40, range: 100.0)
    }
    //MARK:--- 模拟数据 -----------------------------
    func setLineChartDataCount(_ count:Int, range:Double) {
        
        var yVals1 = [ChartDataEntry]();
        var yVals2 = [ChartDataEntry]();
        var yVals3 = [ChartDataEntry]();
        
        for i in 0 ..< count
        {
            let mult = range / 2.0
            let val  =  Double((arc4random_uniform(UInt32(mult))) + 50);
            yVals1.append(ChartDataEntry(x: Double(i), y: val))
            
        }
        
        for i in 0 ..< count
        {
            let mult = range;
            let val = Double((arc4random_uniform(UInt32(mult))) + 250);
            yVals2.append(ChartDataEntry(x: Double(i), y: val))
            
        }
        
        for i in 0 ..< count
        {
            let mult = range;
            let val = Double((arc4random_uniform(UInt32(mult))) + 500);
            yVals3.append(ChartDataEntry(x: Double(i), y: val))
        }
        let set1:LineChartDataSet?
        let set2:LineChartDataSet?
        let set3:LineChartDataSet?
        
        /*
        if lineChartView.data?.dataSetCount > 0
        {
            set1 = lineChartView.data!.dataSets[0] as? LineChartDataSet;
            set2 = lineChartView.data!.dataSets[1] as? LineChartDataSet;
            set3 = lineChartView.data!.dataSets[2] as? LineChartDataSet
            set1?.values = yVals1;
            set2?.values = yVals2;
            set3?.values = yVals3;
            lineChartView.data?.notifyDataChanged()
            lineChartView.notifyDataSetChanged()
        }
        else
        {*/
            set1 = LineChartDataSet(values: yVals1, label: "DataSet 1")
            set1?.axisDependency = .left;
            set1?.setColor(UIColor.white)
            set1?.setCircleColor(UIColor.white)
            set1?.lineWidth = 1.0;
            set1?.circleRadius = 0.0;
            set1?.fillAlpha = 1.0;
            set1?.fillColor = UIColor.white
            set1?.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
            set1?.drawCircleHoleEnabled = false;
            
            set2 = LineChartDataSet(values: yVals2, label: "DataSet 2")
            set2?.axisDependency = .right;
            set2?.setColor(UIColor.red)
            set2?.setCircleColor(UIColor.white)
            set2?.lineWidth = 1.0;
            set2?.circleRadius = 0.0;
            set2?.fillAlpha = 1.0;
            set2?.fillColor = UIColor.red
            set2?.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
            set2?.drawCircleHoleEnabled = false;
        
            
            set3 = LineChartDataSet(values: yVals3, label: "DataSet 3")
            set3?.axisDependency = .right;
            set3?.setColor(UIColor.blue)
            set3?.setCircleColor(UIColor.white)
            set3?.lineWidth = 1.0;
            set3?.circleRadius = 0.0;
            set3?.fillAlpha = 1.0;
            set3?.fillColor = UIColor.blue
            set3?.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
            set3?.drawCircleHoleEnabled = false;
            
            
            
            var dataSets = [LineChartDataSet]();
            dataSets.append(set1!)
            dataSets.append(set2!)
            dataSets.append(set3!)
            
            
            let data = LineChartData(dataSets: dataSets)
        
            data.setValueTextColor(UIColor.white)
            data.setValueFont(UIFont.systemFont(ofSize: 9.0))
        

            
            lineChartView.data = data;
//        }
    }
    
    func setcandleStickChartDataCount(_ count:Int, range:Double) {
        
        var yVals1 = [CandleChartDataEntry]()
        
        for i in 0 ..< count
        {
            let mult = Double(range + 1);
            let val = Double((arc4random_uniform(40))) + mult;
            let high = Double((arc4random_uniform(9))) + 8.0;
            let low = Double((arc4random_uniform(9))) + 8.0;
            let open = Double((arc4random_uniform(6))) + 1.0;
            let close = Double((arc4random_uniform(6))) + 1.0;
            let even = i % 2 == 0;
            yVals1.append(CandleChartDataEntry(x: Double(i), shadowH: val + high, shadowL: val - low, open: even ? val + open : val - open, close: even ? val - close : val + close))
        }
        
        let set1 = CandleChartDataSet(values: yVals1, label: "Data Set")
        
        set1.axisDependency = .left;
        set1.setColor(UIColor(white: 80/255, alpha: 1.0))
        
        
        set1.drawIconsEnabled = false;
        
        set1.shadowColor = UIColor.darkGray;
        set1.shadowWidth = 0.7;
        set1.decreasingColor = UIColor.red;
        set1.decreasingFilled = true;
        set1.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1.0)
        
        set1.increasingFilled = false;
        set1.neutralColor = UIColor.blue;
        
        let data = CandleChartData(dataSet: set1)
        
        candleStickChartView.data = data;
    }
    
    
}

extension SP_Charts_DemoStockVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = SP_Charts_DemoStockCell_Charts.show(tableView, indexPath)
            makeChartView(cell.view_bg)
            return cell
        }else{
            let cell = SP_Charts_DemoStockCell_Charts2.show(tableView, indexPath)
            
            return cell
        }
        
    }
}

extension SP_Charts_DemoStockVC:ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
    }
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        
    }
}

class SP_Charts_DemoStockCell_Charts: UITableViewCell {
    class func show(_ tableView: UITableView, _ indexPath: IndexPath) -> SP_Charts_DemoStockCell_Charts {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SP_Charts_DemoStockCell_Charts", for: indexPath)
        return cell as! SP_Charts_DemoStockCell_Charts
    }
    
    @IBOutlet weak var view_bg: UIView!
    
}


class SP_Charts_DemoStockCell_Charts2: UITableViewCell {
    class func show(_ tableView: UITableView, _ indexPath: IndexPath) -> SP_Charts_DemoStockCell_Charts2 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SP_Charts_DemoStockCell_Charts2", for: indexPath)
        return cell as! SP_Charts_DemoStockCell_Charts2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.addSubview(_chartView)
        _chartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        makeChartView(_chartView)
    }
    
    let ITEM_COUNT = 40
    
    
    lazy var _chartView:CombinedChartView = {
        let view = CombinedChartView()
        //view.delegate = self;
        
        view.legend.enabled = false
        view.chartDescription?.enabled = false;
        view.drawGridBackgroundEnabled = false;
        view.drawBarShadowEnabled = false;
        view.highlightFullBarEnabled = false;
        
        view.drawOrder = [DrawOrder.bar.rawValue,
                          DrawOrder.candle.rawValue,
                          DrawOrder.line.rawValue,
                          ]
        
        return view
    }()
    
    func makeChartView(_ chartView:CombinedChartView){
        
        let l = chartView.legend;
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center;
        l.verticalAlignment = .bottom;
        l.orientation = .horizontal;
        l.drawInside = false;
        
        
        let xAxis = chartView.xAxis;
        xAxis.labelPosition = .bothSided
        xAxis.axisMinimum = 0.0;
        xAxis.granularity = 1.0;
        //xAxis.valueFormatter = self;
        
        
        let leftAxis = chartView.leftAxis;
        leftAxis.drawGridLinesEnabled = false;
        leftAxis.axisMinimum = 0.0
        
        let rightAxis = chartView.rightAxis;
        rightAxis.drawGridLinesEnabled = false;
        rightAxis.axisMinimum = 0.0
        
        setChartData()
    }
    
    func setChartData(){
        
        chartData.lineData = getLineData()
        chartData.barData = getBarData()
        chartData.candleData = getCandleData()
        _chartView.xAxis.axisMaximum = chartData.xMax + 0.25;
        _chartView.data = chartData;
        
        
         /*
        data.barData = [self generateBarData];
        data.bubbleData = [self generateBubbleData];
        data.scatterData = [self generateScatterData];
        data.candleData = [self generateCandleData];
        
        _chartView.xAxis.axisMaximum = data.xMax + 0.25;
        
        _chartView.data = data;*/
    }
    lazy var chartData:CombinedChartData = {
        return CombinedChartData()
    }()
    
    
    //MARK:--- 折线图数据 -----------------------------
    func getLineData() -> LineChartData {
        
        let d = LineChartData()
        
        var entries = [ChartDataEntry]()
        
        for index in 0 ..< ITEM_COUNT
        {
            entries.append(ChartDataEntry(x: Double(index) + 0.5,
                                          y: Double((arc4random_uniform(15)) + 5)))
            
        }
        
        let set = LineChartDataSet()
        set.values = entries
        set.setColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.lineWidth = 1;
        set.setCircleColor(UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1))
        set.circleRadius = 0.0;
        set.circleHoleRadius = 0;
        set.fillColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        set.mode = .cubicBezier;
        set.drawValuesEnabled = true;
        set.valueFont = UIFont.systemFont(ofSize: 10)
        set.valueTextColor = UIColor(red: 240/255, green: 238/255, blue: 70/255, alpha: 1)
        
        set.axisDependency = .left;
        d.addDataSet(set)
        
        return d;
    }
    
    //MARK:--- 柱状图数据 -----------------------------
    func getBarData() -> BarChartData {
        var entries1 = [BarChartDataEntry]()
        var entries2 = [BarChartDataEntry]()
        
        for index in 0 ..< ITEM_COUNT
        {
            entries1.append(BarChartDataEntry(x: 0.0,
                                              y: Double((arc4random_uniform(25)) + 25)))
            entries2.append(BarChartDataEntry(x: 0.0,
                                              yValues: [Double((arc4random_uniform(13)) + 12),
                                                        Double((arc4random_uniform(13)) + 12)]))
            
        }
        
        let set1 = BarChartDataSet()
        set1.values = entries1
        set1.setColor(UIColor(red: 60/255, green: 220/255, blue: 78/255, alpha: 1.0))
        
        set1.valueTextColor = UIColor(red: 60/255, green: 220/255, blue: 78/255, alpha: 1.0)
        set1.valueFont = UIFont.systemFont(ofSize: 10)
        set1.axisDependency = .left
        
        
        let set2 = BarChartDataSet(values: entries2, label: "Bar 2")
        
        set2.stackLabels = ["Stack 1", "Stack 2"]
        set2.colors = [UIColor(red: 61/255, green: 165/255, blue: 255/255, alpha: 1.0),
                       UIColor(red: 23/255, green: 197/255, blue: 255/255, alpha: 1.0)]
        set2.valueTextColor = UIColor(red: 61/255, green: 165/255, blue: 255/255, alpha: 1.0)
        set2.valueFont = UIFont.systemFont(ofSize: 10)
        set2.axisDependency = .left;
 
        let groupSpace = 0.06;
        let barSpace = 0.02;
        let barWidth = 0.45;
       
        
        let d = BarChartData(dataSets: [set1,set2])
        d.barWidth = barWidth
        d.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)
        return d;
    }
    
    func getCandleData() -> CandleChartData {
        let d = CandleChartData()
        
        var yVals1 = [CandleChartDataEntry]()
        
        for i in 0 ..< ITEM_COUNT
        {
            let mult = Double(100 + 1);
            let val = Double((arc4random_uniform(40))) + mult;
            let high = Double((arc4random_uniform(9))) + 8.0;
            let low = Double((arc4random_uniform(9))) + 8.0;
            let open = Double((arc4random_uniform(6))) + 1.0;
            let close = Double((arc4random_uniform(6))) + 1.0;
            let even = i % 2 == 0;
            yVals1.append(CandleChartDataEntry(x: Double(i), shadowH: val + high, shadowL: val - low, open: even ? val + open : val - open, close: even ? val - close : val + close))
        }
        
        let set1 = CandleChartDataSet()
        set1.values = yVals1
        set1.axisDependency = .left;
        set1.setColor(UIColor(white: 80/255, alpha: 1.0))
        
        
        set1.drawIconsEnabled = false;
        
        set1.shadowColor = UIColor.darkGray;
        set1.shadowWidth = 0.7;
        set1.decreasingColor = UIColor.red;
        set1.decreasingFilled = true;
        set1.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1.0)
        
        set1.increasingFilled = false;
        set1.neutralColor = UIColor.blue;
        
        d.addDataSet(set1)
        return d;
    }
    
    
    
    func geteData() {
        for i in 0 ..< ITEM_COUNT
        {
            let mult = Double(100 + 1);
            let val = Double((arc4random_uniform(40))) + mult;
            let high = Double((arc4random_uniform(9))) + 8.0;
            let low = Double((arc4random_uniform(9))) + 8.0;
            let open = Double((arc4random_uniform(6))) + 1.0;
            let close = Double((arc4random_uniform(6))) + 1.0;
            let even = i % 2 == 0;
        }
    }
}







