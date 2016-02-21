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

class MTSearchResultCell: UICollectionViewCell {

    var imageOperation: SDWebImageOperation?
    
    var itemImageViewMask: UIImageView!
    var itemImageView: UIImageView!
    
    var itemPriceLabel: UILabel!
    var itemNameLabel: UILabel!
    var itemMetaLabel: UILabel!
    var itemCategoryLabel: UILabel!
    var itemQualityLabel: UILabel!
 
    var bottomSeparator: UIView!
    var leftSeparator: UIView!

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
        
        contentView.clipsToBounds = true
        
        let pulseView = MaterialPulseView(frame: contentView.frame)
            pulseView.backgroundColor = UIColor.tableViewCellColor()
            pulseView.pulseColorOpacity = 0.5
            pulseView.pulseColor = UIColor.tableViewSeparatorColor()
            pulseView.shape = .Square
        contentView.addSubview(pulseView)
        
        itemImageViewMask = UIImageView(frame: CGRectMake(10.0, 10.0, contentView.frame.width - 20.0, contentView.frame.height * 0.60))
        itemImageViewMask.image = UIImage(named: "gradientImage")
        itemImageViewMask.layer.cornerRadius = 2.0
        itemImageViewMask.clipsToBounds = true
        contentView.addSubview(itemImageViewMask)
        
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
        itemPriceLabel.frame = CGRectMake(10.0, itemImageViewMask.frame.origin.y + itemImageViewMask.frame.size.height + 10.0, sizeOfItemPriceLabel.width, sizeOfItemPriceLabel.height)
        contentView.addSubview(itemPriceLabel)

        // Skin Name
        itemNameLabel = UILabel(frame: CGRectZero)
        itemNameLabel.text = item.name!
        
        if item.exterior != nil && item.exterior != Exterior.None && item.exterior != Exterior.NotPainted  {
            itemNameLabel.text = item.name! + " (" + item.exterior!.stringDescription() + ")"
        } else {
            if item.type == Type.MusicKit {
                if item.artistName != nil {
                    itemNameLabel.text = item.name! + " " + item.artistName!
                }
            } else {
               itemNameLabel.text = item.name!
            }
        }
        
        itemNameLabel.textColor = UIColor.whiteColor()
        itemNameLabel.font = UIFont.systemFontOfSize(13.0, weight: UIFontWeightMedium)

        let sizeOfItemNameLabel = NSString(string: itemNameLabel.text!).sizeWithAttributes([NSFontAttributeName: itemNameLabel.font])
        itemNameLabel.frame = CGRectMake(10.0, itemPriceLabel.frame.origin.y + itemPriceLabel.frame.size.height + 2.0, itemImageViewMask.frame.size.width, sizeOfItemNameLabel.height)
        contentView.addSubview(itemNameLabel)
        
        // Skin Meta
        itemMetaLabel = UILabel()
        
        if item.type == Type.MusicKit {
            itemMetaLabel.text = item.artistName!.uppercaseString
        } else {
            if item.collection != nil && item.collection != "" {
                itemMetaLabel.text = item.type!.stringDescription().uppercaseString + " • " + item.collection!.uppercaseString
            } else if item.tournament != nil && item.tournament != "" {
                itemMetaLabel.text = item.type!.stringDescription().uppercaseString + " • " + item.tournament!.uppercaseString
            } else {

                itemMetaLabel.text = item.type!.stringDescription().uppercaseString
                
                if item.type == Type.Sticker {
                    if item.stickerCollection != nil && item.stickerCollection != "" {
                        itemMetaLabel.text = item.type!.stringDescription().uppercaseString + " • " + item.stickerCollection!.uppercaseString
                    }
                }
            }
        }
        
        itemMetaLabel.textColor = UIColor.metaTextColor()
        itemMetaLabel.font = UIFont.systemFontOfSize(9.0, weight: UIFontWeightRegular)
        
        let sizeOfItemMetaLabel = NSString(string: itemMetaLabel.text!).sizeWithAttributes([NSFontAttributeName: itemMetaLabel.font])
        itemMetaLabel.frame = CGRectMake(10.0, itemNameLabel.frame.origin.y + itemNameLabel.frame.size.height + 3.0, itemImageViewMask.frame.size.width, sizeOfItemMetaLabel.height)
        contentView.addSubview(itemMetaLabel)
        
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
                
                itemCategoryLabel.frame = CGRectMake(10.0, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 5.0, sizeOfItemCategoryLabel.width + 12.0, sizeOfItemCategoryLabel.height + 8.0)
                itemCategoryLabel.layer.cornerRadius = 4.0
                
                contentView.addSubview(itemCategoryLabel)
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
                
                itemQualityLabel.frame = CGRectMake(10.0, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 5.0, sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 8.0)
                
                if let categoryLabel = itemCategoryLabel {
                    
                    if item.category != Category.None && item.category != Category.Normal {
                    
                        itemQualityLabel.frame = CGRectMake(categoryLabel.frame.origin.x + categoryLabel.frame.size.width + 4.0, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 5.0, sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 8.0)
                    }
                    
                }
                
                itemQualityLabel.layer.cornerRadius = 4.0
                contentView.addSubview(itemQualityLabel)
            }
            
        } else {
            print("OOOPS")
            dump(item)
        }
        
        bottomSeparator = UIView(frame: CGRectMake(0.0, contentView.frame.size.height - (2.0 / UIScreen.mainScreen().scale), contentView.frame.size.width, 1.0 / UIScreen.mainScreen().scale))
        bottomSeparator.backgroundColor = UIColor.tableViewSeparatorColor()
        contentView.addSubview(bottomSeparator)
        
        if indexPath.row % 2 == 0 {
            leftSeparator = UIView(frame: CGRectMake(contentView.frame.size.width - (1.0 / UIScreen.mainScreen().scale), 0.0, 1.0 / UIScreen.mainScreen().scale, contentView.frame.size.height))
            leftSeparator.backgroundColor = UIColor.tableViewSeparatorColor()
            contentView.addSubview(leftSeparator)
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
