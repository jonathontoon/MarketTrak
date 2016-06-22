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
    
    let graphView: ScrollableGraphView = ScrollableGraphView.newAutoLayoutView()
    
    init(item: MTItem) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
        sortPricesByDateRange(.Week)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Price History"

        view.backgroundColor = UIColor.backgroundColor()
        
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
        graphView.rangeMin = lowestPrice
        graphView.rangeMax = highestPrice
        graphView.numberOfIntermediateReferenceLines = 5
        graphView.referenceLineNumberOfDecimalPlaces = 2
        graphView.referenceLineUnits = "USD"
        graphView.shouldAddUnitsToIntermediateReferenceLineLabels = true
        graphView.dataPointSpacing = 54
        graphView.direction = .RightToLeft
        graphView.setData(price, withLabels: labels)
        graphView.showsHorizontalScrollIndicator = false
        view.addSubview(graphView)
        graphView.autoPinEdge(.Top, toEdge: .Top, ofView: view, withOffset: 45)
        graphView.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: -2)
        graphView.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: 2)
        graphView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setPriceHistoryDateSource(offsetDate offsetDate: NSDate! = nil, withGranularRange: Bool! = false) {
        
        var previousDate: NSDate!
        
        if let priceHistoryArray = item.priceHistory {
            for priceHistoryItem in priceHistoryArray {

                let priceValue = priceHistoryItem.price.currencyAmount.doubleValue
                let dateValue = priceHistoryItem.date
                
                if let offset = offsetDate {
                    if dateValue.compare(offset) == NSComparisonResult.OrderedDescending || dateValue.compare(offset) == NSComparisonResult.OrderedSame {
                        
                        if previousDate == nil {
                            
                            previousDate = dateValue
                            
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
                            labels.append("")
                            
                        } else {
                            
                            if withGranularRange == true {
                                
                                previousDate = dateValue
                                
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
                                
                                let dateFormatter = NSDateFormatter()
                                dateFormatter.dateFormat = "MMM dd"
                                dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                                
                                if NSCalendar.currentCalendar().isDateInToday(priceHistoryItem.date) {
                                    labels.append("")
                                } else {
                                    labels.append(dateFormatter.stringFromDate(priceHistoryItem.date).uppercaseString)
                                }
                                
                            } else {
                                
                                if !NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.isDate(previousDate, inSameDayAsDate: dateValue) {
                                    
                                    previousDate = dateValue
                                    
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
                                    
                                    let dateFormatter = NSDateFormatter()
                                        dateFormatter.dateFormat = "MMM dd"
                                        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                                    
                                    if NSCalendar.currentCalendar().isDateInToday(priceHistoryItem.date) {
                                        labels.append("")
                                    } else {
                                        labels.append(dateFormatter.stringFromDate(priceHistoryItem.date).uppercaseString)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func sortPricesByDateRange(range: DateRange) {
        switch range {
            case .Week:
                setPriceHistoryDateSource(offsetDate: NSDate.changeDaysBy(-7), withGranularRange: true)
            case .Month:
                setPriceHistoryDateSource(offsetDate: NSDate.changeDaysBy(-30))
            case .Lifetime:
                setPriceHistoryDateSource(offsetDate: item.priceHistory![0].date)
        }
    }
}