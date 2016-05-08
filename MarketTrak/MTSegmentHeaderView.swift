//
//  MTSegmentHeaderView.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/8/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

protocol MTSegmentHeaderViewDelegate {
    
    func didChangeSegmentIndex(index: Int)
    
}

class MTSegmentHeaderView: UICollectionReusableView {
    
    let itemResultSortControl = UISegmentedControl(items: ["Popular", "Name", "Quantity", "Price"])
    var delegate: MTSegmentHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.backgroundColor()
        
        addSubview(itemResultSortControl)
        itemResultSortControl.tintColor = UIColor.appTintColor()
        itemResultSortControl.selectedSegmentIndex = 0
        itemResultSortControl.addTarget(self, action: "segmentChanged:", forControlEvents: .ValueChanged)
        itemResultSortControl.autoPinEdge(.Left, toEdge: .Left, ofView: self, withOffset: 10)
        itemResultSortControl.autoPinEdge(.Right, toEdge: .Right, ofView: self, withOffset: -10)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func segmentChanged(control: UISegmentedControl) {
        if let d = delegate {
            d.didChangeSegmentIndex(control.selectedSegmentIndex)
        }
    }
}
