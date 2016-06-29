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
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor.backgroundColor()
        
        
        let topNavigationBar = UIView.newAutoLayoutView()
        view.addSubview(topNavigationBar)
        topNavigationBar.backgroundColor = UIColor.searchResultCellColor()
        topNavigationBar.layer.shadowColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        topNavigationBar.layer.shadowRadius = 0.0
        topNavigationBar.layer.shadowOpacity = 1.0
        topNavigationBar.layer.shadowOffset = CGSizeMake(0, (1.0 / UIScreen.mainScreen().scale) * -1)
        topNavigationBar.autoPinEdge(.Top, toEdge: .Top, ofView: view)
        topNavigationBar.autoPinEdge(.Left, toEdge: .Left, ofView: view)
        topNavigationBar.autoPinEdge(.Right, toEdge: .Right, ofView: view)
        topNavigationBar.autoSetDimension(.Height, toSize: 95)
        
        let titleLabel = UILabel.newAutoLayoutView()
        topNavigationBar.addSubview(titleLabel)
        
        if item.weaponType != nil && item.weaponType! != .None {

            titleLabel.text = item.weaponType!.stringDescription() + " | " + item.name! + " (" + item.exterior!.stringDescription() + ")"
            
            if item.category! == .StatTrak™ || item.category! == .Souvenir {
                titleLabel.text = item.category!.stringDescription() + " " + item.weaponType!.stringDescription() + " | " + item.name! + " (" + item.exterior!.stringDescription() + ")"
            }
            
        } else if item.type! == .Sticker {
            titleLabel.text = item.type!.stringDescription() + " | " + item.name!
        } else {
            titleLabel.text = item.name!
        }
        
        if item.category! == .Star {
            if !item.name!.containsString("★") {
                titleLabel.text = "★ " + item.weaponType!.stringDescription() + " | " + item.name! + " (" + item.exterior!.stringDescription() + ")"
            }
        }
        
        if item.category! == .StarStatTrak™ {
            if !item.name!.containsString("★") {
                titleLabel.text = "★ " + item.weaponType!.stringDescription() + " | " + item.name! + " (" + item.exterior!.stringDescription() + ")"
            }
        }
        
        titleLabel.font = UIFont.systemFontOfSize(17.0, weight: UIFontWeightMedium)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.autoPinEdge(.Top, toEdge: .Top, ofView: topNavigationBar, withOffset: 17)
        titleLabel.autoPinEdge(.Left, toEdge: .Left, ofView: topNavigationBar, withOffset: 15)
        titleLabel.autoPinEdge(.Right, toEdge: .Right, ofView: topNavigationBar, withOffset: -15)
        titleLabel.autoSetDimension(.Height, toSize: 17)
    
        let doneButton = UIButton(type: .System)
        topNavigationBar.addSubview(doneButton)
            doneButton.setTitle("Done", forState: .Normal)
            doneButton.setTitleColor(UIColor.appTintColor(), forState: .Normal)
            doneButton.titleLabel?.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
            doneButton.titleLabel?.textAlignment = .Right
            doneButton.addTarget(self, action: #selector(MTModalViewController.dismissSettingsViewController), forControlEvents: .TouchUpInside)
        doneButton.autoPinEdge(.Top, toEdge: .Top, ofView: topNavigationBar, withOffset: 17)
        doneButton.autoPinEdge(.Right, toEdge: .Right, ofView: topNavigationBar, withOffset: -15)
        doneButton.autoSetDimensionsToSize(CGSizeMake(50, 17))
        
        topNavigationBar.addSubview(dateSegmentedControl)
        dateSegmentedControl.tintColor = UIColor.appTintColor()
        dateSegmentedControl.selectedSegmentIndex = 2
        dateSegmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.appTintColor(), NSFontAttributeName: UIFont.systemFontOfSize(13, weight: UIFontWeightMedium)], forState: .Normal)
        dateSegmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.navigationBarColor(), NSFontAttributeName: UIFont.systemFontOfSize(13, weight: UIFontWeightMedium)], forState: .Selected)
        dateSegmentedControl.addTarget(self, action: #selector(MTItemPriceHistoryViewController.segmentSelected(_:)), forControlEvents: .ValueChanged)
        dateSegmentedControl.autoPinEdge(.Top, toEdge: .Top, ofView: topNavigationBar, withOffset: 50)
        dateSegmentedControl.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: 15)
        dateSegmentedControl.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: -15)
        dateSegmentedControl.autoSetDimension(.Height, toSize: 30)
        
        sortPricesByDateRange(.Week)
        
        view.addSubview(graphView)
        graphView.backgroundFillColor = UIColor.backgroundColor()
        
        graphView.lineWidth = 1
        graphView.lineColor = UIColor.appTintColor()
        graphView.lineStyle = ScrollableGraphViewLineStyle.Straight
        
        graphView.shouldFill = true
        graphView.fillType = ScrollableGraphViewFillType.Solid
        graphView.fillColor = UIColor.appTintColor().colorWithAlphaComponent(0.1)
        graphView.fillGradientType = ScrollableGraphViewGradientType.Linear
        
        if view.frame.size.width >= 736.0 {
            graphView.dataPointSpacing = 75
        } else if view.frame.size.width <= 568.0 {
            graphView.dataPointSpacing = 72
        } else {
            graphView.dataPointSpacing = 66
        }
        
        graphView.dataPointSize = 3
        graphView.dataPointFillColor = UIColor.whiteColor()
        graphView.leftmostPointPadding = 70
        graphView.rightmostPointPadding = 40
        
        graphView.referenceLineLabelFont = UIFont.systemFontOfSize(9)
        graphView.referenceLineColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        graphView.referenceLineLabelColor = UIColor.whiteColor()
        graphView.dataPointLabelColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        graphView.numberOfIntermediateReferenceLines = 3
        graphView.referenceLineNumberOfDecimalPlaces = 2
        graphView.referenceLineUnits = "USD"
        graphView.shouldAddUnitsToIntermediateReferenceLineLabels = true
        graphView.shouldAutomaticallyDetectRange = true
        graphView.shouldAnimateOnAdapt = false
        graphView.shouldAnimateOnStartup = false
        graphView.shouldAdaptRange = true
        
        graphView.autoPinEdge(.Top, toEdge: .Bottom, ofView: topNavigationBar, withOffset: 20)
        graphView.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: -2)
        graphView.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: 2)
        graphView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view)
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
            addPriceValue(value: prices[Int(Double(prices.count)*0.125)])
            addPriceValue(value: prices[Int(Double(prices.count)*0.25)])
            addPriceValue(value: prices[Int(Double(prices.count)*0.375)])
            addPriceValue(value: prices[Int(Double(prices.count)*0.5)])
            addPriceValue(value: prices[Int(Double(prices.count)*0.625)])
            addPriceValue(value: prices[Int(Double(prices.count)*0.75)])
            addPriceValue(value: prices[Int(Double(prices.count)*0.875)])
            addPriceValue(value: prices[prices.count-1])
            addDateAsLabelValue(dates[0])
            addBlankStringAsLabelValue()
            addDateAsLabelValue(dates[Int(Double(dates.count)*0.25)])
            addBlankStringAsLabelValue()
            addDateAsLabelValue(dates[Int(Double(dates.count)*0.5)])
            addBlankStringAsLabelValue()
            addDateAsLabelValue(dates[Int(Double(dates.count)*0.75)])
            addBlankStringAsLabelValue()
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
            dateFormatter.dateFormat = "MM/dd/yy"
            dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        labels.append(dateFormatter.stringFromDate(dateValue).uppercaseString)
    }
    
    func addBlankStringAsLabelValue() {
        labels.append("")
    }
}