//
//  MTItemPriceHistoryViewController.swift
//  
//
//  Created by Jonathon Toon on 6/19/16.
//
//

import UIKit
import ScrollableGraphView

enum DateRange: Int {
    case Week = 0
    case Month = 1
    case Lifetime = 2
}

extension NSDate {
    static func changeDaysBy(days : Int) -> NSDate {
        let currentDate = NSDate()
        let dateComponents = NSDateComponents()
        dateComponents.day = days
        return NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: currentDate, options: NSCalendarOptions(rawValue: 0))!
    }
}

class MTItemPriceHistoryViewController: MTModalViewController {
    
    var item: MTItem!
    
    var price: [Double] = []
    var lowestPrice: Double!
    var highestPrice: Double!
    
    var labels: [String] = []
    
    let dateSegmentedControl: UISegmentedControl = UISegmentedControl(items: ["Lifetime", "Month", "Week"])
    let graphView: ScrollableGraphView = ScrollableGraphView.newAutoLayoutView()
    
    init(item: MTItem) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
        print(self.item.priceHistory?.count)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Price History"

        view.backgroundColor = UIColor.backgroundColor()
        
        sortPricesByDateRange(.Week)
        
        view.addSubview(graphView)
//        graphView.backgroundColor = UIColor.appTintColor()
//        graphView.backgroundFillColor = UIColor.backgroundColor()
//        graphView.lineColor = UIColor.appTintColor().colorWithAlphaComponent(0.5)
//        graphView.barLineColor = UIColor.appTintColor()
//        graphView.dataPointFillColor = UIColor.appTintColor()
//        graphView.fillColor = UIColor.appTintColor().colorWithAlphaComponent(0.2)
//        graphView.shouldFill = true
//        graphView.dataPointLabelFont = UIFont.systemFontOfSize(10, weight: UIFontWeightRegular)
//        graphView.dataPointLabelColor = UIColor.whiteColor()
//        graphView.dataPointLabelTopMargin = 30
//        graphView.topMargin = 20
//        graphView.leftmostPointPadding = 30
//        graphView.bottomMargin = 20
//        graphView.shouldDrawDataPoint = true
//        graphView.dataPointSize = 4
//        graphView.referenceLineThickness = 1.0/UIScreen.mainScreen().scale
//        graphView.referenceLineColor = UIColor.whiteColor().colorWithAlphaComponent(0.12)
//        graphView.referenceLineLabelFont = UIFont.systemFontOfSize(10, weight: UIFontWeightRegular)
//        graphView.referenceLineLabelColor = UIColor.whiteColor()
//        graphView.shouldAnimateOnStartup = false
//        graphView.shouldAdaptRange = false
//        graphView.shouldAnimateOnAdapt = false
//        graphView.numberOfIntermediateReferenceLines = 5
//        graphView.referenceLineNumberOfDecimalPlaces = 2
//        graphView.referenceLineUnits = "USD"
//        graphView.shouldAddUnitsToIntermediateReferenceLineLabels = true
//        graphView.shouldAutomaticallyDetectRange = true
//        //graphView.dataPointSpacing = 54
//        //graphView.direction = .RightToLeft
//        graphView.showsHorizontalScrollIndicator = false

        graphView.backgroundFillColor = UIColor.backgroundColor()
        
        graphView.lineWidth = 1
        graphView.lineColor = UIColor.appTintColor()
        graphView.lineStyle = ScrollableGraphViewLineStyle.Smooth
        
        graphView.shouldFill = true
        graphView.fillType = ScrollableGraphViewFillType.Solid
        graphView.fillColor = UIColor.appTintColor().colorWithAlphaComponent(0.1)
        graphView.fillGradientType = ScrollableGraphViewGradientType.Linear
        
        graphView.dataPointSpacing = 97
        graphView.dataPointSize = 2
        graphView.dataPointFillColor = UIColor.whiteColor()
        graphView.leftmostPointPadding = 44
        graphView.rightmostPointPadding = 36
        
