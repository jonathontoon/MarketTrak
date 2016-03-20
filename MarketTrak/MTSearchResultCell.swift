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
    var itemImageViewMaskWidthConstraint: NSLayoutConstraint!
    var itemImageViewMaskHeightConstraint: NSLayoutConstraint!
    
    var itemImageView: UIImageView!
    var itemImageViewSizeConstraints: [NSLayoutConstraint]!
    
    var itemPriceLabel: UILabel!
    var itemNameLabel: UILabel!
    var itemMetaLabel: UILabel!
    var itemCategoryLabel: UILabel!
    var itemQualityLabel: UILabel!
 
    let bottomSeparator = UIView.newAutoLayoutView()
    let leftSeparator = UIView.newAutoLayoutView()

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

    func renderCellContentForItem(item: MTItem, indexPath: NSIndexPath, resultCount: Int) {
        self.item = item
        
        containerView = UIView.newAutoLayoutView()
        containerView.backgroundColor = UIColor.searchResultCellColor()
        containerView.layer.cornerRadius = 6.0
        containerView.clipsToBounds = true
        containerView.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.05).CGColor
        containerView.layer.borderWidth = (1/UIScreen.mainScreen().scale) * 1.0
        containerView.layer.masksToBounds = true
        contentView.addSubview(containerView)
        containerView.autoPinEdge(.Top, toEdge: .Top, ofView: contentView, withOffset: 5.0)
        containerView.autoPinEdge(.Left, toEdge: .Left, ofView: contentView, withOffset: indexPath.row % 2 == 0 ? 10.0 : 5.0)
        containerView.autoPinEdge(.Right, toEdge: .Right, ofView: contentView, withOffset: indexPath.row % 2 == 0 ? -5.0 : -10.0)
        containerView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: contentView, withOffset: -5.0)
        
        itemImageViewMask = UIImageView.newAutoLayoutView()
        itemImageViewMask.image = UIImage(named: "gradient_image_small")
        itemImageViewMask.backgroundColor = UIColor.searchResultCellColor()
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
            multiplier = 0.8
        } else if item.type == Type.Key {
            multiplier = 0.8
        } else if item.type == Type.Pistol || item.type == Type.SMG {
            multiplier = 0.95
        } else if item.type == Type.Rifle {
            multiplier = 0.9
        } else if item.type == Type.Sticker {
            multiplier = 0.9
        } else if item.type == Type.SniperRifle {
            multiplier = 1.1
        } else if item.type == Type.Knife {
            multiplier = 1.0
        }
        
        itemImageView.autoConstrainAttribute(.Width, toAttribute: .Width, ofView: itemImageViewMask, withMultiplier: multiplier)
        itemImageView.autoConstrainAttribute(.Height, toAttribute: .Height, ofView: itemImageViewMask, withMultiplier: multiplier)
        itemImageView.autoAlignAxis(.Vertical, toSameAxisOfView: itemImageViewMask, withOffset: item.type == Type.SniperRifle ? -15.0 : 0.0)
        itemImageView.autoAlignAxis(.Horizontal, toSameAxisOfView: itemImageViewMask)
        
