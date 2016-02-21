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

class MTSearchResultCell: MaterialTableViewCell {

    var imageOperation: SDWebImageOperation?
    
    var itemImageViewMask: UIImageView!
    var itemImageView: UIImageView!
    
    var itemPriceLabel: UILabel!
    var itemNameLabel: UILabel!
    var itemMetaLabel: UILabel!
    var itemCategoryLabel: UILabel!
    var itemQualityLabel: UILabel!
 
    var separator: UIView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func renderCellContentForItem(item: MTListedItem, indexPath: NSIndexPath, resultCount: Int) {
        
        itemImageViewMask = UIImageView(frame: CGRectMake(13.0, 10, 87.0, 87.0))
        itemImageViewMask.image = UIImage(named: "gradientImage")
        itemImageViewMask.layer.cornerRadius = 3.0
        itemImageViewMask.clipsToBounds = true
        
        contentView.addSubview(itemImageViewMask)
        
        // Item Image
        itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 87.0, 87.0))
        
        // Resize images to fit
        if item.type == Type.Container || item.type == Type.Gift || item.type == Type.Key || item.type == Type.MusicKit || item.type == Type.Pass || item.type == Type.Tag {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.12), round(itemImageView.frame.size.height/1.12)))
        } else if item.type == Type.Rifle {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.1), round(itemImageView.frame.size.height/1.1)))
        } else if item.type == Type.Sticker {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/0.33), round(itemImageView.frame.size.height/0.33)))
        }
        
        itemImageView.backgroundColor = UIColor.clearColor()
        itemImageView.layer.cornerRadius = 2.0
        itemImageView.center = CGPointMake(itemImageViewMask.frame.size.width/2, itemImageViewMask.frame.size.height/2)
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
        itemPriceLabel.font = UIFont.systemFontOfSize(12.0, weight: UIFontWeightMedium)

        let sizeOfItemPriceLabel = NSString(string: itemPriceLabel.text!).sizeWithAttributes([NSFontAttributeName: itemPriceLabel.font])
        itemPriceLabel.frame = CGRectMake(112.0, itemImageViewMask.frame.origin.y + 5, sizeOfItemPriceLabel.width, sizeOfItemPriceLabel.height)
        contentView.addSubview(itemPriceLabel)

        // Skin Name
        itemNameLabel = UILabel(frame: CGRectZero)
        itemNameLabel.text = item.name!
        
        if item.exterior != nil && item.exterior != Exterior.None && item.exterior != Exterior.NotPainted  {
            itemNameLabel.text =  itemNameLabel.text! + " (" + item.exterior!.stringDescription() + ")"
        }
        
        if item.type == Type.MusicKit {
            
            itemNameLabel.text = item.name!
            
            if item.artistName != nil {
                itemNameLabel.text = item.name! + " " + item.artistName!
            }
        }
        
        itemNameLabel.textColor = UIColor.whiteColor()
        itemNameLabel.font = UIFont.systemFontOfSize(15.0, weight: UIFontWeightMedium)
        itemNameLabel.frame = CGRectMake(112.0, itemPriceLabel.frame.origin.y + itemPriceLabel.frame.size.height + 4.0, self.frame.size.width - 135.0, 17.0)
        contentView.addSubview(itemNameLabel)
        
        // Skin Meta
        itemMetaLabel = UILabel()
        
        if item.type == Type.MusicKit {
            
            if item.artistName != nil {
                itemMetaLabel.text = item.type!.stringDescription().uppercaseString
            }
            
        } else if item.type == Type.Container {
            
            if item.tournament != nil && item.tournament != "" {
                
                itemMetaLabel.text = item.tournament
                
                if item.items != nil && item.items!.count > 0 {
                    
                    itemMetaLabel.text = (item.items!.count.description + " Items • " + item.tournament!).uppercaseString
                    
                }
            
            }
            
            if item.collection != nil && item.collection != "" {
                
                itemMetaLabel.text = item.collection!
                
                if item.items != nil {
                    
                    itemMetaLabel.text = (item.items!.count.description + " Items • " + item.collection!).uppercaseString
                    
                }
                
            }
        
        } else if item.type == Type.Sticker {
            
            itemMetaLabel.text = item.type!.stringDescription().uppercaseString
            
            if item.stickerCollection != nil && item.stickerCollection != "" {
                
                itemMetaLabel.text = item.type!.stringDescription().uppercaseString + " • " + item.stickerCollection!.uppercaseString
                
            }
            
            if item.tournament != nil && item.tournament != "" {
                
                itemMetaLabel.text = item.type!.stringDescription().uppercaseString + " • " + item.tournament!.uppercaseString
            }
            
        } else if item.type == Type.Key || item.type == Type.Tag || item.type == Type.Pass || item.type == Type.Gift || item.type == Type.Tool {
            
            var itemMetaText: String = ""
            
            if item.type!.stringDescription() != "" {
                itemMetaText += item.type!.stringDescription().uppercaseString
            }
            
            if item.collection != "" && item.collection != nil {
                itemMetaText += " • " + item.collection!.uppercaseString
            }
            
            itemMetaLabel.text = itemMetaText
            
        } else {
            
            if item.weaponType != nil && item.weaponType != WeaponType.None && item.collection != nil && item.collection != "" {
                
                itemMetaLabel.text = item.weaponType!.stringDescription().uppercaseString + " • " + item.collection!.uppercaseString
                
            } else if item.weaponType != nil {
                
                itemMetaLabel.text = item.weaponType!.stringDescription().uppercaseString
                
            } else if item.collection != nil {
                
                itemMetaLabel.text = item.collection!.uppercaseString
                
            }
            
        }
        
        itemMetaLabel.textColor = UIColor.metaTextColor()
        itemMetaLabel.font = UIFont.systemFontOfSize(12.0, weight: UIFontWeightRegular)
        itemMetaLabel.frame = CGRectMake(112.0, itemNameLabel.frame.origin.y + itemNameLabel.frame.size.height + 4.0, self.frame.size.width - 135.0, 13.0)
        contentView.addSubview(itemMetaLabel)
        
        // Category Tag
        if let category = item.category {
            
            if category != Category.None && category != Category.Normal {
                
                itemCategoryLabel = UILabel(frame: CGRectZero)
                itemCategoryLabel.font = UIFont.systemFontOfSize(9.0, weight: UIFontWeightBold)
                itemCategoryLabel.text = category.stringDescription()
                itemCategoryLabel.textColor = category.colorForCategory()
                itemCategoryLabel.textAlignment = NSTextAlignment.Center
                itemCategoryLabel.layer.borderColor = category.colorForCategory().CGColor
                itemCategoryLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                itemCategoryLabel.clipsToBounds = true
                
                let sizeOfItemCategoryLabel = NSString(string: itemCategoryLabel.text!).sizeWithAttributes([NSFontAttributeName: itemCategoryLabel.font])
                
                itemCategoryLabel.frame = CGRectMake(112.0, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 5.0, sizeOfItemCategoryLabel.width + 12.0, sizeOfItemCategoryLabel.height + 7.0)
                itemCategoryLabel.layer.cornerRadius = itemCategoryLabel.frame.size.height/2
                
                contentView.addSubview(itemCategoryLabel)
            }
        }
        
        // Quality Tag
        if let quality = item.quality {
            
            if quality != Quality.None {
            
                itemQualityLabel = UILabel(frame: CGRectZero)
                itemQualityLabel.text = quality.stringDescription()
                itemQualityLabel.textColor = quality.colorForQuality()
                itemQualityLabel.font = UIFont.systemFontOfSize(9.0, weight: UIFontWeightBold)
                itemQualityLabel.textAlignment = NSTextAlignment.Center
                itemQualityLabel.layer.borderColor = quality.colorForQuality().CGColor
                itemQualityLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                itemQualityLabel.clipsToBounds = true
                
                let sizeOfItemQualityLabel = NSString(string: itemQualityLabel.text!).sizeWithAttributes([NSFontAttributeName: itemQualityLabel.font])
                
                itemQualityLabel.frame = CGRectMake(112.0, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 5.0, sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 7.0)
                
                if let categoryLabel = itemCategoryLabel {
                    
                    if item.category != Category.None && item.category != Category.Normal {
                    
                        itemQualityLabel.frame = CGRectMake(categoryLabel.frame.origin.x + categoryLabel.frame.size.width + 4.0, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 5.0, sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 7.0)
                    }
                    
                } else {
                    print(item.name)
                }
                
                itemQualityLabel.layer.cornerRadius = itemQualityLabel.frame.size.height/2
                contentView.addSubview(itemQualityLabel)
            }
            
        } else {
            print("OOOPS")
            dump(item)
        }
        
        backgroundColor = UIColor.tableViewCellColor()
        selectionStyle = UITableViewCellSelectionStyle.None
        
        if indexPath.row != resultCount-1 {
            
            separator = UIView(frame: CGRectMake(indexPath.row < resultCount-1 ? 13.0 : 0.0, frame.size.height - (1.0 / UIScreen.mainScreen().scale), frame.size.width, 1.0 / UIScreen.mainScreen().scale))
            separator.backgroundColor = UIColor.tableViewSeparatorColor()
            addSubview(separator)
            
        }
        
        pulseColor = UIColor.tableViewSeparatorColor()
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