        graphView.referenceLineColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        graphView.referenceLineLabelColor = UIColor.whiteColor()
        graphView.dataPointLabelColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        graphView.numberOfIntermediateReferenceLines = 5
        graphView.referenceLineNumberOfDecimalPlaces = 2
        graphView.referenceLineUnits = "USD"
        graphView.shouldAddUnitsToIntermediateReferenceLineLabels = true
        graphView.shouldAutomaticallyDetectRange = true
        graphView.shouldAnimateOnAdapt = false
        graphView.shouldAnimateOnStartup = false
        graphView.shouldAdaptRange = true
        
        graphView.autoPinEdge(.Top, toEdge: .Top, ofView: view, withOffset: 50)
        graphView.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: -2)
        graphView.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: 2)
        graphView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view)
        
        view.addSubview(dateSegmentedControl)
        dateSegmentedControl.tintColor = UIColor.appTintColor()
        dateSegmentedControl.selectedSegmentIndex = 2
        dateSegmentedControl.addTarget(self, action: #selector(MTItemPriceHistoryViewController.segmentSelected(_:)), forControlEvents: .ValueChanged)
        dateSegmentedControl.autoPinEdge(.Top, toEdge: .Top, ofView: view, withOffset: 10)
        dateSegmentedControl.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: 15)
        dateSegmentedControl.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: -15)
        dateSegmentedControl.autoSetDimension(.Height, toSize: 30)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func segmentSelected(segmentControl: UISegmentedControl!) {
        switch segmentControl.selectedSegmentIndex {
            case 0:
                sortPricesByDateRange(.Lifetime)
            case 1:
                sortPricesByDateRange(.Month)
            case 2:
                sortPricesByDateRange(.Week)
            default:
                return
        }
    }
    
    func setPriceHistoryDateSource(offsetDate offsetDate: NSDate! = nil) {
        
        lowestPrice = nil
        highestPrice = nil
        price = []
        labels = []
        
        var prices: [Double] = []
        var dates: [NSDate] = []
        
        if let priceHistoryArray = item.priceHistory {
            for priceHistoryItem in priceHistoryArray {

                let priceValue = priceHistoryItem.price.currencyAmount.doubleValue
                let dateValue = priceHistoryItem.date
                
                if let offset = offsetDate {
                    if dateValue.compare(offset) == NSComparisonResult.OrderedDescending || dateValue.compare(offset) == NSComparisonResult.OrderedSame {
                        prices.append(priceValue)
                        dates.append(dateValue)
                    }
                }
            }
            
            addPriceValue(value: prices[0])
            addPriceValue(value: prices[Int(Double(prices.count)*0.16)])
            addPriceValue(value: prices[Int(Double(prices.count)*0.32)])
            addPriceValue(value: prices[Int(Double(prices.count)*0.48)])
            addPriceValue(value: prices[Int(Double(prices.count)*0.64)])
            addPriceValue(value: prices[Int(Double(prices.count)*0.8)])
            addPriceValue(value: prices[prices.count-1])
            addDateAsLabelValue(dates[0])
            addDateAsLabelValue(dates[Int(Double(dates.count)*0.16)])
            addDateAsLabelValue(dates[Int(Double(dates.count)*0.32)])
            addDateAsLabelValue(dates[Int(Double(dates.count)*0.48)])
            addDateAsLabelValue(dates[Int(Double(dates.count)*0.64)])
            addDateAsLabelValue(dates[Int(Double(dates.count)*0.8)])
            addDateAsLabelValue(dates[dates.count-1])
        }
        
        graphView.setData(price, withLabels: labels)
    }
    
    func sortPricesByDateRange(range: DateRange) {
        
        switch range {
            case .Week:
                setPriceHistoryDateSource(offsetDate: NSDate.changeDaysBy(-7))
            case .Month:
                setPriceHistoryDateSource(offsetDate: NSDate.changeDaysBy(-30))
            case .Lifetime:
                setPriceHistoryDateSource(offsetDate: item.priceHistory![0].date)
        }
    }
    
    func addPriceValue(value priceValue: Double!){
        if lowestPrice == nil || priceValue < lowestPrice {
            lowestPrice = priceValue
        }
        
        if highestPrice == nil || priceValue > highestPrice  {
            highestPrice = priceValue
        }
        
        price.append(priceValue)
    }
    
    func addDateAsLabelValue(dateValue: NSDate!) {
        let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM dd ''yy"
            dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        labels.append(dateFormatter.stringFromDate(dateValue).uppercaseString)
    }
}