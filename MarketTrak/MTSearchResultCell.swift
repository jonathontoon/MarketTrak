//
//  MTSearchResultswift
//  
//
//  Created by Jonathon Toon on 10/10/15.
//
//

import UIKit
import SDWebImage
import PureLayout
import DeviceKit

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
            mask.path = path.CGPath
        layer.mask = mask
    }
}

class MTSearchResultCell: UICollectionViewCell {
    
    private let isSmallerDevice = Device().isOneOf([.iPodTouch5, .iPodTouch6, .iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE, .Simulator(.iPodTouch5), .Simulator(.iPodTouch6), .Simulator(.iPhone4), .Simulator(.iPhone4s), .Simulator(.iPhone5), .Simulator(.iPhone5c), .Simulator(.iPhone5s), .Simulator(.iPhoneSE)]) || Device().isPad
    
    var item: MTItem!
    
    let downloadManager = SDWebImageManager()
    var imageOperation: SDWebImageOperation?
    
    var containerView: UIView!
    
    var itemImageViewMask: UIImageView!
    
    var itemImageView: UIImageView!

    var itemPriceLabel: UILabel!
    var itemNameLabel: UILabel!
    var itemMetaLabel: UILabel!
    var itemCategoryLabel: UILabel!
    var itemQualityLabel: UILabel!

    var itemSeparator: UIView!
    
    var itemAddToWatchlistLabel: UILabel!
    var itemAddedToWatchlistIcon: UIImageView!
    
