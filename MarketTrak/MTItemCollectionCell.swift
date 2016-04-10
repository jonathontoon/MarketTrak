//
//  MTItemCollectionCell.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 3/8/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit
import SDWebImage

class MTItemCollectionCell: UITableViewCell {

    var imageOperation: SDWebImageOperation?
    
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
        
        // Weapon
        if item.weaponType != nil && item.weaponType != .None {
            
            if item.collection != nil && item.collection != "" {
                collectionImageView.image = UIImage(named: item.collection!)
            }
        }
        
        if item.type == .Container {
            
            if item.stickerCollection != nil && item.stickerCollection != "" {
                
                let downloadManager = SDWebImageManager()
                
                imageOperation = downloadManager.downloadImageWithURL(
                    item.imageURL!,
                    options: SDWebImageOptions.RetryFailed,
                    progress: nil,
                    completed: {
                        
                        (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, finished: Bool, imageURL: NSURL!) in
                        
                        if let img = image {
                            
                            self.collectionImageView.image = img
                            self.setNeedsLayout()
                            
                            let transition = CATransition()
                                transition.duration = 0.25
                                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                                transition.type = kCATransitionFade
                            
                            self.collectionImageView.layer.addAnimation(transition, forKey: nil)
                        }
                })
                
            } else if item.collection != nil && item.collection != "" {
                collectionImageView.image = UIImage(named: item.collection!)
            }
            
        }
        
        if item.type == .Sticker {
            
            if item.stickerCollection != nil && item.stickerCollection != "" {
                collectionImageView.image = UIImage(named: item.stickerCollection!)
            }
        }
        
        collectionImageView.autoPinEdge(.Left, toEdge: .Left, ofView: contentView, withOffset: 15)
        collectionImageView.autoAlignAxis(.Horizontal, toSameAxisOfView: contentView)
        collectionImageView.autoSetDimensionsToSize(CGSizeMake(62, 62))
        
        contentView.addSubview(collectionSubTitleLabel)
        
        var subTitleText = "Contains Items From"
        if item.type == .Key {
            subTitleText = "Opens Containers From"
        }
        
        if item.weaponType != nil && item.weaponType != .None {
            subTitleText = "Included In"
        }
        
        collectionSubTitleLabel.text = subTitleText.uppercaseString
        collectionSubTitleLabel.textColor = UIColor.metaTextColor()
        collectionSubTitleLabel.font = UIFont.systemFontOfSize(12.0, weight: UIFontWeightRegular)
        collectionSubTitleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: collectionImageView, withOffset: 4)
        collectionSubTitleLabel.autoPinEdge(.Top, toEdge: .Top, ofView: collectionImageView, withOffset: 13)
        collectionSubTitleLabel.autoPinEdge(.Right, toEdge: .Right, ofView: self, withOffset: -20)
        
        contentView.addSubview(collectionNameLabel)
        
        // Weapon
        if item.collection != nil && item.collection != "" {
            collectionNameLabel.text = item.collection!
        } else if item.stickerCollection != nil && item.stickerCollection != "" {
            collectionNameLabel.text = item.stickerCollection!
        }
        
        collectionNameLabel.textColor = UIColor.whiteColor()
        collectionNameLabel.font = UIFont.systemFontOfSize(17.0, weight: UIFontWeightMedium)
        collectionNameLabel.autoPinEdge(.Left, toEdge: .Left, ofView: collectionSubTitleLabel)
        collectionNameLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: collectionSubTitleLabel, withOffset: 2)
        collectionNameLabel.autoPinEdge(.Right, toEdge: .Right, ofView: self, withOffset: -40)
        
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
