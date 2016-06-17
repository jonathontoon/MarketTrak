//
//  MTItemTitleCell.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 4/9/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit
import PureLayout

class MTItemTitleCell: UITableViewCell {
    
    let itemPriceLabel = UILabel.newAutoLayoutView()
    let itemNameLabel = UILabel.newAutoLayoutView()
    let itemMetaLabel = UILabel.newAutoLayoutView()
    var itemCategoryLabel: UILabel!
    var itemQualityLabel: UILabel!
    
    init(item: MTItem!, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)

        // Item Price
        contentView.addSubview(itemPriceLabel)
        
        // Revisit this for selectable currencies
        let priceFormatter = NSNumberFormatter()
        priceFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        priceFormatter.maximumFractionDigits = 2
        priceFormatter.minimumFractionDigits = 2
        priceFormatter.minimumIntegerDigits = 1
        
        itemPriceLabel.text = "$" + priceFormatter.stringFromNumber(item.currentPrice!)! + " USD"
        itemPriceLabel.textColor = UIColor.priceTintColor()
        itemPriceLabel.font = UIFont.systemFontOfSize(15.0, weight: UIFontWeightMedium)
        
        let sizeOfItemPriceLabel = NSString(string: itemPriceLabel.text!).sizeWithAttributes([NSFontAttributeName: itemPriceLabel.font])
        itemPriceLabel.autoPinEdge(.Top, toEdge: .Top, ofView: contentView, withOffset: 15)
        itemPriceLabel.autoPinEdge(.Left, toEdge: .Left, ofView: contentView, withOffset: 15)
        itemPriceLabel.autoPinEdge(.Right, toEdge: .Right, ofView: contentView, withOffset: -15)
        itemPriceLabel.autoSetDimension(.Height, toSize: sizeOfItemPriceLabel.height)
        
        // Skin Name
        contentView.addSubview(itemNameLabel)
        itemNameLabel.text = item.name!
        
        if item.weaponType != nil && item.weaponType != WeaponType.None  {
            if item.exterior != nil && item.exterior != .NotPainted	 {
                itemNameLabel.text = item.weaponType!.stringDescription() + " | " + item.name!
                    + " (" + item.exterior!.stringDescription() + ")"
            } else {
                itemNameLabel.text = item.weaponType!.stringDescription() + " | " + item.name!
            }
        } else {
            if item.type == Type.MusicKit {
                if item.artistName != nil {
                    itemNameLabel.text = item.name! + " " + item.artistName!
                }
            } else {
                if item.exterior != nil && item.exterior != .NotPainted	 {
                    itemNameLabel.text = item.name! + " (" + item.exterior!.stringDescription() + ")"
                } else {
                    itemNameLabel.text = item.name!
                }
            }
        }
        
        if itemNameLabel.text == "★" {
            itemNameLabel.text = "★ " + item.weaponType!.stringDescription()
        }
        
        itemNameLabel.textColor = UIColor.whiteColor()
        itemNameLabel.font = UIFont.systemFontOfSize(17.0, weight: UIFontWeightMedium)
        
        let sizeOfItemNameLabel = NSString(string: itemNameLabel.text!).sizeWithAttributes([NSFontAttributeName: itemNameLabel.font])
        itemNameLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemPriceLabel, withOffset: 5)
        itemNameLabel.autoPinEdge(.Left, toEdge: .Left, ofView: contentView, withOffset: 15)
        itemNameLabel.autoPinEdge(.Right, toEdge: .Right, ofView: contentView, withOffset: -15)
        itemNameLabel.autoSetDimension(.Height, toSize: sizeOfItemNameLabel.height)
        
        // Category Tag
        if let category = item.category {
            
            if category != Category.None && category != Category.Normal {
                
                itemCategoryLabel = UILabel(frame: CGRectZero)
                itemCategoryLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightMedium)
                itemCategoryLabel.text = category.stringDescription()
                itemCategoryLabel.textColor = category.colorForCategory()
                itemCategoryLabel.textAlignment = NSTextAlignment.Center
                itemCategoryLabel.layer.borderColor = category.colorForCategory().CGColor
                itemCategoryLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                itemCategoryLabel.clipsToBounds = true
                itemCategoryLabel.layer.cornerRadius = 4.0
                contentView.addSubview(itemCategoryLabel)
                
                let sizeOfItemCategoryLabel = NSString(string: itemCategoryLabel.text!).sizeWithAttributes([NSFontAttributeName: itemCategoryLabel.font])
                itemCategoryLabel.autoSetDimensionsToSize(CGSizeMake(sizeOfItemCategoryLabel.width + 12, sizeOfItemCategoryLabel.height + 8))
                itemCategoryLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemNameLabel, withOffset: 8)
                itemCategoryLabel.autoPinEdge(.Left, toEdge: .Left, ofView: itemNameLabel, withOffset: 1)
            }
        }
        
        // Quality Tag
        if let quality = item.quality {
            
            if quality != Quality.None {
                
                itemQualityLabel = UILabel(frame: CGRectZero)
                itemQualityLabel.text = quality.stringDescription()
                itemQualityLabel.textColor = quality.colorForQuality()
                itemQualityLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightMedium)
                itemQualityLabel.textAlignment = NSTextAlignment.Center
                itemQualityLabel.layer.borderColor = quality.colorForQuality().CGColor
                itemQualityLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                itemQualityLabel.clipsToBounds = true
                
                let sizeOfItemQualityLabel = NSString(string: itemQualityLabel.text!).sizeWithAttributes([NSFontAttributeName: itemQualityLabel.font])
                
                itemQualityLabel.layer.cornerRadius = 4
                self.addSubview(itemQualityLabel)
                
                itemQualityLabel.autoSetDimensionsToSize(CGSizeMake(sizeOfItemQualityLabel.width + 12, sizeOfItemQualityLabel.height + 8))
                itemQualityLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemNameLabel, withOffset: 8)
                
                var viewTopPin: UIView! = itemNameLabel
                var offsetAmount: CGFloat! = 1
                var toViewEdge: ALEdge! = .Left
                
                if let categoryLabel = itemCategoryLabel {
                    if item.category != Category.None && item.category != Category.Normal {
                        viewTopPin = categoryLabel
                        offsetAmount = 6.0
                        toViewEdge = .Right
                    }
                }
                
                itemQualityLabel.autoPinEdge(.Left, toEdge: toViewEdge, ofView: viewTopPin, withOffset: offsetAmount)
            }
        }
        
        let separator = UIView()
            separator.backgroundColor = UIColor(rgba: "#34383B")
        self.addSubview(separator)
            separator.autoPinEdge(.Left, toEdge: .Left, ofView: self, withOffset: 15)
            separator.autoPinEdge(.Right, toEdge: .Right, ofView: self)
            separator.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self)
            separator.autoSetDimension(.Height, toSize: 1.0 / UIScreen.mainScreen().scale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

