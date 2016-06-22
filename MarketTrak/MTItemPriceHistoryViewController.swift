//
//  MTItemPriceHistoryViewController.swift
//  
//
//  Created by Jonathon Toon on 6/19/16.
//
//

import UIKit
import ScrollableGraphView

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
        setPriceHistoryDateSource()
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
        graphView.lineColor = UIColor.appTintColor()
        graphView.barLineColor = UIColor.appTintColor()
        graphView.dataPointFillColor = UIColor.whiteColor()
        graphView.fillColor = UIColor.appTintColor().colorWithAlphaComponent(0.3)
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
        graphView.lineStyle = .Smooth
        graphView.referenceLineThickness = 1.0/UIScreen.mainScreen().scale
        graphView.referenceLineColor = UIColor.whiteColor().colorWithAlphaComponent(0.12)
        graphView.referenceLineLabelFont = UIFont.systemFontOfSize(10, weight: UIFontWeightRegular)
        graphView.referenceLineLabelColor = UIColor.whiteColor()
        graphView.shouldAnimateOnStartup = false
        graphView.rangeMin = lowestPrice
        graphView.rangeMax = highestPrice
        graphView.referenceLineNumberOfDecimalPlaces = 2
        graphView.referenceLineUnits = "USD"
        graphView.shouldAddUnitsToIntermediateReferenceLineLabels = true
        graphView.dataPointSpacing = 40
        graphView.setData(price, withLabels: labels)
        graphView.bounces = false
        graphView.showsHorizontalScrollIndicator = false
        view.addSubview(graphView)
        graphView.autoPinEdge(.Top, toEdge: .Top, ofView: view, withOffset: 15)
        graphView.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: -2)
        graphView.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: 2)
        graphView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        graphView.contentOffset = CGPointMake(graphView.contentSize.width - graphView.bounds.size.width, 0)
    }
    
    func setPriceHistoryDateSource() {
        
        if let priceHistoryArray = item.priceHistory {
            for priceHistoryItem in priceHistoryArray {

                let priceValue = priceHistoryItem.price.currencyAmount.doubleValue
                
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
                labels.append(dateFormatter.stringFromDate(priceHistoryItem.date))
            }
        }
    }
}