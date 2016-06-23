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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Price History"

        view.backgroundColor = UIColor.backgroundColor()
        let containerTitleView = UIView(frame: CGRectMake(0, 0, 200, 33))
        self.navigationItem.titleView = containerTitleView
        containerTitleView.sizeToFit()
        
        let titleLabel = UILabel()
            titleLabel.text = "Price History"
            titleLabel.font = UIFont.systemFontOfSize(15, weight: UIFontWeightMedium)
            titleLabel.textColor = UIColor.whiteColor()
            titleLabel.textAlignment = .Center
            titleLabel.sizeToFit()
            titleLabel.frame = CGRectMake(0, -2, containerTitleView.frame.size.width, 17)
        containerTitleView.addSubview(titleLabel)
        
        let subTitleLabel = UILabel()
        
        subTitleLabel.text = item.name
        
        if item.weaponType != nil && item.weaponType! != .None {
            subTitleLabel.text = item.weaponType!.stringDescription() + " | " + item.name!
        } else if item.type! == .Sticker {
            subTitleLabel.text = item.type!.stringDescription() + " | " + item.name!
        } else {
            subTitleLabel.text = item.name!
        }
        
        if item.category! == .Star {
            if !item.name!.containsString("★") {
                subTitleLabel.text = "★ " + item.weaponType!.stringDescription() + " | " + item.name!
            }
        }
        
        if item.category! == .StarStatTrak™ {
            if !item.name!.containsString("★") {
                subTitleLabel.text = "★ " + item.weaponType!.stringDescription() + " | " + item.name!
            }
        }
        
        subTitleLabel.text = subTitleLabel.text?.uppercaseString
        
        subTitleLabel.font = UIFont.systemFontOfSize(10, weight: UIFontWeightRegular)
        subTitleLabel.textColor = UIColor.subTextColor()
        subTitleLabel.textAlignment = .Center
        subTitleLabel.frame = CGRectMake(0, 17, containerTitleView.frame.size.width, 12)
        containerTitleView.addSubview(subTitleLabel)

        
        sortPricesByDateRange(.Lifetime)
        
        view.addSubview(graphView)
        graphView.backgroundColor = UIColor.appTintColor()
        graphView.backgroundFillColor = UIColor.backgroundColor()
        graphView.lineColor = UIColor.appTintColor().colorWithAlphaComponent(0.5)
        graphView.barLineColor = UIColor.appTintColor()
        graphView.dataPointFillColor = UIColor.appTintColor()
        graphView.fillColor = UIColor.appTintColor().colorWithAlphaComponent(0.2)
        graphView.shouldFill = true
        graphView.dataPointLabelFont = UIFont.systemFontOfSize(10, weight: UIFontWeightRegular)
        graphView.dataPointLabelColor = UIColor.whiteColor()
        graphView.dataPointLabelTopMargin = 30
        graphView.topMargin = 20
        graphView.leftmostPointPadding = 0
        graphView.rightmostPointPadding = 0
        graphView.bottomMargin = 20
        graphView.shouldDrawDataPoint = true
        graphView.dataPointSize = 4
        graphView.referenceLineThickness = 1.0/UIScreen.mainScreen().scale
        graphView.referenceLineColor = UIColor.whiteColor().colorWithAlphaComponent(0.12)
        graphView.referenceLineLabelFont = UIFont.systemFontOfSize(10, weight: UIFontWeightRegular)
        graphView.referenceLineLabelColor = UIColor.whiteColor()
        graphView.shouldAnimateOnStartup = false
        graphView.shouldAdaptRange = false
        graphView.shouldAnimateOnAdapt = true
        graphView.numberOfIntermediateReferenceLines = 5
        graphView.referenceLineNumberOfDecimalPlaces = 2
        graphView.referenceLineUnits = "USD"
        graphView.shouldAddUnitsToIntermediateReferenceLineLabels = true
        graphView.shouldRangeAlwaysStartAtZero = true
        graphView.shouldAutomaticallyDetectRange = true
        graphView.dataPointSpacing = 50
        graphView.direction = .RightToLeft
        graphView.showsHorizontalScrollIndicator = false
        graphView.autoPinEdge(.Top, toEdge: .Top, ofView: view, withOffset: 45)
        graphView.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: -2)
        graphView.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: 2)
        graphView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view)
        
        view.addSubview(dateSegmentedControl)
        dateSegmentedControl.tintColor = UIColor.appTintColor()
        dateSegmentedControl.selectedSegmentIndex = 0
        dateSegmentedControl.addTarget(self, action: #selector(MTItemPriceHistoryViewController.segmentSelected(_:)), forControlEvents: .ValueChanged)
        dateSegmentedControl.autoPinEdge(.Top, toEdge: .Top, ofView: view, withOffset: 15)
        dateSegmentedControl.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: 15)
        dateSegmentedControl.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: -15)
        dateSegmentedControl.autoSetDimension(.Height, toSize: 25)
        
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
        
        var previousDate: NSDate!
        
        if let priceHistoryArray = item.priceHistory {
            for priceHistoryItem in priceHistoryArray {

                let priceValue = priceHistoryItem.price.currencyAmount.doubleValue
                let dateValue = priceHistoryItem.date
                
                if let offset = offsetDate {
                    if dateValue.compare(offset) == NSComparisonResult.OrderedDescending || dateValue.compare(offset) == NSComparisonResult.OrderedSame {
                        
                        if previousDate != nil {
                            if !NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.isDate(previousDate, inSameDayAsDate: dateValue) {
                                addPriceValue(value: priceValue)
                                addDateAsLabelValue(dateValue)
                            }
                        } else {
                            addPriceValue(value: priceValue)
                            addDateAsLabelValue(dateValue)
                        }
                        
                        previousDate = dateValue
                    }
                }
            }
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
        if lowestPrice == nil {
            lowestPrice = priceValue
        }
        
        if priceValue < lowestPrice {
            lowestPrice = priceValue
        }
        
        if highestPrice == nil {
            highestPrice = priceValue
        }
        
        if priceValue > highestPrice {
            highestPrice = priceValue
        }
        
        price.append(priceValue)
    }
    
    func addDateAsLabelValue(dateValue: NSDate!) {
        let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM dd"
            dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        
        if dateValue == item.priceHistory![0].date || dateValue == item.priceHistory![item.priceHistory!.count-1].date  {
            labels.append("")
        } else {
            labels.append(dateFormatter.stringFromDate(dateValue).uppercaseString)
        }
    }
}