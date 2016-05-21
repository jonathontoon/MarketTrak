//
//  MTSearchFilterCategoryHeaderView.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/14/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTSearchFilterCategoryHeaderView: UIView {

    var section: Int?
    var expanded: Bool! = false
    
    let filterCategoryName = UILabel.newAutoLayoutView()
    let filtersSelected = UILabel.newAutoLayoutView()
    let accessoryView = UIImageView.newAutoLayoutView()
    let separatorView = UIView.newAutoLayoutView()
    
    init() {
        super.init(frame: CGRectZero)
        
        backgroundColor = UIColor.searchResultCellColor()
        
        filterCategoryName.font = UIFont.systemFontOfSize(17, weight: UIFontWeightRegular)
        filterCategoryName.textColor = UIColor.whiteColor()
        addSubview(filterCategoryName)
        
        filtersSelected.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
        filtersSelected.textColor = UIColor.metaTextColor()
        addSubview(filtersSelected)
        
        accessoryView.image = UIImage(named: "accessory_view")?.imageWithRenderingMode(.AlwaysTemplate)
        accessoryView.sizeToFit()
        accessoryView.tintColor = UIColor.appTintColor()
        addSubview(accessoryView)
        
        separatorView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.05)
        addSubview(separatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        filterCategoryName.autoPinEdge(.Left, toEdge: .Left, ofView: self, withOffset: 15)
        filterCategoryName.autoPinEdge(.Right, toEdge: .Right, ofView: self, withOffset: -50)
        filterCategoryName.autoPinEdge(.Top, toEdge: .Top, ofView: self, withOffset: 13)
        
        filtersSelected.autoPinEdge(.Left, toEdge: .Left, ofView: self, withOffset: 15)
        filtersSelected.autoPinEdge(.Right, toEdge: .Right, ofView: self, withOffset: -50)
        filtersSelected.autoPinEdge(.Top, toEdge: .Bottom, ofView: filterCategoryName, withOffset: 2)
        
        accessoryView.autoPinEdge(.Right, toEdge: .Right, ofView: self, withOffset: -15)
        accessoryView.autoAlignAxis(.Horizontal, toSameAxisOfView: self)
        
        separatorView.autoPinEdge(.Top, toEdge: .Top, ofView: self)
        separatorView.autoPinEdge(.Left, toEdge: .Left, ofView: self, withOffset: 15)
        separatorView.autoPinEdge(.Right, toEdge: .Right, ofView: self)
        separatorView.autoSetDimension(.Height, toSize: 1/UIScreen.mainScreen().scale)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func expandCell(animated: Bool) {
        self.expanded = true
        UIView.animateWithDuration(animated == true ? 0.25 : 0, animations: {
            self.accessoryView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI)/2)
        })
    }
    
    func retractCell(animated: Bool) {
        self.expanded = false
        UIView.animateWithDuration(animated == true ? 0.25 : 0, animations: {
            self.accessoryView.transform = CGAffineTransformMakeRotation(0)
        })
    }
}
