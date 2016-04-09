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

    var item: MTItem!
    
    var imageOperation: SDWebImageOperation?
    
    var containerView: UIView!
    
    var itemImageViewMask: UIImageView!
    
    var itemImageView: UIImageView!
    
    var itemPriceLabel: UILabel!
    var itemNameLabel: UILabel!
    var itemMetaLabel: UILabel!
    var itemCategoryLabel: UILabel!
    var itemQualityLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

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
        //itemImageViewMask.image = UIImage(named: "gradient_image_small")
        itemImageViewMask.backgroundColor = UIColor(rgba: "#D8D8D8")
        containerView.addSubview(itemImageViewMask)
        itemImageViewMask.autoPinEdge(.Top, toEdge: .Top, ofView: containerView)
        itemImageViewMask.autoPinEdge(.Left, toEdge: .Left, ofView: containerView)
        itemImageViewMask.autoPinEdge(.Right, toEdge: .Right, ofView: containerView)
        itemImageViewMask.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: containerView, withOffset: -86.0)
        
        // Item Image
        itemImageView = UIImageView.newAutoLayoutView()
        itemImageView.backgroundColor = UIColor.clearColor()
        itemImageView.layer.cornerRadius = 2.0
        itemImageView.contentMode = .ScaleAspectFit
        itemImageViewMask.addSubview(itemImageView)

        var multiplier: CGFloat = 0.0
        
        // Resize images to fit
        if item.weaponType == WeaponType.SCAR20 || item.weaponType == WeaponType.G3SG1 {
            multiplier = 1.1
        } else if item.type == Type.Container || item.type == Type.Gift || item.type == Type.MusicKit || item.type == Type.Pass || item.type == Type.Tag {
            multiplier = 0.75
        } else if item.type == Type.Key {
            multiplier = 0.73
        } else if item.type == Type.Pistol || item.type == Type.SMG {
            multiplier = 0.9
        } else if item.type == Type.Rifle {
            multiplier = 0.9
        } else if item.type == Type.Sticker {
            multiplier = 0.72
        } else if item.type == Type.SniperRifle {
            multiplier = 1.1
        } else if item.type == Type.Knife {
            multiplier = 1.0
        }
        
        itemImageView.autoConstrainAttribute(.Width, toAttribute: .Width, ofView: itemImageViewMask, withMultiplier: multiplier)
        itemImageView.autoConstrainAttribute(.Height, toAttribute: .Height, ofView: itemImageViewMask, withMultiplier: multiplier)
        itemImageView.autoAlignAxis(.Vertical, toSameAxisOfView: itemImageViewMask, withOffset: item.type == Type.SniperRifle ? -15.0 : 0.0)
        itemImageView.autoAlignAxis(.Horizontal, toSameAxisOfView: itemImageViewMask)

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
                    itemNameLabel.text = item.name! + " " + item.artistName!
                }
            } else if item.type == Type.Sticker {
                itemNameLabel.text = item.type.stringDescription() + " | " + item.name!
            }else {
               itemNameLabel.text = item.name!
            }
        }
        
        if itemNameLabel.text == "★" {
            itemNameLabel.text = "★ " + item.weaponType!.stringDescription()
        }
        
        itemNameLabel.textColor = UIColor.whiteColor()
        itemNameLabel.font = UIFont.systemFontOfSize(13.0, weight: UIFontWeightMedium)
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
        itemMetaLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemNameLabel, withOffset: 2.0)
        itemMetaLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8.0)
        itemMetaLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8.0)
        
        
        // Category Tag
        if let category = item.category {
            
            if category != Category.None && category != Category.Normal {
                
                itemCategoryLabel = UILabel.newAutoLayoutView()
                
                itemCategoryLabel.font = UIFont.systemFontOfSize(8.0, weight: UIFontWeightBold)
                
                if Device().isOneOf([.iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s]) {
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
                
                if Device().isOneOf([.iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s]) {
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
            
        } else {
            print("OOOPS")
            dump(item)
        }
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
