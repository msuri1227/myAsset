//
//  ChartVC.swift
//  myJobCard
//
//  Created by Rover Software on 28/06/17.
//  Copyright © 2017 Ondevice Solutions. All rights reserved.
//

import UIKit
import ODSFoundation
import mJCLib

class ChartVC: UIViewController,ChartViewDelegate {
    
    @IBOutlet var xaxTitleLabel: UILabel!
    @IBOutlet var yaxTitleLabel: UILabel!
    @IBOutlet weak var chartViewWidthCon: NSLayoutConstraint!
    @IBOutlet var headerView: UIView!
    @IBOutlet var chartView: CombinedChartView!
    
    let appDeli = UIApplication.shared.delegate as! AppDelegate
    var technicianid = String()
    var TechnicianName = String()
    var receivedArray = [WoHeaderModel]()
    var enroutedArray = [WoHeaderModel]()
    var arrivedArray = [WoHeaderModel]()
    var acceptedArray = [WoHeaderModel]()
    var startedArray = [WoHeaderModel]()
    var holdArray = [WoHeaderModel]()
    var completedArray = [WoHeaderModel]()
    var veryhigharray = NSMutableArray()
    var higharray = NSMutableArray()
    var mediumarray = NSMutableArray()
    var lowarray = NSMutableArray()
    var xaxistitlearray = NSMutableArray()
    var isfrom = String()
    let chartgreen = NSUIColor(red:136.0/255.0,  green:185.0/255.0,  blue:0.0/255.0, alpha:1.0)
    var recordpointsArray = Array<MeasurementPointModel>()
    var chartType = String()
    var linechartType = String()
    var measuringPoint = String()
    var upperLimit = String()
    var lowerLimit = String()
    var linechartXpointsArray = NSMutableArray()
    var volutionDict = Array<CodeGroupModel>()
    weak var valueFormatter: IValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mJCLogger.log("Starting", Type: "info")
        valueFormatter = self
        yaxTitleLabel.numberOfLines = 0
        yaxTitleLabel.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        yaxTitleLabel.layer.anchorPoint = CGPoint(x: 0.0,y :1.0)
        if self.chartType == "bar"{
            if technicianid != ""
            {
                self.chartView.extraBottomOffset = 20
                self.headerView.isHidden = true
                if DeviceType == iPad{
                    yaxTitleLabel.frame = CGRect(x:yaxTitleLabel.frame.origin.y , y:yaxTitleLabel.frame.origin.x, width:yaxTitleLabel.frame.size.width,height:yaxTitleLabel.frame.size.height)
                }else{
                    yaxTitleLabel.frame = CGRect(x: 30.0, y: 0, width: 20.0, height: UIScreen.main.bounds.height - 140)
                }
                chartView.delegate = self
                receivedArray.removeAll()
                enroutedArray.removeAll()
                arrivedArray.removeAll()
                acceptedArray.removeAll()
                startedArray.removeAll()
                holdArray.removeAll()
                completedArray.removeAll()
                veryhigharray.removeAllObjects()
                higharray.removeAllObjects()
                mediumarray.removeAllObjects()
                lowarray.removeAllObjects()
                yaxTitleLabel.text = "Number_Of_Work_Orders".localized()
                DispatchQueue.main.async{
                    self.xaxTitleLabel.text = "Status".localized()
                    self.xaxTitleLabel.font = UIFont(name: "Helvetica", size: 16)
                }
                self.gettechnicianworkorders(techid: technicianid)
            }
        }
        if self.chartType == "line"{
            self.headerView.isHidden = false
            if DeviceType == iPad{
                yaxTitleLabel.frame = CGRect(x:yaxTitleLabel.frame.origin.y + 25 , y:yaxTitleLabel.frame.origin.x + 20, width:yaxTitleLabel.frame.size.width + 10,height:yaxTitleLabel.frame.size.height)
            }else{
                chartView.translatesAutoresizingMaskIntoConstraints = false
                yaxTitleLabel.frame = CGRect(x: 35.0, y: 0, width: 20.0,height: UIScreen.main.bounds.height - 140)
            }
            yaxTitleLabel.text = "Reading_History".localized()
            xaxTitleLabel.text = "Date".localized()
            getreadingvalues(mPoint: measuringPoint)
        }                   
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewWillAppear(_ animated: Bool) {
        mJCLogger.log("Starting", Type: "info")
        myAssetDataManager.uniqueInstance.methodStatusBarColorChange()
        mJCLogger.log("Ended", Type: "info")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mJCLogger.log("Starting", Type: "info")
        if DeviceType == iPhone{
            chartViewWidthCon.constant = UIScreen.main.bounds.width - 30
            chartView.xAxis.labelFont = UIFont.italicSystemFont(ofSize: 12)
            xaxTitleLabel.transform = .init(translationX: 0, y: -73)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //MARK:- Line chart methods
    func getreadingvalues(mPoint: String)
    {
        mJCLogger.log("Starting", Type: "info")
        if self.isfrom == "Sup"{
            MeasurementPointModel.getSupMeasuringPointDocumentHistory(measuringPoint: mPoint){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [MeasurementPointModel]{
                        if responseArr.count > 0{
                            mJCLogger.log("Response:\(responseArr.count)", Type: "Debug")
                            self.recordpointsArray = responseArr
                            self.createlinechartData()
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }else{
            MeasurementPointModel.getMeasuringPointDocumentHistory(measuringPoint: mPoint){(response, error)  in
                if error == nil{
                    if let responseArr = response["data"] as? [MeasurementPointModel]{
                        if responseArr.count > 0{
                            self.recordpointsArray = responseArr
                            self.createlinechartData()
                        }else{
                            mJCLogger.log("Data not found", Type: "Debug")
                        }
                    }else{
                        mJCLogger.log("Data not found", Type: "Debug")
                    }
                }else{
                    mJCLogger.log("Reason : \(String(describing: error?.localizedDescription))", Type: "Error")
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createlinechartData(){
        
        mJCLogger.log("Starting", Type: "info")
        if linechartType == "ValCodeSuff"{
            xaxistitlearray.add("")
            linechartXpointsArray.add(0.0)
            for i in 0..<self.recordpointsArray.count {
                let pointdetail = self.recordpointsArray[i]
                if pointdetail.date != nil{
                    let dateStr = pointdetail.date!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                    let arr = dateStr.components(separatedBy: " ")
                    let time = ODSDateHelper.getTimeFromSODataDuration(dataDuration: pointdetail.MeasurementTime) as String
                    if arr.count > 0{
                    let pointdate  =  arr[0] + "\n" + time
                    xaxistitlearray.add(pointdate)
                    linechartXpointsArray.add(2.0)
                    }
                }
            }
            xaxistitlearray.add("")
            linechartXpointsArray.add(0.0)
        }else{
            for i in 0..<self.recordpointsArray.count {
                let pointdetail = self.recordpointsArray[i]
                if pointdetail.date != nil{
                    let dateStr = pointdetail.date!.toString(format: .custom(localDateFormate), timeZone: .utc, locale: .current)
                    let arr = dateStr.components(separatedBy: " ")
                    let time = ODSDateHelper.getTimeFromSODataDuration(dataDuration: pointdetail.MeasurementTime) as String
                    if arr.count > 0{
                    let pointdate  =  arr[0] + "\n" + time
                    xaxistitlearray.add(pointdate)
                    linechartXpointsArray.add(pointdetail.MeasReading)
                    }
                }
            }
        }
        self.createlinechart()
        mJCLogger.log("Ended", Type: "info")
    }
    func createlinechart()
    {
        mJCLogger.log("Starting", Type: "info")
        chartView.leftAxis.spaceTop = 1.0
        chartView.leftAxis.axisLineWidth = 2.0
        chartView.leftAxis.axisLineColor = UIColor.gray
        if DeviceType == iPad {
            chartView.extraLeftOffset = 50
            chartView.extraBottomOffset = 75
            chartView.extraTopOffset = 50
            chartView.extraRightOffset = 50
        }else{
            chartView.extraLeftOffset = 0
            chartView.extraBottomOffset = 75
            chartView.extraTopOffset = 50
            chartView.extraRightOffset = 50
        }
        chartView.rightAxis.drawAxisLineEnabled = true;
        chartView.rightAxis.enabled = false;
        chartView.rightAxis.axisLineColor = UIColor.lightGray
        chartView.rightAxis.axisLineWidth = 2.0
        chartView.xAxis.drawGridLinesEnabled = true;
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelRotationAngle = -60.0
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:self.xaxistitlearray as! [String])
        if DeviceType == iPad{
            chartView.xAxis.labelFont = UIFont.boldSystemFont(ofSize: 12)
        }else{
            chartView.xAxis.labelFont = UIFont.boldSystemFont(ofSize: 7)
        }
        chartView.drawGridBackgroundEnabled = false;
        chartView.dragEnabled = false;
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false;
        chartView.legend.enabled = false
        chartView.noDataText = somethingwrongalert
        chartView.chartDescription?.enabled = false
        let datasets = NSMutableArray()
        let values = NSMutableArray()
        var chartDataSet = LineChartDataSet()
        for i in 0..<self.linechartXpointsArray.count {
            let dataEntry = ChartDataEntry(x: Double(i) , y: self.linechartXpointsArray[i] as! Double)
            values.add(dataEntry)
        }
        DispatchQueue.main.async {
            chartDataSet = LineChartDataSet(entries: values as? [ChartDataEntry], label: "Measurment point")
            if self.linechartType != "ValCodeSuff"{
                if  self.upperLimit != "undefined"{
                    if let upper = Double(self.upperLimit) {
                        let limi = ChartLimitLine(limit: upper, label: "Upper_Limit".localized() + "(\(upper))")
                        limi.lineColor = UIColor.red
                        limi.lineWidth = 3.0
                        self.chartView.leftAxis.addLimitLine(limi)
                        limi.valueFont = UIFont.boldSystemFont(ofSize: 12)
                        limi.valueTextColor = UIColor.red
                        self.chartView.leftAxis.axisMaximum = upper + 100.0
                    }
                }
                if self.lowerLimit != "undefined"{
                    if let lower = Double(self.lowerLimit)
                    {
                        let limi1 = ChartLimitLine(limit: lower, label: "Lower_Limit".localized() + "(\(lower))")
                        limi1.lineColor = UIColor.red
                        limi1.lineWidth = 3.0
                        limi1.valueFont = UIFont.boldSystemFont(ofSize: 12)
                        limi1.valueTextColor = UIColor.red
                        self.chartView.leftAxis.addLimitLine(limi1)
                    }else{
                        print("Not a valid number: ")
                    }
                }
                if self.xaxistitlearray.count == 1{
                    self.chartView.xAxis.setLabelCount(3, force: true)
                }else{
                    self.chartView.xAxis.setLabelCount(self.xaxistitlearray.count, force: true)
                }
                self.chartView.leftAxis.axisMinimum = 0.0
                chartDataSet.setColor(self.chartgreen)
            }else{
                self.chartView.leftAxis.enabled = false;
                self.chartView.leftAxis.axisMinimum = 1.0
                self.chartView.xAxis.setLabelCount(7, force: true)
                chartDataSet.setColors(NSUIColor.white,self.chartgreen,self.chartgreen,self.chartgreen,self.chartgreen,NSUIColor.white)
            }
            chartDataSet.lineWidth = 3
            chartDataSet.circleRadius = 4.0
            chartDataSet.circleHoleColor = self.chartgreen
            chartDataSet.circleColors = [self.chartgreen]
            if DeviceType == iPad{
                chartDataSet.valueFont = UIFont.boldSystemFont(ofSize: 13.0)
            }else{
                chartDataSet.valueFont = UIFont.boldSystemFont(ofSize: 8.0)
            }
            chartDataSet.valueTextColor =  UIColor.blue
            datasets.add(chartDataSet)
            let chartData = LineChartData(dataSets: datasets as? [IChartDataSet])
            let data1 = CombinedChartData()
            data1.lineData = chartData
            self.chartView.data = data1
            if nil != self.valueFormatter {
                self.chartView.data?.setValueFormatter(self.valueFormatter!)
            }
            mJCLogger.log("createlinechart End".localized(), Type: "")
        }
        if DeviceType == iPad{
            chartView.leftAxis.labelFont = UIFont.boldSystemFont(ofSize: 13)
        }else{
            chartView.leftAxis.labelFont = UIFont.boldSystemFont(ofSize: 7)
        }
        mJCLogger.log("Ended", Type: "info")
    }
    //Mark:- Bar chart Methods
    func gettechnicianworkorders(techid: String){
        mJCLogger.log("Starting", Type: "info")
        WoHeaderModel.getSuperVisorWorkorderList(technicianId: techid){(response, error)  in
            if error == nil{
                if let responseArr = response["data"] as? [WoHeaderModel]{
                    if responseArr.count > 0 {
                        self.enroutedArray = responseArr.filter{$0.MobileObjStatus == "ENRT"}
                        let arr = ["CRTD","MOBI","ASGD"]
                        self.receivedArray = responseArr.filter({arr.contains($0.MobileObjStatus)})
                        self.arrivedArray  = responseArr.filter{$0.MobileObjStatus == "ARRI"}
                        self.acceptedArray  = responseArr.filter{$0.MobileObjStatus == "ACCP"}
                        self.startedArray  = responseArr.filter{$0.MobileObjStatus == "STRT"}
                        self.holdArray  = responseArr.filter{$0.MobileObjStatus == "HOLD"}
                        self.completedArray  = responseArr.filter{$0.MobileObjStatus == "COMP"}
                        self.createBarChartData()
                    }
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    func createBarChartData ()  {

        mJCLogger.log("Starting", Type: "info")

        if self.receivedArray.count > 0{

            xaxistitlearray.add("MOBI")
            var namePredicate = NSPredicate(format: "Priority like %@","1");
            var array = NSMutableArray(array:self.receivedArray.filter { namePredicate.evaluate(with: $0) })
            self.veryhigharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","2");
            array = NSMutableArray(array:self.receivedArray.filter { namePredicate.evaluate(with: $0) } )
            self.higharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","3");
            array = NSMutableArray(array:self.receivedArray.filter { namePredicate.evaluate(with: $0) })
            self.mediumarray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","4");
            array = NSMutableArray(array:self.receivedArray.filter { namePredicate.evaluate(with: $0) })
            self.lowarray.add(Double(array.count))
        }
        if self.enroutedArray.count > 0{
            xaxistitlearray.add("ENRT")
            var namePredicate = NSPredicate(format: "Priority like %@","1");
            var array = NSMutableArray(array:self.enroutedArray.filter { namePredicate.evaluate(with: $0) })
            self.veryhigharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","2");
            array = NSMutableArray(array: self.enroutedArray.filter { namePredicate.evaluate(with: $0) })
            self.higharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","3");
            array = NSMutableArray(array:self.enroutedArray.filter { namePredicate.evaluate(with: $0) })
            self.mediumarray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","4");
            array = NSMutableArray(array:self.enroutedArray.filter { namePredicate.evaluate(with: $0) })
            self.lowarray.add(Double(array.count))
        }
        if self.arrivedArray.count > 0{

            xaxistitlearray.add("ARRI")
            var namePredicate = NSPredicate(format: "Priority like %@","1");
            var array = NSMutableArray(array:self.arrivedArray.filter { namePredicate.evaluate(with: $0) })
            self.veryhigharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","2");
            array = NSMutableArray(array:self.arrivedArray.filter { namePredicate.evaluate(with: $0) })
            self.higharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","3");
            array = NSMutableArray(array:self.arrivedArray.filter { namePredicate.evaluate(with: $0) })
            self.mediumarray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","4");
            array = NSMutableArray(array:self.arrivedArray.filter { namePredicate.evaluate(with: $0) } )
            self.lowarray.add(Double(array.count))
        }
        if self.acceptedArray.count > 0{
            xaxistitlearray.add("ACCP")
            var namePredicate = NSPredicate(format: "Priority like %@","1");
            var array = NSMutableArray(array:self.acceptedArray.filter { namePredicate.evaluate(with: $0) })
            self.veryhigharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","2");
            array = NSMutableArray(array:self.acceptedArray.filter { namePredicate.evaluate(with: $0) } )
            self.higharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","3");
            array = NSMutableArray(array:self.acceptedArray.filter { namePredicate.evaluate(with: $0) } )
            self.mediumarray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","4");
            array = NSMutableArray(array:self.acceptedArray.filter { namePredicate.evaluate(with: $0) })
            self.lowarray.add(Double(array.count))
        }
        if self.startedArray.count > 0{

            xaxistitlearray.add("STRT")
            var namePredicate = NSPredicate(format: "Priority like %@","1");
            var array = NSMutableArray(array: self.startedArray.filter { namePredicate.evaluate(with: $0) } )
            self.veryhigharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","2");
            array = NSMutableArray(array: self.startedArray.filter { namePredicate.evaluate(with: $0) } )
            self.higharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","3");
            array = NSMutableArray(array: self.startedArray.filter { namePredicate.evaluate(with: $0) } )
            self.mediumarray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","4");
            array = NSMutableArray(array: self.startedArray.filter { namePredicate.evaluate(with: $0) } )
            self.lowarray.add(Double(array.count))

        }
        if self.completedArray.count > 0{

            xaxistitlearray.add("COMP")
            var namePredicate = NSPredicate(format: "Priority like %@","1");
            var array = NSMutableArray(array: self.completedArray.filter { namePredicate.evaluate(with: $0) })
            self.veryhigharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","2");
            array = NSMutableArray(array: self.completedArray.filter { namePredicate.evaluate(with: $0) })
            self.higharray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","3");
            array = NSMutableArray(array: self.completedArray.filter { namePredicate.evaluate(with: $0) } )
            self.mediumarray.add(Double(array.count))
            namePredicate = NSPredicate(format: "Priority like %@","4");
            array = NSMutableArray(array: self.completedArray.filter { namePredicate.evaluate(with: $0) })
            self.lowarray.add(Double(array.count))

        }
        createBarchart()
        mJCLogger.log("Ended", Type: "info")
    }
    func createBarchart(){
        
        mJCLogger.log("Starting", Type: "info")
        chartView.noDataText = somethingwrongalert
        chartView.chartDescription?.text = ""
        let legend = chartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .left
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.drawInside = false
        legend.font =  UIFont.boldSystemFont(ofSize: 12)
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        let xaxis = chartView.xAxis
        xaxis.labelPosition = .bottom
        xaxis.labelTextColor = UIColor.black
        xaxis.drawLabelsEnabled = true
        xaxis.granularity = 1
        xaxis.drawGridLinesEnabled = true
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values:self.xaxistitlearray as! [String])
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        let yaxis = chartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        chartView.rightAxis.enabled = false
        yaxis.centerAxisLabelsEnabled = true
        yaxis.valueFormatter = IndexAxisValueFormatter(values:self.xaxistitlearray as! [String])
        chartView.noDataText = somethingwrongalert
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        var dataEntries2: [BarChartDataEntry] = []
        var dataEntries3: [BarChartDataEntry] = []
        mJCLogger.log("Response:\(self.xaxistitlearray.count)", Type: "Debug")
        for i in 0..<self.xaxistitlearray.count {

            let dataEntry = BarChartDataEntry(x: Double(i) , y: self.veryhigharray[i] as! Double)
            dataEntries.append(dataEntry)
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: self.higharray[i] as! Double)
            dataEntries1.append(dataEntry1)
            let dataEntry2 = BarChartDataEntry(x: Double(i) , y: self.mediumarray[i] as! Double)
            dataEntries2.append(dataEntry2)
            let dataEntry3 = BarChartDataEntry(x: Double(i) , y: self.lowarray[i] as! Double)
            dataEntries3.append(dataEntry3)
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Very High")
            chartDataSet.setColor(UIColor(red:255.0/255.0,  green:0.0/255.0,  blue:0.0/255.0, alpha:1.0))
            chartDataSet.valueTextColor = UIColor(red:255.0/255.0,  green:0.0/255.0,  blue:0.0/255.0, alpha:1.0)
            chartDataSet.valueFont = UIFont.boldSystemFont(ofSize: 15)
            let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "High")
            chartDataSet1.setColor(UIColor(red:255.0/255.0,  green:188.0/255.0,  blue:22.0/255.0, alpha:1.0))
            chartDataSet1.valueTextColor = UIColor(red:255.0/255.0,  green:188.0/255.0,  blue:22.0/255.0, alpha:1.0)
            chartDataSet1.valueFont = UIFont.boldSystemFont(ofSize: 15)
            let chartDataSet2 = BarChartDataSet(entries: dataEntries2, label: "Medium")
            chartDataSet2.setColor(UIColor(red:136.0/255.0,  green:185.0/255.0,  blue:0.0/255.0, alpha:1.0))
            chartDataSet2.valueTextColor = UIColor(red:136.0/255.0,  green:185.0/255.0,  blue:0.0/255.0, alpha:1.0)
            chartDataSet2.valueFont = UIFont.boldSystemFont(ofSize: 15)
            let chartDataSet3 = BarChartDataSet(entries: dataEntries3, label: "Low")
            chartDataSet3.setColor(UIColor(red:9.0/255.0,  green:157.0/255.0,  blue:207.0/255.0, alpha:1.0))
            chartDataSet3.valueTextColor = UIColor(red:9.0/255.0,  green:157.0/255.0,  blue:207.0/255.0, alpha:1.0)
            chartDataSet3.valueFont = UIFont.boldSystemFont(ofSize: 15)
            let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1,chartDataSet2,chartDataSet3]
            let chartData = BarChartData(dataSets: dataSets)
            let groupSpace = 0.08
            let barSpace = 0.03
            let barWidth = 0.2
            let groupCount = self.xaxistitlearray.count
            let start = 0
            DispatchQueue.main.async {
                chartData.barWidth = barWidth;
                self.chartView.xAxis.axisMinimum = Double(start)
                let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
                self.chartView.xAxis.axisMaximum = Double(start) + gg * Double(groupCount)
                chartData.groupBars(fromX: Double(start), groupSpace: groupSpace, barSpace: barSpace)
                self.chartView.notifyDataSetChanged()
                let data1 = CombinedChartData()
                data1.barData = chartData
                self.chartView.data = data1
                if nil != self.valueFormatter {
                    self.chartView.data?.setValueFormatter(self.valueFormatter!)
                }
            }
        }
        mJCLogger.log("Ended", Type: "info")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonAction(_ sender: Any) {
        mJCLogger.log("Starting", Type: "info")
        self.dismiss(animated: false, completion: nil)
        mJCLogger.log("Ended", Type: "info")
    }
    //MART:- ChartviewDelegate
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight){
        mJCLogger.log("Starting", Type: "info")
        let selectedTeamMemberArray = NSMutableArray()
        selectedTeamMemberArray.add(TechnicianName)
        let selectedPriorityArray = NSMutableArray()
        let xvalue = String(entry.x)
        var Priority = String()
        if xvalue.contains(".155"){
            Priority = "1"
        }else if xvalue.contains(".385"){
            Priority = "2"
        }else if xvalue.contains(".615"){
            Priority = "3"
        }else if xvalue.contains("845"){
            Priority = "4"
        }
        selectedPriorityArray.add(Priority)
        let selectedStatusArray = NSMutableArray()
        let xvalues = xvalue.components(separatedBy: ".")
        let index = Int(xvalues[0])
        let status = xaxistitlearray[index!]
        if status as! String == "MOBI"{
            selectedStatusArray.add("MOBI")
            selectedStatusArray.add("CRTD")
            selectedStatusArray.add("ASGD")
        }else{
            selectedStatusArray.add(status as! String)
        }
        let dict = NSMutableDictionary()
        dict.setValue(selectedPriorityArray, forKey: "priority")
        dict.setValue(selectedStatusArray, forKey: "status")
        dict.setValue(selectedTeamMemberArray, forKey: "teamMember")
        UserDefaults.standard.set(dict, forKey: "ListFilter")
        if DeviceType == iPad{
            menuDataModel.uniqueInstance.presentSupervisorSplitScreen()
        }else{
            selectedworkOrderNumber = ""
            selectedNotificationNumber = ""
            currentMasterView = "Supervisor"
            let mainViewController = ScreenManager.getSupervisorMasterListScreen()
            myAssetDataManager.uniqueInstance.leftViewController.slideMenuType = "Main"
            myAssetDataManager.uniqueInstance.leftViewController.mainViewController = myAssetDataManager.uniqueInstance.navigationController
            myAssetDataManager.uniqueInstance.slideMenuController = ExSlideMenuController(mainViewController: myAssetDataManager.uniqueInstance.navigationController!, leftMenuViewController: myAssetDataManager.uniqueInstance.leftViewController)
            myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate = mainViewController as UIViewController as? SlideMenuControllerSelectDelegate
            myAssetDataManager.uniqueInstance.slideMenuControllerSelectionDelegateStack.append(myAssetDataManager.uniqueInstance.slideMenuController!.Selectiondelegate!)
            self.appDeli.window?.rootViewController = myAssetDataManager.uniqueInstance.slideMenuController
            self.appDeli.window?.makeKeyAndVisible()
            myAssetDataManager.uniqueInstance.navigationController?.pushViewController(mainViewController, animated: true)
        }
        mJCLogger.log("Ended", Type: "info")
    }
}
extension ChartVC: IValueFormatter {
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        mJCLogger.log("Starting", Type: "info")
        if self.chartType == "bar"{
            var value1 = String(format:"%.1f", value)
            value1 = value1.replacingOccurrences(of: ".0", with: "")
            value1 = value1.replacingOccurrences(of: ".00", with: "")
            mJCLogger.log("Ended", Type: "info")
            return value1
        }else if self.chartType == "line"{
            if linechartType == "ValCodeSuff"{
                let i = Int(entry.x)
                mJCLogger.log("Response:\(self.recordpointsArray.count)", Type: "Debug")
                if self.recordpointsArray.count > 0{
                    if let pointdetail = self.recordpointsArray[i-1] as? MeasurementPointModel {
                        var text = String()
                        for item in self.volutionDict{
                            if item.Code == pointdetail.ValuationCode{
                                if item.CodeText.contains(find: ","){
                                    let codetext = item.CodeText.replacingLastOccurrenceOfString(",", with: ", \n")
                                    text = "\(item.Code) - \(codetext)"
                                }else{
                                    text = "\(item.Code) - \(item.CodeText)"
                                }
                                return String(format:"%@", text)
                            }else{
                                mJCLogger.log("Data not found", Type: "Debug")
                            }
                        }
                    }
                }else{
                    mJCLogger.log("Data not found", Type: "Debug")
                }
            }else{
                mJCLogger.log("Ended", Type: "info")
                return String(format:"%.1f", value)
            }
        }
        mJCLogger.log("Ended", Type: "info")
        return String(format:"%.1f", "")
    }
}

//func newcreateBarchart(){
//
//    mJCLogger.log("Starting", Type: "info")
//    chartView.noDataText = somethingwrongalert
//    chartView.chartDescription?.text = ""
//    let legend = chartView.legend
//    legend.enabled = true
//    legend.horizontalAlignment = .left
//    legend.verticalAlignment = .bottom
//    legend.orientation = .horizontal
//    legend.drawInside = false
//    legend.font =  UIFont.boldSystemFont(ofSize: 12)
//    legend.yOffset = 10.0;
//    legend.xOffset = 10.0;
//    legend.yEntrySpace = 0.0;
//    let xaxis = chartView.xAxis
//    xaxis.labelPosition = .bottom
//    xaxis.labelTextColor = UIColor.black
//    xaxis.drawLabelsEnabled = true
//    xaxis.granularity = 1
//    xaxis.drawGridLinesEnabled = true
//    xaxis.centerAxisLabelsEnabled = true
//    xaxis.valueFormatter = IndexAxisValueFormatter(values:self.xaxistitlearray as! [String])
//    let leftAxisFormatter = NumberFormatter()
//    leftAxisFormatter.maximumFractionDigits = 1
//    let yaxis = chartView.leftAxis
//    yaxis.spaceTop = 0.35
//    yaxis.axisMinimum = 0
//    yaxis.drawGridLinesEnabled = false
//    chartView.rightAxis.enabled = false
//    yaxis.centerAxisLabelsEnabled = true
//    yaxis.valueFormatter = IndexAxisValueFormatter(values:self.xaxistitlearray as! [String])
//    chartView.noDataText = somethingwrongalert
//
//    var dataSets = [BarChartDataSet]()
//    for item in self.priorityArr{
//        var dataEntries: [BarChartDataEntry] = []
//        for i in 0..<self.xaxistitlearray.count {
//            let key = self.xaxistitlearray[i] as? String ?? ""
//            let priDict = self.dataDict[key] as? Dictionary<String,Any> ?? Dictionary<String,Any>()
//            let priCount = priDict[item] as? String ?? "0"
//            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(priCount)!)
//            dataEntries.append(dataEntry)
//        }
//        let priClsArr = globalPriorityArray.filter{$0.Priority == "\(item)"}
//
//        if priClsArr.count > 0{
//
//            let priCls = priClsArr[0]
//
//            let chartDataSet = BarChartDataSet(entries: dataEntries, label: priCls.PriorityText)
//            chartDataSet.valueFont = UIFont.boldSystemFont(ofSize: 15)
//
//            if priCls.Priority == "1"{
//                chartDataSet.setColor(UIColor.red)
//                chartDataSet.valueTextColor = UIColor.red
//            }else if priCls.Priority == "2"{
//                chartDataSet.setColor(UIColor(red:255.0/255.0,  green:188.0/255.0,  blue:22.0/255.0, alpha:1.0))
//                chartDataSet.valueTextColor = UIColor(red:255.0/255.0,  green:188.0/255.0,  blue:22.0/255.0, alpha:1.0)
//            }else if priCls.Priority == "3"{
//                chartDataSet.setColor(UIColor(red:136.0/255.0,  green:185.0/255.0,  blue:0.0/255.0, alpha:1.0))
//                chartDataSet.valueTextColor = UIColor(red:136.0/255.0,  green:185.0/255.0,  blue:0.0/255.0, alpha:1.0)
//            }else if priCls.Priority == "4"{
//                chartDataSet.setColor(UIColor(red:9.0/255.0,  green:157.0/255.0,  blue:207.0/255.0, alpha:1.0))
//                chartDataSet.valueTextColor = UIColor(red:9.0/255.0,  green:157.0/255.0,  blue:207.0/255.0, alpha:1.0)
//            }else if priCls.Priority == "5"{
//                chartDataSet.setColor(UIColor(red:9.0/255.0,  green:157.0/255.0,  blue:207.0/255.0, alpha:1.0))
//                chartDataSet.valueTextColor = UIColor(red:9.0/255.0,  green:157.0/255.0,  blue:207.0/255.0, alpha:1.0)
//            }
//            dataSets.append(chartDataSet)
//        }
//    }
//    let chartData = BarChartData(dataSets: dataSets)
//    let groupSpace = 0.08
//    let barSpace = 0.02
//    let barWidth = 0.2
//    let groupCount = self.xaxistitlearray.count + 1
//    let start = 0
//    DispatchQueue.main.async {
//        chartData.barWidth = barWidth;
//        self.chartView.xAxis.axisMinimum = Double(start)
//        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
//        self.chartView.xAxis.axisMaximum = Double(start) + gg * Double(groupCount)
//        chartData.groupBars(fromX: Double(start), groupSpace: groupSpace, barSpace: barSpace)
//        self.chartView.notifyDataSetChanged()
//        let data1 = CombinedChartData()
//        data1.barData = chartData
//        self.chartView.data = data1
//        if nil != self.valueFormatter {
//            self.chartView.data?.setValueFormatter(self.valueFormatter!)
//        }
//    }
//    mJCLogger.log("Ended", Type: "info")
//}
//func createBarChartData(list:[WoHeaderModel]){
//    for status in self.statusArr{
//        xaxistitlearray.add(status)
//        var dict = Dictionary<String,Any>()
//        for priority in self.priorityArr{
//            let arrCount = list.filter{$0.UserStatus == "\(status)" && $0.Priority == "\(priority)"}
//            dict["\(priority)"] = "\(arrCount.count)"
//        }
//        dataDict[status] = dict
//    }
//    createBarchart()
//}
//func gettechnicianworkorders(techid: String){
//    mJCLogger.log("Starting", Type: "info")
//    WoHeaderModel.getSuperVisorWorkorderList(technicianId: techid){(response, error)  in
//        if error == nil{
//            if let responseArr = response["data"] as? [WoHeaderModel]{
//                if responseArr.count > 0 {
//                    self.statusArr = responseArr.uniqueValues{$0.MobileObjStatus}
//                    self.priorityArr = responseArr.uniqueValues{$0.Priority}.sorted()
//                    self.createBarChartData(list:responseArr)
//                }
//            }
//        }
//    }
//    mJCLogger.log("Ended", Type: "info")
//}
