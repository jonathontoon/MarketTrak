//
//  MTSearchFilterCategoryCell.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/14/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTSearchFilterCategoryCell: UITableViewCell {

    var expanded: Bool = false
    
    let filterCategoryName = UILabel.newAutoLayoutView()
    let filtersSelected = UILabel.newAutoLayoutView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.searchResultCellColor()
        self.selectedBackgroundView?.backgroundColor = UIColor.searchResultCellColor()
        
        filterCategoryName.font = UIFont.systemFontOfSize(17, weight: UIFontWeightRegular)
        filterCategoryName.textColor = UIColor.whiteColor()
        contentView.addSubview(filterCategoryName)
        filterCategoryName.autoPinEdge(.Left, toEdge: .Left, ofView: contentView, withOffset: 15)
        filterCategoryName.autoPinEdge(.Right, toEdge: .Right, ofView: contentView)
        filterCategoryName.autoPinEdge(.Top, toEdge: .Top, ofView: contentView, withOffset: 13)
        
        filtersSelected.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
        filtersSelected.textColor = UIColor.metaTextColor()
        contentView.addSubview(filtersSelected)
        filtersSelected.autoPinEdge(.Left, toEdge: .Left, ofView: contentView, withOffset: 15)
        filtersSelected.autoPinEdge(.Right, toEdge: .Right, ofView: contentView)
        filtersSelected.autoPinEdge(.Top, toEdge: .Bottom, ofView: filterCategoryName, withOffset: 2)
        
        self.accessoryView = UIImageView(image: UIImage(named: "accessory_view")?.imageWithRenderingMode(.AlwaysTemplate))
        self.accessoryView?.tintColor = UIColor.appTintColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func expandCell(animated: Bool) {
        UIView.animateWithDuration(animated == true ? 0.25 : 0, animations: {
            self.accessoryView?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI)/2)
        })
    }
    
    func retractCell(animated: Bool) {
        UIView.animateWithDuration(animated == true ? 0.25 : 0, animations: {
            self.accessoryView?.transform = CGAffineTransformMakeRotation(0)
        })
    }
}
