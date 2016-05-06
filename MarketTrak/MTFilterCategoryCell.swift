//
//  MTFilterCategoryCell.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/5/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTFilterCategoryCell: UITableViewCell {
    
    let filterTitle = UILabel.newAutoLayoutView()
    let keywordSearchTextfield = UITextField.newAutoLayoutView()
    let selectedFilterTitles = UILabel.newAutoLayoutView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .backgroundColor()
        
        contentView.addSubview(filterTitle)
        filterTitle.font = .systemFontOfSize(12, weight: UIFontWeightMedium)
        filterTitle.textColor = .metaTextColor()
        filterTitle.textAlignment = .Center
        filterTitle.autoPinEdge(.Top, toEdge: .Top, ofView: contentView, withOffset: 25)
        filterTitle.autoPinEdge(.Left, toEdge: .Left, ofView: contentView)
        filterTitle.autoPinEdge(.Right, toEdge: .Right, ofView: contentView)
        filterTitle.autoSetDimension(.Height, toSize: 16)
        
        contentView.addSubview(keywordSearchTextfield)
        keywordSearchTextfield.font = .systemFontOfSize(20, weight: UIFontWeightRegular)
        keywordSearchTextfield.textColor = .appTintColor()
        keywordSearchTextfield.textAlignment = .Center
        keywordSearchTextfield.hidden = true
        keywordSearchTextfield.autoPinEdge(.Left, toEdge: .Left, ofView: contentView)
        keywordSearchTextfield.autoPinEdge(.Right, toEdge: .Right, ofView: contentView)
        keywordSearchTextfield.autoSetDimension(.Height, toSize: 24)
        keywordSearchTextfield.autoAlignAxis(.Horizontal, toSameAxisOfView: contentView, withOffset: 5)
        
        contentView.addSubview(selectedFilterTitles)
        selectedFilterTitles.font = keywordSearchTextfield.font
        selectedFilterTitles.textColor = keywordSearchTextfield.textColor
        selectedFilterTitles.textAlignment = .Center
        selectedFilterTitles.hidden = true
        selectedFilterTitles.autoPinEdge(.Left, toEdge: .Left, ofView: contentView)
        selectedFilterTitles.autoPinEdge(.Right, toEdge: .Right, ofView: contentView)
        selectedFilterTitles.autoSetDimension(.Height, toSize: 24)
        selectedFilterTitles.autoAlignAxis(.Horizontal, toSameAxisOfView: contentView, withOffset: 5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
