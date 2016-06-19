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

func formatPoints(num: Double) -> String {
    let thousandNum = num/1000
    let millionNum = num/1000000
    if num >= 1000 && num < 1000000{
        if(floor(thousandNum) == thousandNum){
            return("\(Int(thousandNum))k")
        }
        return("\(thousandNum.roundToPlaces(1))k")
    }
    if num > 1000000{
        if(floor(millionNum) == millionNum){
            return("\(Int(thousandNum))k")
        }
        return ("\(millionNum.roundToPlaces(1))M")
    }
    else{
        if(floor(num) == num){
            return ("\(Int(num))")
        }
        return ("\(num)")
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
            mask.path = path.CGPath
        layer.mask = mask
    }
}

class MTItemCellFooterView: UIView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.02)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        backgroundColor = UIColor.searchResultCellColor()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        backgroundColor = UIColor.searchResultCellColor()
    }
    
}

protocol MTItemCellDelegate {
    func didTapSearchResultCellFooter(item: MTItem)
}

class MTItemCell: UICollectionViewCell {
    
    private let isSmallerDevice = Device().isOneOf([.iPodTouch5, .iPodTouch6, .iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE, .Simulator(.iPodTouch5), .Simulator(.iPodTouch6), .Simulator(.iPhone4), .Simulator(.iPhone4s), .Simulator(.iPhone5), .Simulator(.iPhone5c), .Simulator(.iPhone5s), .Simulator(.iPhoneSE)]) || Device().isPad
    
    var item: MTItem!
    
    let downloadManager = SDWebImageManager()
    var imageOperation: SDWebImageOperation?
    
    var containerView: UIView!
    
    var itemImageViewMask: UIImageView!
    var itemImageView: UIImageView!
    var itemImageViewMoreButton: UIButton!
    
    var itemPriceLabel: UILabel!
    var itemNameLabel: UILabel!
    var itemMetaLabel: UILabel!
    var itemCategoryLabel: UILabel!
    var itemQualityLabel: UILabel!
    
    var delegate: MTItemCellDelegate!
    
