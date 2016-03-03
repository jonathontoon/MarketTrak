//
//  MTSearchResultswift
//  
//
//  Created by Jonathon Toon on 10/10/15.
//
//

import UIKit
import Material
import SDWebImage
import MGSwipeTableCell

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
            mask.path = path.CGPath
        layer.mask = mask
    }
}

class MTSearchResultCell: UICollectionViewCell {

    var imageOperation: SDWebImageOperation?
    
    var itemImageViewMask: UIImageView!
    var itemImageView: UIImageView!
    
    var itemPriceLabel: UILabel!
    var itemNameLabel: UILabel!
    var itemMetaLabel: UILabel!
    var itemCategoryLabel: UILabel!
    var itemQualityLabel: UILabel!
 
//    var bottomSeparator: UIView!
//    var leftSeparator: UIView!

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

    func renderCellContentForItem(item: MTListedItem, indexPath: NSIndexPath, resultCount: Int) {
        
        let containerFrame = indexPath.row % 2 == 0 ? CGRectMake(10.0, 10.0, contentView.frame.size.width - 15.0, contentView.frame.size.height - 10.0) : CGRectMake(5.0, 10.0, contentView.frame.size.width - 15.0, contentView.frame.size.height - 10.0)
        let containerView = UIView(frame: containerFrame)
            containerView.backgroundColor = UIColor.searchResultCellColor()
            containerView.layer.cornerRadius = 6.0
            containerView.clipsToBounds = true
            containerView.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.05).CGColor
            containerView.layer.borderWidth = (1/UIScreen.mainScreen().scale) * 1.0
            containerView.layer.masksToBounds = true
        
        contentView.addSubview(containerView)

        itemImageViewMask = UIImageView(frame: CGRectMake(0.0, 0.0, containerView.frame.width, containerView.frame.width * 0.84))
        itemImageViewMask.image = UIImage(named: "gradient_image_small")
        containerView.addSubview(itemImageViewMask)
        