    func renderCellContentForItem(item: MTItem, indexPath: NSIndexPath) {
        self.item = item
        
        containerView = UIView.newAutoLayoutView()
        containerView.backgroundColor = UIColor.searchResultCellColor()
        containerView.layer.cornerRadius = 4.0
        containerView.clipsToBounds = true
        containerView.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.05).CGColor
        containerView.layer.borderWidth = (1/UIScreen.mainScreen().scale) * 1.0
        containerView.layer.masksToBounds = true
        contentView.addSubview(containerView)
        containerView.autoPinEdge(.Top, toEdge: .Top, ofView: contentView, withOffset: 4.0)
        containerView.autoPinEdge(.Left, toEdge: .Left, ofView: contentView, withOffset: indexPath.row % 2 == 0 ? 8.0 : 4.0)
        containerView.autoPinEdge(.Right, toEdge: .Right, ofView: contentView, withOffset: indexPath.row % 2 == 0 ? -4.0 : -8.0)
        containerView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: contentView, withOffset: -4.0)
        
        itemImageViewMask = UIImageView.newAutoLayoutView()
        itemImageViewMask.backgroundColor = UIColor.clearColor()
        itemImageViewMask.image = UIImage(named: "background_gradient")
        containerView.addSubview(itemImageViewMask)
        itemImageViewMask.autoPinEdge(.Top, toEdge: .Top, ofView: containerView)
        itemImageViewMask.autoPinEdge(.Left, toEdge: .Left, ofView: containerView)
        itemImageViewMask.autoConstrainAttribute(.Width, toAttribute: .Width, ofView: containerView)
        itemImageViewMask.autoConstrainAttribute(.Height, toAttribute: .Width, ofView: containerView)
        
        // Item Image
        itemImageView = UIImageView.newAutoLayoutView()
        itemImageView.backgroundColor = UIColor.clearColor()
        itemImageView.layer.cornerRadius = 2.0
        itemImageView.contentMode = .ScaleAspectFit
        itemImageViewMask.addSubview(itemImageView)

        var multiplier: CGFloat = 1.0
        
        // Resize images to fit
        if item.weaponType == WeaponType.SCAR20 || item.weaponType == WeaponType.G3SG1 {
            multiplier = 1.1
        } else if item.type == Type.Container || item.type == Type.Gift || item.type == Type.MusicKit || item.type == Type.Pass || item.type == Type.Tag {
            multiplier = 0.7
        } else if item.type == Type.Key {
            multiplier = 0.73
        } else if item.type == Type.Pistol || item.type == Type.SMG {
            multiplier = 0.8
        } else if item.type == Type.Rifle {
            multiplier = 0.84
        } else if item.type == Type.Sticker {
            multiplier = 0.72
        } else if item.type == Type.SniperRifle {
            multiplier = 0.93
        } else if item.type == Type.Knife {
            multiplier = 1.0
        } else if item.type == Type.Shotgun {
            multiplier = 0.9
        }
        
        itemImageView.autoConstrainAttribute(.Width, toAttribute: .Width, ofView: itemImageViewMask, withMultiplier: multiplier)
        itemImageView.autoConstrainAttribute(.Height, toAttribute: .Height, ofView: itemImageViewMask, withMultiplier: multiplier)
        itemImageView.autoAlignAxis(.Vertical, toSameAxisOfView: itemImageViewMask, withOffset: item.type == Type.SniperRifle ? -6.0 : 0.0)
        itemImageView.autoAlignAxis(.Horizontal, toSameAxisOfView: itemImageViewMask)
 
        imageOperation = downloadManager.downloadImageWithURL(
            item.imageURL!,
            options: SDWebImageOptions.HighPriority,
            progress: nil,
            completed: {
                
                (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, finished: Bool, imageURL: NSURL!) in
                
                self.itemImageView.image = image
                self.setNeedsLayout()
                
                let transition = CATransition()
                transition.duration = 0.25
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionFade
                
                self.itemImageView.layer.addAnimation(transition, forKey: nil)
        })
        
        // Item Price
        // Revisit this for selectable currencies
        let priceFormatter = NSNumberFormatter()
        priceFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        priceFormatter.maximumFractionDigits = 2
        priceFormatter.minimumFractionDigits = 2
        priceFormatter.minimumIntegerDigits = 1
        
        itemPriceLabel = UILabel.newAutoLayoutView()
        itemPriceLabel.text = "$" + priceFormatter.stringFromNumber(item.price!)! + " USD"
        itemPriceLabel.textColor = UIColor.priceTintColor()
        itemPriceLabel.font = UIFont.systemFontOfSize(11.0, weight: UIFontWeightMedium)
        containerView.addSubview(itemPriceLabel)
        
        itemPriceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemImageViewMask, withOffset: 9.0)
        itemPriceLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8.0)
        itemPriceLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: 8.0)
        
        // Skin Name
        itemNameLabel = UILabel.newAutoLayoutView()
        itemNameLabel.text = item.name!
        
        if item.weaponType != nil && item.weaponType != WeaponType.None  {
            itemNameLabel.text = item.weaponType!.stringDescription() + " | " + item.name!
        } else {
            if item.type == Type.MusicKit {
                if item.artistName != nil {
                    itemNameLabel.text = item.name! + " | " + item.artistName!
                }
            } else if item.type == Type.Sticker {
                itemNameLabel.text = item.type.stringDescription() + " | " + item.name!
            }else {
                itemNameLabel.text = item.name!
            }
        }
        
        if item.name! == "★" {
            itemNameLabel.text = "★ " + item.weaponType!.stringDescription()
        }
        
        itemNameLabel.textColor = UIColor.whiteColor()
        itemNameLabel.font = UIFont.systemFontOfSize(12.0, weight: UIFontWeightMedium)
        containerView.addSubview(itemNameLabel)
        
        itemNameLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemPriceLabel, withOffset: 1.0)
        itemNameLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8.0)
        itemNameLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8.0)
        
        // Skin Meta
        let itemFormatter = NSNumberFormatter()
        itemFormatter.numberStyle = .DecimalStyle
        itemFormatter.maximumFractionDigits = 0
        itemFormatter.minimumFractionDigits = 0
        itemFormatter.minimumIntegerDigits = 1
        
        itemMetaLabel = UILabel.newAutoLayoutView()
        
        if item.type == Type.MusicKit {
            itemMetaLabel.text = item.artistName!.uppercaseString
        } else if item.type == Type.Container {
            itemMetaLabel.text = (String(item.items!.count) + " items • 1 of " + itemFormatter.stringFromNumber(item.quantity!)!).uppercaseString
        } else {
            if item.exterior != nil && item.exterior! != .None && item.exterior! != Exterior.NotPainted {
                itemMetaLabel.text = (item.exterior!.stringDescription() + " • 1 of " + itemFormatter.stringFromNumber(item.quantity!)!).uppercaseString
            } else {
                itemMetaLabel.text = ("1 of " + itemFormatter.stringFromNumber(item.quantity!)!).uppercaseString
            }
        }
        
        itemMetaLabel.textColor = UIColor.metaTextColor()
        itemMetaLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightRegular)
        
        containerView.addSubview(itemMetaLabel)
        itemMetaLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemNameLabel, withOffset: 3.0)
        itemMetaLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8.0)
        itemMetaLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8.0)
        
        
        // Category Tag
        if let category = item.category {
            
            if category != Category.None && category != Category.Normal {
                
                itemCategoryLabel = UILabel.newAutoLayoutView()
                itemCategoryLabel.font = UIFont.systemFontOfSize(8.0, weight: UIFontWeightBold)
                
                if isSmallerDevice == true {
                    itemCategoryLabel.font = UIFont.systemFontOfSize(7.0, weight: UIFontWeightBold)
                }
                
                itemCategoryLabel.text = category.stringDescription()
                itemCategoryLabel.textColor = category.colorForCategory()
                itemCategoryLabel.textAlignment = NSTextAlignment.Center
                itemCategoryLabel.layer.borderColor = category.colorForCategory().CGColor
                itemCategoryLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                itemCategoryLabel.clipsToBounds = true
                
                let sizeOfItemCategoryLabel = NSString(string: itemCategoryLabel.text!).sizeWithAttributes([NSFontAttributeName: itemCategoryLabel.font])
                
                itemCategoryLabel.layer.cornerRadius = 3.0
                containerView.addSubview(itemCategoryLabel)
                
                itemCategoryLabel.autoSetDimensionsToSize(CGSizeMake(sizeOfItemCategoryLabel.width + 12.0, sizeOfItemCategoryLabel.height + 8.0))
                itemCategoryLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemMetaLabel, withOffset: 6.0)
                itemCategoryLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8.0)
            }
        }
        
        // Quality Tag
        if let quality = item.quality {
            
            if quality != Quality.None {
                
                itemQualityLabel = UILabel.newAutoLayoutView()
                itemQualityLabel.text = quality.stringDescription()
                itemQualityLabel.textColor = quality.colorForQuality()
                
                itemQualityLabel.font = UIFont.systemFontOfSize(8.0, weight: UIFontWeightBold)
                
                if isSmallerDevice == true {
                    itemQualityLabel.font = UIFont.systemFontOfSize(7.0, weight: UIFontWeightBold)
                }
                
                itemQualityLabel.textAlignment = NSTextAlignment.Center
                itemQualityLabel.layer.borderColor = quality.colorForQuality().CGColor
                itemQualityLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                itemQualityLabel.clipsToBounds = true
                
                let sizeOfItemQualityLabel = NSString(string: itemQualityLabel.text!).sizeWithAttributes([NSFontAttributeName: itemQualityLabel.font])
                
                itemQualityLabel.layer.cornerRadius = 3.0
                containerView.addSubview(itemQualityLabel)
                
                itemQualityLabel.autoSetDimensionsToSize(CGSizeMake(sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 8.0))
                itemQualityLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemMetaLabel, withOffset: 6.0)
                
                var viewTopPin: UIView! = containerView
                var offsetAmount: CGFloat! = 8.0
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
        
        itemSeparator = UIView.newAutoLayoutView()
        itemSeparator.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        containerView.addSubview(itemSeparator)
        
        itemSeparator.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemQualityLabel, withOffset: 10)
        itemSeparator.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8)
        itemSeparator.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8)
        itemSeparator.autoSetDimension(.Height, toSize: 1/UIScreen.mainScreen().scale)
        
        itemAddToWatchlistLabel = UILabel.newAutoLayoutView()
        itemAddToWatchlistLabel.font = UIFont.systemFontOfSize(11, weight: UIFontWeightMedium)
        itemAddToWatchlistLabel.textColor = UIColor.appTintColor()
        itemAddToWatchlistLabel.text = "Add To Watchlist"
        containerView.addSubview(itemAddToWatchlistLabel)
        
        itemAddToWatchlistLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemSeparator)
        itemAddToWatchlistLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8)
        itemAddToWatchlistLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8)
        itemAddToWatchlistLabel.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: containerView)
        
        itemAddedToWatchlistIcon = UIImageView.newAutoLayoutView()
        itemAddedToWatchlistIcon.image = UIImage(named: "add_watchlist_icon")?.imageWithRenderingMode(.AlwaysTemplate)
        itemAddedToWatchlistIcon.tintColor = UIColor.appTintColor()
        containerView.addSubview(itemAddedToWatchlistIcon)
        
        itemAddedToWatchlistIcon.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemSeparator, withOffset: 9)
        itemAddedToWatchlistIcon.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8)
        itemAddedToWatchlistIcon.autoAlignAxis(.Horizontal, toSameAxisOfView: itemAddToWatchlistLabel)
        itemAddedToWatchlistIcon.autoSetDimensionsToSize(CGSizeMake(9, 9))
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageOperation?.cancel()
        imageOperation = nil
        
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
    }
}
