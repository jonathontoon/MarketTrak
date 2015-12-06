//
//  MTSearchResultswift
//  
//
//  Created by Jonathon Toon on 10/10/15.
//
//

import UIKit
import SDWebImage
import MGSwipeTableCell

class MTSearchResultCell: MGSwipeTableCell {

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

    func renderCellContentForItem(item: MTListingItem, indexPath: NSIndexPath, resultCount: Int) {
        itemImageViewMask = UIImageView(frame: CGRectMake(15.0, 15.0, 75.0, 75.0))
        itemImageViewMask.image = UIImage(named: "gradientImage")
        itemImageViewMask.layer.cornerRadius = 3.0
        itemImageViewMask.clipsToBounds = true
        
        contentView.addSubview(itemImageViewMask)
        
        // Item Image
        itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 75.0, 75.0))
        
        // Resize images to fit
        if item.type == Type.Container || item.type == Type.Gift || item.type == Type.Key || item.type == Type.MusicKit || item.type == Type.Pass {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 110.0, 110.0))
        } else if item.type == Type.Rifle {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 75.0, 75.0))
        } else if item.type == Type.Sticker {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 230.0, 230.0))
        }
        
        itemImageView.backgroundColor = UIColor.clearColor()
        itemImageView.layer.cornerRadius = 3.0
        itemImageView.center = CGPointMake(itemImageViewMask.frame.size.width/2, itemImageViewMask.frame.size.height/2)
        
        itemImageViewMask.addSubview(itemImageView)
        
        setNeedsLayout()
        
        let downloadManager = SDWebImageManager()
        
        imageOperation = downloadManager.downloadImageWithURL(
            item.imageURL!,
            options: SDWebImageOptions.RetryFailed,
            progress: nil,
            completed: {
                
                (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, finished: Bool, imageURL: NSURL!) in
                
                if image != nil {
                    
                    self.itemImageView.image = image
                    self.setNeedsLayout()
                    
                    let transition = CATransition()
                    transition.duration = 0.25
                    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                    transition.type = kCATransitionFade
                    
                    self.itemImageView.layer.addAnimation(transition, forKey: nil)
                }
                
        })
        
        // Item Price
        itemPriceLabel = UILabel()
        itemPriceLabel.text = (item.price! as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        itemPriceLabel.textColor = UIColor.priceTintColor()
        itemPriceLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightMedium)
        itemPriceLabel.sizeToFit()
        
        itemPriceLabel.frame = CGRectMake(102.0, itemImageViewMask.frame.origin.y + 4.5, self.contentView.frame.size.width - 142.0, itemPriceLabel.frame.size.height)
        
        if item.quality == Quality.Any || item.quality == nil {
            itemPriceLabel.frame = CGRectMake(102.0, itemImageViewMask.frame.origin.y + 14.0, self.contentView.frame.size.width - 142.0, itemPriceLabel.frame.size.height)
        }
        
        contentView.addSubview(itemPriceLabel)
        
        // Skin Name
        itemNameLabel = UILabel()
        itemNameLabel.text = item.itemName!
        
        if item.exterior != nil && item.exterior != Exterior.Any {
            itemNameLabel.text =  itemNameLabel.text! + " (" + item.exterior!.stringDescription() + ")"
        }
        
        if item.type == Type.MusicKit {
            
            itemNameLabel.text = item.itemName!
            
            if item.artist != nil {
                itemNameLabel.text = item.itemName! + " " + item.artist!
            }
        }
        
        itemNameLabel.textColor = UIColor.whiteColor()
        itemNameLabel.font = UIFont.systemFontOfSize(15.0, weight: UIFontWeightMedium)
        itemNameLabel.sizeToFit()
        itemNameLabel.frame = CGRectMake(102.0, itemPriceLabel.frame.origin.y + itemPriceLabel.frame.size.height, self.contentView.frame.size.width - 142.0, itemNameLabel.frame.size.height)
        
        contentView.addSubview(itemNameLabel)
        
        // Skin Meta
        itemMetaLabel = UILabel()
        
        if item.type == Type.MusicKit {
            
            if item.artist != nil {
                itemMetaLabel.text = item.type!.stringDescription().uppercaseString
            }
            
        } else if item.type == Type.Container {
            
            if item.tournament != nil && item.tournament != Tournament.Any {
                
                itemMetaLabel.text = item.tournament!.stringDescription()
                
                if item.containedItems != nil && item.containedItems!.count > 0 {
                    
                    itemMetaLabel.text = (item.containedItems!.count.description + " Items • " + item.tournament!.stringDescription()).uppercaseString
                    
                }
                
            }
            
            if item.collection != nil && item.collection != Collection.Any {
                
                itemMetaLabel.text = item.collection!.stringDescription()
                
                if item.containedItems != nil {
                    
                    itemMetaLabel.text = (item.containedItems!.count.description + " Items • " + item.collection!.stringDescription()).uppercaseString
                    
                }
                
            }
            
        } else if item.type == Type.Sticker {
            
            if item.stickerCollection != nil && item.stickerCollection != StickerCollection.Any {
                
                itemMetaLabel.text = item.stickerCollection!.stringDescription().uppercaseString
                
            }
            
            if item.tournament != nil && item.tournament != Tournament.Any {
                
                itemMetaLabel.text = item.tournament!.stringDescription().uppercaseString
            }
            
        } else if item.type == Type.Key || item.type == Type.Tag || item.type == Type.Pass || item.type == Type.Gift || item.type == Type.Tool {
            
            if item.usage != nil && item.usage != "" {
                itemMetaLabel.text = item.usage!.uppercaseString
                
            }
            
        } else {
            
            if item.weapon != nil && item.weapon != Weapon.Any && item.collection != nil && item.collection != Collection.Any {
                
                itemMetaLabel.text = item.weapon!.stringDescription().uppercaseString + " • " + item.collection!.stringDescription().uppercaseString
                
            } else if item.weapon != nil {
                
                itemMetaLabel.text = item.weapon!.stringDescription().uppercaseString
                
            } else if item.collection != nil {
                
                itemMetaLabel.text = item.collection!.stringDescription().uppercaseString
                
            }
            
        }
        
        itemMetaLabel.textColor = UIColor.metaTextColor()
        itemMetaLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightRegular)
        itemMetaLabel.sizeToFit()
        itemMetaLabel.frame = CGRectMake(102.0, itemNameLabel.frame.origin.y + itemNameLabel.frame.size.height + 2.0, self.contentView.frame.size.width - 142.0, itemMetaLabel.frame.size.height)
        
        contentView.addSubview(itemMetaLabel)
        
        // Category Tag
        if item.category != nil && item.category != Category.Any && item.category != nil && item.category != Category.Normal {
            
            itemCategoryLabel = UILabel()
            itemCategoryLabel.text = item.category!.stringDescription()
            itemCategoryLabel.textColor = item.category!.colorForCategory()
            itemCategoryLabel.font = UIFont.systemFontOfSize(8.0, weight: UIFontWeightBold)
            itemCategoryLabel.textAlignment = NSTextAlignment.Center
            itemCategoryLabel.layer.borderColor = item.category!.colorForCategory().CGColor
            itemCategoryLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
            itemCategoryLabel.sizeToFit()
            itemCategoryLabel.clipsToBounds = true
            itemCategoryLabel.frame = CGRectMake(102.0, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 4.0, itemCategoryLabel.frame.size.width + 12.0, itemCategoryLabel.frame.size.height + 6.0)
            itemCategoryLabel.layer.cornerRadius = itemCategoryLabel.frame.size.height/2
            
            contentView.addSubview(itemCategoryLabel)
        }
        
        // Quality Tag
        if item.quality != Quality.Any && item.quality != nil {
            
            itemQualityLabel = UILabel()
            itemQualityLabel.text = item.quality!.stringDescription()
            itemQualityLabel.textColor = item.quality!.colorForQuality()
            itemQualityLabel.font = UIFont.systemFontOfSize(8.0, weight: UIFontWeightBold)
            itemQualityLabel.textAlignment = NSTextAlignment.Center
            itemQualityLabel.layer.borderColor = item.quality!.colorForQuality().CGColor
            itemQualityLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
            itemQualityLabel.sizeToFit()
            itemQualityLabel.clipsToBounds = true
            
            if itemCategoryLabel != nil {
                
                itemQualityLabel.frame = CGRectMake(itemCategoryLabel.frame.origin.x + itemCategoryLabel.frame.size.width + 4.0, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 4.0, itemQualityLabel.frame.size.width + 12.0, itemQualityLabel.frame.size.height + 6.0)
                
            } else {
                
                itemQualityLabel.frame = CGRectMake(102.0, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 4.0, itemQualityLabel.frame.size.width + 12.0, itemQualityLabel.frame.size.height + 6.0)
                
            }
            
            itemQualityLabel.layer.cornerRadius = itemQualityLabel.frame.size.height/2
            
            contentView.addSubview(itemQualityLabel)
        }
        
        backgroundColor = UIColor.tableViewCellColor()
        accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        selectionStyle = UITableViewCellSelectionStyle.None
        
        if indexPath.row != resultCount-1 {
            
            separator = UIView(frame: CGRectMake(indexPath.row < resultCount-1 ? 15.0 : 0.0, frame.size.height - (1.0 / UIScreen.mainScreen().scale), frame.size.width, 1.0 / UIScreen.mainScreen().scale))
            separator.backgroundColor = UIColor.tableViewSeparatorColor()
            addSubview(separator)
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageOperation?.cancel()
        imageOperation = nil
        
        itemImageView.removeFromSuperview()
        itemImageView = nil
        itemPriceLabel.removeFromSuperview()
        itemPriceLabel = nil
        itemNameLabel.removeFromSuperview()
        itemNameLabel = nil
        itemMetaLabel.removeFromSuperview()
        itemMetaLabel = nil
        
        if itemCategoryLabel != nil {
            itemCategoryLabel.removeFromSuperview()
            itemCategoryLabel = nil
        }

        if itemQualityLabel != nil {
            itemQualityLabel.removeFromSuperview()
            itemQualityLabel = nil
        }

        if separator != nil {
            separator.removeFromSuperview()
            separator = nil
        }
    }
}
