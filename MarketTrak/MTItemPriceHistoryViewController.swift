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

        let data: [Double] = [4, 8, 15, 16, 23, 42]
        let labels = ["one", "two", "three", "four", "five", "six"]
        
        graphView.shouldAnimateOnStartup = false
        graphView.setData(data, withLabels: labels)
        graphView.backgroundColor = UIColor.redColor()
        view.addSubview(graphView)
        graphView.autoPinEdge(.Top, toEdge: .Top, ofView: view)
        graphView.autoPinEdge(.Left, toEdge: .Left, ofView: view)
        graphView.autoPinEdge(.Right, toEdge: .Right, ofView: view)
        graphView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view)
    }
}
