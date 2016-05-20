//
//  MTSearchFilterSelectableCell.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/14/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTSearchFilterSelectableCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textLabel?.textColor = UIColor.whiteColor()
        backgroundColor = UIColor.backgroundColor()
        selectedBackgroundView?.backgroundColor = UIColor.searchResultCellColor()
        accessoryView = UIImageView(image: UIImage(named: "cell_unselected")?.imageWithRenderingMode(.AlwaysTemplate))
        accessoryView?.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
