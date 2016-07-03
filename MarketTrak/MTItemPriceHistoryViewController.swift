//
//  MTItemPriceHistoryViewController.swift
//  
//
//  Created by Jonathon Toon on 6/19/16.
//
//

import UIKit
import BEMSimpleLineGraph

enum DateRange: Int {
    case Week = 0
    case Month = 1
    case SixMonths = 2
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
    
    var priceHistoryItems: [MTPriceHistoryItem] = []

    let dateSegmentedControl: UISegmentedControl = UISegmentedControl(items: ["This Week", "Last 30 Days", "Last 6 Months"])
    let graph: BEMSimpleLineGraphView = BEMSimpleLineGraphView.newAutoLayoutView()
    
    init(item: MTItem) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
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
        titleLabel.autoPinEdge(.Top, toEdge: .Top, ofView: topNavigationBar, withOffset: 16)
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
        doneButton.autoPinEdge(.Top, toEdge: .Top, ofView: topNavigationBar, withOffset: 16)
        doneButton.autoPinEdge(.Right, toEdge: .Right, ofView: topNavigationBar, withOffset: -15)
        doneButton.autoSetDimensionsToSize(CGSizeMake(50, 17))
        
        topNavigationBar.addSubview(dateSegmentedControl)
        dateSegmentedControl.tintColor = UIColor.appTintColor()
        dateSegmentedControl.selectedSegmentIndex = 0
        dateSegmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.appTintColor(), NSFontAttributeName: UIFont.systemFontOfSize(13, weight: UIFontWeightMedium)], forState: .Normal)
        dateSegmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.navigationBarColor(), NSFontAttributeName: UIFont.systemFontOfSize(13, weight: UIFontWeightMedium)], forState: .Selected)
        dateSegmentedControl.addTarget(self, action: #selector(MTItemPriceHistoryViewController.segmentSelected(_:)), forControlEvents: .ValueChanged)
        dateSegmentedControl.autoPinEdge(.Top, toEdge: .Top, ofView: topNavigationBar, withOffset: 50)
        dateSegmentedControl.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: 15)
        dateSegmentedControl.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: -15)
        dateSegmentedControl.autoSetDimension(.Height, toSize: 30)
        
        sortPricesByDateRange(.Week)
        
        view.addSubview(graph)
        graph.autoPinEdge(.Top, toEdge: .Bottom, ofView: topNavigationBar)
        graph.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: -2)
        graph.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: 2)
        graph.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view)
        graph.dataSource = self
        graph.delegate = self
        graph.animationGraphStyle = .None
        graph.backgroundColor = .backgroundColor()
        graph.enableTouchReport = true
        graph.enableBezierCurve = true
        graph.enableYAxisLabel = true
        graph.enablePopUpReport = true
        graph.autoScaleYAxis = true
        graph.formatStringForValues = "$%.02f USD"
        graph.colorBottom = .redColor()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func segmentSelected(segmentControl: UISegmentedControl!) {
        switch segmentControl.selectedSegmentIndex {
            case 1:
                sortPricesByDateRange(.Month)
            case 2:
                sortPricesByDateRange(.SixMonths)
            default:
                sortPricesByDateRange(.Week)
        }
        
        graph.reloadGraph()
    }
    
    func setPriceHistoryDateSource(offsetDate offsetDate: NSDate! = nil) {
        
        priceHistoryItems = []
        
        if let priceHistoryItemArray = item.priceHistory {
            for priceHistoryItem in priceHistoryItemArray {

                let dateValue = priceHistoryItem.date
                
                if let offset = offsetDate {
                    if dateValue.compare(offset) == NSComparisonResult.OrderedDescending || dateValue.compare(offset) == NSComparisonResult.OrderedSame {
                        priceHistoryItems.append(priceHistoryItem)
                    }
                }
            }
        }
    }
    
    func sortPricesByDateRange(range: DateRange) {
        
        switch range {
            case .Week:
                setPriceHistoryDateSource(offsetDate: NSDate.changeDaysBy(-7))
            case .Month:
                setPriceHistoryDateSource(offsetDate: NSDate.changeDaysBy(-30))
            case .SixMonths:
                setPriceHistoryDateSource(offsetDate: NSDate.changeDaysBy(-182))
        }
    }
}

extension MTItemPriceHistoryViewController: BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource {
 
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return priceHistoryItems.count
    }
    
    func numberOfGapsBetweenLabelsOnLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return priceHistoryItems.count/7
    }

    func numberOfYAxisLabelsOnLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return 4
    }
    
    func baseIndexForXAxisOnLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return 0
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        return CGFloat(priceHistoryItems[index].price.currencyAmount)
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String {
        
        let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM dd"
            dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)

        return dateFormatter.stringFromDate(priceHistoryItems[index].date).uppercaseString
    }
}