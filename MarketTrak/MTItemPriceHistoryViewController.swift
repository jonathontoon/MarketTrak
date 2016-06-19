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

        graphView.shouldAnimateOnStartup = false
        graphView.shouldAutomaticallyDetectRange = true
        graphView.setData(price, withLabels: labels)
        view.addSubview(graphView)
        graphView.autoPinEdge(.Top, toEdge: .Top, ofView: view)
        graphView.autoPinEdge(.Left, toEdge: .Left, ofView: view)
        graphView.autoPinEdge(.Right, toEdge: .Right, ofView: view)
        graphView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        graphView.contentOffset = CGPointMake(graphView.contentSize.width - graphView.bounds.size.width, 0)
    }
    
    func setPriceHistoryDateSource() {
        
        if let priceHistoryArray = item.priceHistory {
            for priceHistoryItem in priceHistoryArray {
                price.append(priceHistoryItem.price.currencyAmount.doubleValue)
                labels.append(priceHistoryItem.price.currencyAmount.stringValue)
            }
        }
        
    }
}