    func renderCellContentForItem(item: MTItem, indexPath: NSIndexPath) {
        self.item = item
        
        containerView = UIView.newAutoLayoutView()
        containerView.backgroundColor = UIColor.searchResultCellColor()
        containerView.layer.cornerRadius = 4.0
        containerView.clipsToBounds = true
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
        itemImageViewMask.autoConstrainAttribute(.Height, toAttribute: .Width, ofView: containerView, withOffset: -10)
        
        // Item Image
        itemImageView = UIImageView.newAutoLayoutView()
        itemImageView.backgroundColor = UIColor.clearColor()
        itemImageView.layer.cornerRadius = 2.0
        itemImageView.contentMode = .ScaleAspectFit
        itemImageViewMask.addSubview(itemImageView)

        var multiplier: CGFloat = 1.0

        // Resize images to fit
        if item.weaponType == WeaponType.SCAR20 || item.weaponType == WeaponType.G3SG1 {
            multiplier = 0.92
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
            multiplier = 0.85
        } else if item.type == Type.Shotgun {
            multiplier = 0.9
        } else if item.type == Type.Collectable {
            multiplier = 0.52
        } else if item.type == Type.Machinegun {
            multiplier = 0.8
        }
        
        if item.name.containsString("Collectible Pins") || item.name.containsString("Swap Tool") {
            multiplier = 0.8
        }
        
        itemImageView.autoConstrainAttribute(.Width, toAttribute: .Width, ofView: itemImageViewMask, withMultiplier: multiplier)
        itemImageView.autoConstrainAttribute(.Height, toAttribute: .Height, ofView: itemImageViewMask, withMultiplier: multiplier)
        itemImageView.autoAlignAxis(.Vertical, toSameAxisOfView: itemImageViewMask, withOffset: item.type == Type.SniperRifle ? -6.5 : 0.0)
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
        
        // More Button
        itemImageViewMoreButton = UIButton.newAutoLayoutView()
        itemImageViewMoreButton.setImage(UIImage(named: "item_more_icon"), forState: .Normal)
        itemImageViewMoreButton.addTarget(self, action: #selector(MTItemCell.tappedMoreButton(_:)), forControlEvents: .TouchUpInside)
        containerView.addSubview(itemImageViewMoreButton)
        
        itemImageViewMoreButton.autoSetDimensionsToSize(CGSizeMake(27, 27))
        itemImageViewMoreButton.autoPinEdge(.Top, toEdge: .Top, ofView: containerView, withOffset: 7)
        itemImageViewMoreButton.autoPinEdge(.Right, toEdge: .Right, ofView: containerView)
        
        // Item Price
        itemPriceLabel = UILabel.newAutoLayoutView()
        itemPriceLabel.text = item.currentPrice?.formatCurrency()
        itemPriceLabel.textColor = UIColor.priceTintColor()
        itemPriceLabel.font = UIFont.systemFontOfSize(11.0, weight: UIFontWeightMedium)
        containerView.addSubview(itemPriceLabel)
        
        itemPriceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemImageViewMask, withOffset: 9.0)
        itemPriceLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8.0)
        itemPriceLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: 8.0)
        
        // Skin Name
        itemNameLabel = UILabel.newAutoLayoutView()
        
        if item.weaponType != nil && item.weaponType! != .None {
            itemNameLabel.text = item.weaponType!.stringDescription() + " | " + item.name!
        } else if item.type! == .Sticker {
            itemNameLabel.text = item.type!.stringDescription() + " | " + item.name!
        } else {
            itemNameLabel.text = item.name!
        }
        
        if item.category! == .Star {
            if !item.name!.containsString("★") {
                itemNameLabel.text = "★ " + item.weaponType!.stringDescription() + " | " + item.name!
            }
        }

        if item.category! == .StarStatTrak™ {
            if !item.name!.containsString("★") {
                itemNameLabel.text = "★ " + item.weaponType!.stringDescription() + " | " + item.name!
            }
        }
        
        itemNameLabel.textColor = UIColor.whiteColor()
        itemNameLabel.font = UIFont.systemFontOfSize(isSmallerDevice == true ? 12 : 13, weight: UIFontWeightMedium)
        containerView.addSubview(itemNameLabel)
        
        itemNameLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemPriceLabel, withOffset: 3.0)
        itemNameLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8.0)
        itemNameLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8.0)
        itemNameLabel.autoSetDimension(.Height, toSize: 14)
        
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
            itemMetaLabel.text = ("Container Series #" + item.containerSeries!.stringValue).uppercaseString
        } else {
            if item.weaponType != nil && item.weaponType != .None && item.exterior != nil && item.exterior! != .None && item.exterior! != Exterior.NotPainted {
                itemMetaLabel.text = (item.exterior!.stringDescription() + " • " + item.type!.stringDescription()).uppercaseString
            } else {
                if item.tournament != nil && item.tournament != .None {
                    itemMetaLabel.text = item.tournament!.uppercaseString
                } else if item.collection != nil && item.collection != .None {
                    itemMetaLabel.text = item.collection!.uppercaseString
                } else if item.stickerCollection != nil && item.stickerCollection != .None {
                    itemMetaLabel.text = item.stickerCollection!.uppercaseString
                } else {
                    itemMetaLabel.text = "No information available".uppercaseString
                }
            }
        }
        
        itemMetaLabel.textColor = UIColor.subTextColor()
        itemMetaLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightRegular)
        containerView.addSubview(itemMetaLabel)
        
        itemMetaLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemNameLabel, withOffset: 4.0)
        itemMetaLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8.0)
        itemMetaLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8.0)
        itemMetaLabel.autoSetDimension(.Height, toSize: 12)
        
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
                
                itemCategoryLabel.autoSetDimension(.Width, toSize: sizeOfItemCategoryLabel.width + 12)
                itemCategoryLabel.autoSetDimension(.Height, toSize: sizeOfItemCategoryLabel.height + 8)
                itemCategoryLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemMetaLabel, withOffset: 6)
                itemCategoryLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8)
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
                
                itemQualityLabel.autoSetDimension(.Width, toSize: sizeOfItemQualityLabel.width + 12)
                itemQualityLabel.autoSetDimension(.Height, toSize: sizeOfItemQualityLabel.height + 8)
                itemQualityLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemMetaLabel, withOffset: 6)
                
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
    }
    
    func tappedMoreButton(button: UIButton) {
        if let d = delegate {
            d.didTapSearchResultCellFooter(item)
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