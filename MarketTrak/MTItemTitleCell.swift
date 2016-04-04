//
//  MTItemTitleCell.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 3/6/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit
import SDWebImage

class MTItemTitleCell: UITableViewCell {

    var item: MTItem!
    
    var imageOperation: SDWebImageOperation?
    
    let itemImageViewMask = UIImageView.newAutoLayoutView()
    let itemImageView = UIImageView.newAutoLayoutView()
    
    let itemPriceLabel = UILabel.newAutoLayoutView()
    let itemNameLabel = UILabel.newAutoLayoutView()
    var itemMetaLabel: UILabel!
    var itemCategoryLabel: UILabel!
    var itemQualityLabel: UILabel!
    
    init(item: MTItem!, frame: CGRect!, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        self.item = item
        
        self.frame = frame
        contentView.frame = self.frame
        
        contentView.addSubview(itemImageViewMask)
        itemImageViewMask.image = UIImage(named: "gradient_image_small")
        itemImageViewMask.clipsToBounds = true
        itemImageViewMask.backgroundColor = UIColor.yellowColor()
        
        itemImageViewMask.addSubview(itemImageView)
        itemImageView.backgroundColor = UIColor.clearColor()
        itemImageView.contentMode = .ScaleAspectFit
        
        let downloadManager = SDWebImageManager()
        
        imageOperation = downloadManager.downloadImageWithURL(
            item.imageURL!,
            options: SDWebImageOptions.RetryFailed,
            progress: nil,
            completed: {
                
                (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, finished: Bool, imageURL: NSURL!) in
                
                if let img = image {
                    
                    self.itemImageView.image = img
                    self.setNeedsLayout()
                    
                    let transition = CATransition()
                    transition.duration = 0.25
                    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                    transition.type = kCATransitionFade
                    
                    self.itemImageView.layer.addAnimation(transition, forKey: nil)
                }
                
        })
        
        // Item Price
        contentView.addSubview(itemPriceLabel)
        
        // Revisit this for selectable currencies
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        
        itemPriceLabel.text = "$" + formatter.stringFromNumber(item.price!)! + " USD"
        itemPriceLabel.textColor = UIColor.priceTintColor()
        itemPriceLabel.font = UIFont.systemFontOfSize(15.0, weight: UIFontWeightMedium)

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

////
////        // Skin Meta
////        itemMetaLabel = UILabel()
////        
////        if item.type == Type.MusicKit {
////            itemMetaLabel.text = item.artistName!.uppercaseString
////        } else if item.type == Type.Container {
////            itemMetaLabel.text = (String(item.items!.count) + " items • 1 of " + item.quantity!).uppercaseString
////        } else if item.type == Type.Sticker {
////            if item.stickerCollection != nil && item.stickerCollection != "" {
////                itemMetaLabel.text = (item.type!.stringDescription() + " • " + item.stickerCollection!).uppercaseString
////            } else if item.tournament != nil && item.tournament != "" {
////                itemMetaLabel.text = (item.tournament! + " • 1 of " + item.quantity!).uppercaseString
////            }
////        } else {
////            if item.exterior != nil && item.exterior! != .None && item.exterior! != Exterior.NotPainted {
////                itemMetaLabel.text = (item.exterior!.stringDescription() + " • 1 of " + item.quantity!).uppercaseString
////            } else {
////                itemMetaLabel.text = ("1 of " + item.quantity!).uppercaseString
////            }
////        }
////        
////        itemMetaLabel.textColor = UIColor.metaTextColor()
////        itemMetaLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightRegular)
////        
////        let sizeOfItemMetaLabel = NSString(string: itemMetaLabel.text!).sizeWithAttributes([NSFontAttributeName: itemMetaLabel.font])
////        itemMetaLabel.frame = CGRectMake(itemImageViewMask.frame.origin.x, itemNameLabel.frame.origin.y + itemNameLabel.frame.size.height + 3.0, itemImageViewMask.frame.size.width, sizeOfItemMetaLabel.height)
////        contentView.addSubview(itemMetaLabel)
//        
//        // Category Tag
//        if let category = item.category {
//            
//            if category != Category.None && category != Category.Normal {
//                
//                itemCategoryLabel = UILabel(frame: CGRectZero)
//                itemCategoryLabel.font = UIFont.systemFontOfSize(9.0, weight: UIFontWeightBold)
//                itemCategoryLabel.text = category.stringDescription()
//                itemCategoryLabel.textColor = category.colorForCategory()
//                itemCategoryLabel.textAlignment = NSTextAlignment.Center
//                itemCategoryLabel.layer.borderColor = category.colorForCategory().CGColor
//                itemCategoryLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
//                itemCategoryLabel.clipsToBounds = true
//                
//                let sizeOfItemCategoryLabel = NSString(string: itemCategoryLabel.text!).sizeWithAttributes([NSFontAttributeName: itemCategoryLabel.font])
//                
//                itemCategoryLabel.frame = CGRectMake(itemImageViewMask.frame.origin.x, itemNameLabel.frame.origin.y + itemNameLabel.frame.size.height + 5.0, sizeOfItemCategoryLabel.width + 12.0, sizeOfItemCategoryLabel.height + 8.0)
//                itemCategoryLabel.layer.cornerRadius = 4.0
//                
//                contentView.addSubview(itemCategoryLabel)
//            }
//        }
//        
//        // Quality Tag
//        if let quality = item.quality {
//            
//            if quality != Quality.None {
//                
//                itemQualityLabel = UILabel(frame: CGRectZero)
//                itemQualityLabel.text = quality.stringDescription()
//                itemQualityLabel.textColor = quality.colorForQuality()
//                itemQualityLabel.font = UIFont.systemFontOfSize(9.0, weight: UIFontWeightBold)
//                itemQualityLabel.textAlignment = NSTextAlignment.Center
//                itemQualityLabel.layer.borderColor = quality.colorForQuality().CGColor
//                itemQualityLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
//                itemQualityLabel.clipsToBounds = true
//                
//                let sizeOfItemQualityLabel = NSString(string: itemQualityLabel.text!).sizeWithAttributes([NSFontAttributeName: itemQualityLabel.font])
//                
//                itemQualityLabel.frame = CGRectMake(itemImageViewMask.frame.origin.x, itemNameLabel.frame.origin.y + itemNameLabel.frame.size.height + 5.0, sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 8.0)
//                
//                if let categoryLabel = itemCategoryLabel {
//                    
//                    if item.category != Category.None && item.category != Category.Normal {
//                        
//                        itemQualityLabel.frame = CGRectMake(categoryLabel.frame.origin.x + categoryLabel.frame.size.width + 4.0, itemNameLabel.frame.origin.y + itemNameLabel.frame.size.height + 5.0, sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 8.0)
//                    }
//                    
//                }
//                
//                itemQualityLabel.layer.cornerRadius = 4.0
//                contentView.addSubview(itemQualityLabel)
//            }
//            
//        } else {
//            print("OOOPS")
//        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Item Image
        let imageViewMaskHeight = itemImageViewMask.autoSetDimension(.Height, toSize: 315)
        itemImageViewMask.autoPinEdge(.Left, toEdge: .Left, ofView: self.contentView)
        itemImageViewMask.autoPinEdge(.Top, toEdge: .Top, ofView: self.contentView)
        itemImageViewMask.autoPinEdge(.Right, toEdge: .Right, ofView: self.contentView)
        
        // Resize images to fit
        if item.weaponType == WeaponType.SCAR20 || item.weaponType == WeaponType.G3SG1 {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.contentView.frame.size.width/1.05, imageViewMaskHeight.constant/1.05))
        } else if item.type == Type.Container || item.type == Type.Gift || item.type == Type.MusicKit || item.type == Type.Pass || item.type == Type.Tag || item.type == Type.Pistol || item.type == Type.SMG {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.contentView.frame.size.width/1.3, imageViewMaskHeight.constant/1.3))
        } else if item.type == Type.Key {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.contentView.frame.size.width/1.5, imageViewMaskHeight.constant/1.5))
        } else if item.type == Type.Rifle {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.contentView.frame.size.width/1.4, imageViewMaskHeight.constant/1.1))
        } else if item.type == Type.Sticker {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.contentView.frame.size.width/1.1, imageViewMaskHeight.constant/1.4))
        } else if item.type == Type.SniperRifle {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.contentView.frame.size.width/0.97, imageViewMaskHeight.constant/0.97))
        } else if item.type == Type.Knife {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.contentView.frame.size.width/1.2, imageViewMaskHeight.constant/1.2))
        }
        
        itemImageView.autoAlignAxis(.Vertical, toSameAxisOfView: itemImageViewMask, withOffset: item.type == Type.SniperRifle ? -8 : 0)
        itemImageView.autoAlignAxis(.Horizontal, toSameAxisOfView: itemImageViewMask)
        
        //Item Price
        let sizeOfItemPriceLabel = NSString(string: itemPriceLabel.text!).sizeWithAttributes([NSFontAttributeName: itemPriceLabel.font])
        
        itemPriceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemImageViewMask, withOffset: 10)
        itemPriceLabel.autoPinEdge(.Left, toEdge: .Left, ofView: self.contentView, withOffset: 15)
        itemPriceLabel.autoPinEdge(.Right, toEdge: .Right, ofView: self.contentView, withOffset: -15)
        itemPriceLabel.autoSetDimension(.Height, toSize: sizeOfItemPriceLabel.height)

        //Item Name
        let sizeOfItemNameLabel = NSString(string: itemNameLabel.text!).sizeWithAttributes([NSFontAttributeName: itemNameLabel.font])
        itemNameLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemPriceLabel, withOffset: 5)
        itemNameLabel.autoPinEdge(.Left, toEdge: .Left, ofView: self.contentView, withOffset: 15)
        itemNameLabel.autoPinEdge(.Right, toEdge: .Right, ofView: self.contentView, withOffset: -15)
        itemNameLabel.autoSetDimension(.Height, toSize: sizeOfItemNameLabel.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