//        itemImageView.center = item.type == Type.SniperRifle ? CGPointMake((itemImageViewMask.frame.size.width/2) - 8.0, itemImageViewMask.frame.size.height/2)
//            : CGPointMake(itemImageViewMask.frame.size.width/2, itemImageViewMask.frame.size.height/2)
//        
//        if item.collection! != "" && item.weaponType != nil && item.weaponType != .None && item.weaponType!.stringDescription() != "" {
//            let itemCollectionBadgeImage = UIImage(named: item.collection!)
//            let itemCollectionBadgeView = UIImageView(image: itemCollectionBadgeImage)
//                itemCollectionBadgeView.frame = CGRectMake(6.0, itemImageViewMask.frame.size.height - 45.0, 40.0, 40.0)
//                itemCollectionBadgeView.contentMode = .ScaleAspectFit
//            itemImageViewMask.addSubview(itemCollectionBadgeView)
//        }
        
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
        let formatter = NSNumberFormatter()
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            formatter.minimumIntegerDigits = 1
        itemPriceLabel = UILabel.newAutoLayoutView()
        itemPriceLabel.text = "$" + formatter.stringFromNumber(item.price!)! + " USD"
        itemPriceLabel.textColor = UIColor.priceTintColor()
        itemPriceLabel.font = UIFont.systemFontOfSize(11.0, weight: UIFontWeightMedium)
        containerView.addSubview(itemPriceLabel)

        let sizeOfItemPriceLabel = NSString(string: itemPriceLabel.text!).sizeWithAttributes([NSFontAttributeName: itemPriceLabel.font])
        itemPriceLabel.autoSetDimensionsToSize(CGSizeMake(sizeOfItemPriceLabel.width, sizeOfItemPriceLabel.height))
        itemPriceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemImageViewMask, withOffset: 9.0)
        itemPriceLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 10.0)
        itemPriceLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: 10.0)

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
            } else {
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
        itemNameLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 10.0)
        itemNameLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -10.0)
        
        // Skin Meta
        itemMetaLabel = UILabel.newAutoLayoutView()
        if item.type == Type.MusicKit {
            itemMetaLabel.text = item.artistName!.uppercaseString
        } else if item.type == Type.Container {
            itemMetaLabel.text = (String(item.items!.count) + " items • 1 of " + item.quantity!).uppercaseString
        } else if item.type == Type.Sticker {
            if item.stickerCollection != nil && item.stickerCollection != "" {
                itemMetaLabel.text = (item.type!.stringDescription() + " • " + item.stickerCollection!).uppercaseString
            }
        } else {
            if item.exterior != nil && item.exterior! != .None && item.exterior! != Exterior.NotPainted {
                itemMetaLabel.text = (item.exterior!.stringDescription() + " • 1 of " + item.quantity!).uppercaseString
            } else {
                itemMetaLabel.text = ("1 of " + item.quantity!).uppercaseString
            }
        }
        
        itemMetaLabel.textColor = UIColor.metaTextColor()
        itemMetaLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightRegular)
        
        containerView.addSubview(itemMetaLabel)
        itemMetaLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemNameLabel, withOffset: 2.0)
        itemMetaLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 10.0)
        itemMetaLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -10.0)
        
        
        // Category Tag
        if let category = item.category {
            
            if category != Category.None && category != Category.Normal {
                
                itemCategoryLabel = UILabel.newAutoLayoutView()
                itemCategoryLabel.font = UIFont.systemFontOfSize(8.0, weight: UIFontWeightBold)
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
                itemCategoryLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemMetaLabel, withOffset: 5.0)
                itemCategoryLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 10.0)
            }
        }
        
        // Quality Tag
        if let quality = item.quality {
            
            if quality != Quality.None {
            
                itemQualityLabel = UILabel.newAutoLayoutView()
                itemQualityLabel.text = quality.stringDescription()
                itemQualityLabel.textColor = quality.colorForQuality()
                itemQualityLabel.font = UIFont.systemFontOfSize(8.0, weight: UIFontWeightBold)
                itemQualityLabel.textAlignment = NSTextAlignment.Center
                itemQualityLabel.layer.borderColor = quality.colorForQuality().CGColor
                itemQualityLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                itemQualityLabel.clipsToBounds = true
                
                let sizeOfItemQualityLabel = NSString(string: itemQualityLabel.text!).sizeWithAttributes([NSFontAttributeName: itemQualityLabel.font])

                itemQualityLabel.layer.cornerRadius = 3.0
                containerView.addSubview(itemQualityLabel)
                
                itemQualityLabel.autoSetDimensionsToSize(CGSizeMake(sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 8.0))
                itemQualityLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemMetaLabel, withOffset: 5.0)
                
                var viewTopPin: UIView! = containerView
                var offsetAmount: CGFloat! = 10.0
                var toViewEdge: ALEdge! = .Left
                
                if let categoryLabel = itemCategoryLabel {
                    if item.category != Category.None && item.category != Category.Normal {
                        viewTopPin = categoryLabel
                        offsetAmount = 8.0
                        toViewEdge = .Right
                    }
                }
                
                itemQualityLabel.autoPinEdge(.Left, toEdge: toViewEdge, ofView: viewTopPin, withOffset: offsetAmount)
                

            }
            
        } else {
            print("OOOPS")
            dump(item)
        }
        
//        bottomSeparator = UIView(frame: CGRectMake(0.0, contentView.frame.size.height - (2.0 / UIScreen.mainScreen().scale), contentView.frame.size.width, 1.0 / UIScreen.mainScreen().scale))
//        bottomSeparator.backgroundColor = UIColor.tableViewSeparatorColor()
//        contentView.addSubview(bottomSeparator)
//        
//        if indexPath.row % 2 == 0 {
//            leftSeparator = UIView(frame: CGRectMake(contentView.frame.size.width - (1.0 / UIScreen.mainScreen().scale), 0.0, 1.0 / UIScreen.mainScreen().scale, contentView.frame.size.height))
//            leftSeparator.backgroundColor = UIColor.tableViewSeparatorColor()
//            contentView.addSubview(leftSeparator)
//        }
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
