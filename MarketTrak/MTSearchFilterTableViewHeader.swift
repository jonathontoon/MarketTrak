//
//  MTSearchFilterTableViewHeader.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/21/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTSearchFilterTableViewHeader: UIView {
    
    let textLabel = UILabel.newAutoLayoutView()
    
    init() {
        super.init(frame: CGRectZero)
        
        addSubview(textLabel)
        textLabel.text = "Filters".uppercaseString
        textLabel.textColor = UIColor.metaTextColor()
        textLabel.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel.autoPinEdge(.Left, toEdge: .Left, ofView: self, withOffset: 15)
        textLabel.autoPinEdge(.Right, toEdge: .Right, ofView: self)
        textLabel.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self, withOffset: -10)
    }
}
