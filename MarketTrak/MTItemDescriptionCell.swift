//
//  MTItemDescriptionCell.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 3/6/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTItemDescriptionCell: UITableViewCell {

    let descriptionTextView = UITextView.newAutoLayoutView()
   
    init(item: MTItem!, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(descriptionTextView)
        
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.maximumLineHeight = 20.0
            paragraphStyle.minimumLineHeight = 20.0

        descriptionTextView.attributedText = NSAttributedString(string: item.desc!, attributes: [NSParagraphStyleAttributeName: paragraphStyle])
        descriptionTextView.text = item.desc
        descriptionTextView.textColor = UIColor.whiteColor()
        descriptionTextView.backgroundColor = UIColor.searchResultCellColor()
        descriptionTextView.font = UIFont.systemFontOfSize(14.0, weight: UIFontWeightRegular)
        descriptionTextView.scrollEnabled = false
        descriptionTextView.autoPinEdge(.Top, toEdge: .Top, ofView: contentView, withOffset: 5)
        descriptionTextView.autoPinEdge(.Left, toEdge: .Left, ofView: contentView, withOffset: 12)
        descriptionTextView.autoPinEdge(.Right, toEdge: .Right, ofView: contentView, withOffset: -12)
        descriptionTextView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: contentView, withOffset: -5)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
