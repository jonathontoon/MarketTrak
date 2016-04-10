//
//  MTItemCollectionCell.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 3/8/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTItemCollectionCell: UITableViewCell {

    let collectionImageView = UIImageView.newAutoLayoutView()
    let collectionSubTitleLabel = UILabel.newAutoLayoutView()
    let collectionNameLabel = UILabel.newAutoLayoutView()
    
    init(item: MTItem!, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        
        let image = UIImage(named: "back_icon")!
        let flippedImage = UIImage(CGImage: image.CGImage!, scale: image.scale, orientation: .Left)
        let accessoryArrowView = UIImageView(image: flippedImage.imageWithRenderingMode(.AlwaysTemplate))
            contentView.addSubview(accessoryArrowView)
            accessoryArrowView.contentMode = .ScaleAspectFit
            accessoryArrowView.tintColor = UIColor.appTintColor()
            accessoryArrowView.autoSetDimensionsToSize(CGSizeMake(20, 20))
            accessoryArrowView.autoPinEdge(.Right, toEdge: .Right, ofView: contentView, withOffset: -10)
            accessoryArrowView.autoAlignAxis(.Horizontal, toSameAxisOfView: contentView)
        
        contentView.addSubview(collectionImageView)
        collectionImageView.contentMode = .ScaleAspectFit
        if item.collection != nil && item.collection != "" {
            collectionImageView.image = UIImage(named: item.collection!)
        }
        collectionImageView.autoPinEdge(.Left, toEdge: .Left, ofView: contentView, withOffset: 10)
        collectionImageView.autoAlignAxis(.Horizontal, toSameAxisOfView: contentView)
        collectionImageView.autoSetDimensionsToSize(CGSizeMake(62, 62))
        
        contentView.addSubview(collectionSubTitleLabel)
        collectionSubTitleLabel.text = "Included in".uppercaseString
        collectionSubTitleLabel.textColor = UIColor.metaTextColor()
        collectionSubTitleLabel.font = UIFont.systemFontOfSize(12.0, weight: UIFontWeightRegular)
        collectionSubTitleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: collectionImageView, withOffset: 4)
        collectionSubTitleLabel.autoPinEdge(.Top, toEdge: .Top, ofView: collectionImageView, withOffset: 13)
        collectionSubTitleLabel.autoPinEdge(.Right, toEdge: .Right, ofView: self, withOffset: -20)
        
        contentView.addSubview(collectionNameLabel)
        collectionNameLabel.text = item.collection
        collectionNameLabel.textColor = UIColor.whiteColor()
        collectionNameLabel.font = UIFont.systemFontOfSize(17.0, weight: UIFontWeightMedium)
        collectionNameLabel.autoPinEdge(.Left, toEdge: .Left, ofView: collectionSubTitleLabel)
        collectionNameLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: collectionSubTitleLabel, withOffset: 2)
        collectionNameLabel.autoPinEdge(.Right, toEdge: .Right, ofView: self, withOffset: -20)
        
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