        // Item Image
        itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, itemImageViewMask.frame.size.width, itemImageViewMask.frame.size.height))
        
        // Resize images to fit
        if item.weaponType == WeaponType.SCAR20 || item.weaponType == WeaponType.G3SG1 {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.05), round(itemImageView.frame.size.height/1.05)))
        } else if item.type == Type.Container || item.type == Type.Gift || item.type == Type.MusicKit || item.type == Type.Pass || item.type == Type.Tag {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.3), round(itemImageView.frame.size.height/1.3)))
        } else if item.type == Type.Key {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.5), round(itemImageView.frame.size.height/1.5)))
        } else if item.type == Type.Pistol || item.type == Type.SMG {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.3), round(itemImageView.frame.size.height/1.3)))
        } else if item.type == Type.Rifle {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.1), round(itemImageView.frame.size.height/1.1)))
        } else if item.type == Type.Sticker {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.4), round(itemImageView.frame.size.height/1.4)))
        } else if item.type == Type.SniperRifle {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/0.97), round(itemImageView.frame.size.height/0.97)))
        } else if item.type == Type.Knife {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.2), round(itemImageView.frame.size.height/1.2)))
        }
        
        itemImageView.backgroundColor = UIColor.clearColor()
        itemImageView.layer.cornerRadius = 2.0
        itemImageView.center = item.type == Type.SniperRifle ? CGPointMake((itemImageViewMask.frame.size.width/2) - 8.0, itemImageViewMask.frame.size.height/2)
 : CGPointMake(itemImageViewMask.frame.size.width/2, itemImageViewMask.frame.size.height/2)
        
        itemImageView.contentMode = .ScaleAspectFit
        itemImageViewMask.addSubview(itemImageView)
        
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
        itemPriceLabel = UILabel(frame: CGRectZero)
        
        // Revisit this for selectable currencies
        let formatter = NSNumberFormatter()
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            formatter.minimumIntegerDigits = 1
        
        itemPriceLabel.text = "$" + formatter.stringFromNumber(item.currentPrice!)! + " USD"
        itemPriceLabel.textColor = UIColor.priceTintColor()
        itemPriceLabel.font = UIFont.systemFontOfSize(11.0, weight: UIFontWeightMedium)

        let sizeOfItemPriceLabel = NSString(string: itemPriceLabel.text!).sizeWithAttributes([NSFontAttributeName: itemPriceLabel.font])
        itemPriceLabel.frame = CGRectMake(8.0, itemImageViewMask.frame.origin.y + itemImageViewMask.frame.size.height + 7.5, sizeOfItemPriceLabel.width, sizeOfItemPriceLabel.height)
        containerView.addSubview(itemPriceLabel)

        // Skin Name
        itemNameLabel = UILabel(frame: CGRectZero)
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

        let sizeOfItemNameLabel = NSString(string: itemNameLabel.text!).sizeWithAttributes([NSFontAttributeName: itemNameLabel.font])
        itemNameLabel.frame = CGRectMake(itemPriceLabel.frame.origin.x, itemPriceLabel.frame.origin.y + itemPriceLabel.frame.size.height + 2.0, itemImageViewMask.frame.size.width - (itemPriceLabel.frame.origin.x * 2), sizeOfItemNameLabel.height)
        containerView.addSubview(itemNameLabel)
        
        // Skin Meta
        itemMetaLabel = UILabel()
        
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
        
        let sizeOfItemMetaLabel = NSString(string: itemMetaLabel.text!).sizeWithAttributes([NSFontAttributeName: itemMetaLabel.font])
        itemMetaLabel.frame = CGRectMake(itemPriceLabel.frame.origin.x, itemNameLabel.frame.origin.y + itemNameLabel.frame.size.height + 2.0, itemImageViewMask.frame.size.width - (itemPriceLabel.frame.origin.x * 2), sizeOfItemMetaLabel.height)
        containerView.addSubview(itemMetaLabel)
        
        // Category Tag
        if let category = item.category {
            
            if category != Category.None && category != Category.Normal {
                
                itemCategoryLabel = UILabel(frame: CGRectZero)
                itemCategoryLabel.font = UIFont.systemFontOfSize(8.0, weight: UIFontWeightBold)
                itemCategoryLabel.text = category.stringDescription()
                itemCategoryLabel.textColor = category.colorForCategory()
                itemCategoryLabel.textAlignment = NSTextAlignment.Center
                itemCategoryLabel.layer.borderColor = category.colorForCategory().CGColor
                itemCategoryLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                itemCategoryLabel.clipsToBounds = true
                
                let sizeOfItemCategoryLabel = NSString(string: itemCategoryLabel.text!).sizeWithAttributes([NSFontAttributeName: itemCategoryLabel.font])
                
                itemCategoryLabel.frame = CGRectMake(itemPriceLabel.frame.origin.x, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 6.0, sizeOfItemCategoryLabel.width + 12.0, sizeOfItemCategoryLabel.height + 8.0)
                itemCategoryLabel.layer.cornerRadius = 3.0
                
                containerView.addSubview(itemCategoryLabel)
            }
        }
        
        // Quality Tag
        if let quality = item.quality {
            
            if quality != Quality.None {
            
                itemQualityLabel = UILabel(frame: CGRectZero)
                itemQualityLabel.text = quality.stringDescription()
                itemQualityLabel.textColor = quality.colorForQuality()
                itemQualityLabel.font = UIFont.systemFontOfSize(8.0, weight: UIFontWeightBold)
                itemQualityLabel.textAlignment = NSTextAlignment.Center
                itemQualityLabel.layer.borderColor = quality.colorForQuality().CGColor
                itemQualityLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                itemQualityLabel.clipsToBounds = true
                
                let sizeOfItemQualityLabel = NSString(string: itemQualityLabel.text!).sizeWithAttributes([NSFontAttributeName: itemQualityLabel.font])
                
                itemQualityLabel.frame = CGRectMake(itemPriceLabel.frame.origin.x, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 6.0, sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 8.0)
                
                if let categoryLabel = itemCategoryLabel {
                    
                    if item.category != Category.None && item.category != Category.Normal {
                    
                        itemQualityLabel.frame = CGRectMake(categoryLabel.frame.origin.x + categoryLabel.frame.size.width + 4.0, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 6.0, sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 8.0)
                    }
                    
                }
                
                itemQualityLabel.layer.cornerRadius = 3.0
                containerView.addSubview(itemQualityLabel)
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
