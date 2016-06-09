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
        
        var offset: CGFloat = -18
        if frame.size.width == 375 {
            offset = -19
        } else if frame.size.width > 375 {
            offset = -24
        }
        
        accessoryView.autoPinEdge(.Right, toEdge: .Right, ofView: self, withOffset: offset)
        accessoryView.autoAlignAxis(.Horizontal, toSameAxisOfView: self)
        
        separatorView.autoPinEdge(.Top, toEdge: .Top, ofView: self)
        separatorView.autoPinEdge(.Left, toEdge: .Left, ofView: self, withOffset: 15)
        separatorView.autoPinEdge(.Right, toEdge: .Right, ofView: self)
        separatorView.autoSetDimension(.Height, toSize: 1/UIScreen.mainScreen().scale)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLabels(dataSource: MTFilterDataSource) {
        filterCategoryName.text = dataSource.displayedFilters[section!].name
        
        var selectedSubTitle: String = "Any"
        var totalSelected: Int = 0
        
        for i in 0..<dataSource.selectedFilters.count {
            
            let indexPath = dataSource.selectedFilters[i]
            if indexPath.section == section {
                
                if selectedSubTitle == "Any" {
                    selectedSubTitle = dataSource.filters[indexPath.section].options![indexPath.row].name
                }
                    
                totalSelected += 1
            }
        }
        
        if totalSelected > 1 {
            selectedSubTitle += ", +" + String(totalSelected-1)
        }
        
        filtersSelected.text = selectedSubTitle
        
    }
    
    func expandCell(animated animate: Bool) {
        self.expanded = true
        UIView.animateWithDuration(animate == true ? 0.25 : 0, animations: {
            self.accessoryView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI)/2)
        })
    }
    
    func retractCell(animated animate: Bool) {
        self.expanded = false
        UIView.animateWithDuration(animate == true ? 0.25 : 0, animations: {
            self.accessoryView.transform = CGAffineTransformMakeRotation(0)
        })
    }
}
