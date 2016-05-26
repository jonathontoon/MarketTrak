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
    
    private let isSmallerDevice = Device().isOneOf([.iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE])
    
    var item: MTItem!
    
    let downloadManager = SDWebImageManager()
    var imageOperation: SDWebImageOperation?
    
    var containerView: UIView!
    
    var itemImageViewMask: UIImageView!
    
    var itemImageView: UIImageView!

    let separatorView: UIView = UIView.newAutoLayoutView()
    
    let itemPriceLabel: UILabel = UILabel.newAutoLayoutView()
    let itemNameLabel: UILabel = UILabel.newAutoLayoutView()
    let itemTypeLabel: UILabel = UILabel.newAutoLayoutView()
    let itemQualityLabel: UILabel = UILabel.newAutoLayoutView()
    
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
        containerView.backgroundColor = item.quality?.colorForQuality()
        containerView.layer.cornerRadius = 3
        containerView.clipsToBounds = true
        containerView.layer.borderColor = UIColor.blackColor().colorWithAlphaComponent(0.1).CGColor
        containerView.layer.borderWidth = (1/UIScreen.mainScreen().scale) * 1.0
        containerView.layer.masksToBounds = true
        contentView.addSubview(containerView)
        containerView.autoPinEdge(.Top, toEdge: .Top, ofView: contentView, withOffset: 4.0)
        containerView.autoPinEdge(.Left, toEdge: .Left, ofView: contentView, withOffset: indexPath.row % 2 == 0 ? 8.0 : 4.0)
        containerView.autoPinEdge(.Right, toEdge: .Right, ofView: contentView, withOffset: indexPath.row % 2 == 0 ? -4.0 : -8.0)
        containerView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: contentView, withOffset: -4.0)
        
        itemImageViewMask = UIImageView.newAutoLayoutView()
        itemImageViewMask.backgroundColor = UIColor.greenColor()
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
        
        // Item Quality
        var itemMeta: String = ""
        
        if item.type == Type.Container {
            itemMeta = "Contains " + item.items!.count.description + " items"
        } else {
            
            if let exterior = item.exterior {
                if exterior != .None {
                   itemMeta = exterior.stringDescription()
                }
            }
        }
        
        itemQualityLabel.text = itemMeta.uppercaseString
        itemQualityLabel.textColor = UIColor.whiteColor()
        itemQualityLabel.font = UIFont.systemFontOfSize(UIScreen.mainScreen().bounds.size.width == 320 ? 10 : 11, weight: UIFontWeightRegular)

        containerView.addSubview(itemQualityLabel)
        itemQualityLabel.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: containerView, withOffset: -8)
        itemQualityLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8)
        itemQualityLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8)
        
        // Item Name
        containerView.addSubview(itemNameLabel)
      
        if let name = item.name {
            itemNameLabel.text = name
        }
        
        itemNameLabel.textColor = UIColor.whiteColor()
        itemNameLabel.font =  UIFont.systemFontOfSize(UIScreen.mainScreen().bounds.size.width == 320 ? 13 : 15, weight: UIFontWeightSemibold)
        
        itemNameLabel.autoPinEdge(.Bottom, toEdge: .Top, ofView: itemQualityLabel, withOffset: -1.5)
        itemNameLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8)
        itemNameLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8)
        
        
        // Item Type
        containerView.addSubview(itemTypeLabel)
        
        var itemType: String = ""

        if let category = item.category {
            if category != .None && category != .Normal {
                itemType += category.stringDescription()+" "
            }
        }
        
        if let weaponType = item.weaponType {
            if weaponType != .None {
                itemType += weaponType.stringDescription()
            } else {
                if let type = item.type {
                    if type != .None {
                        itemType += type.stringDescription()
                    }
                }
            }
        } else {
            if let type = item.type {
                if type != .None {
                    itemType += type.stringDescription()
                }
            }
        }
   
        
        itemTypeLabel.text = itemType
        itemTypeLabel.textColor = UIColor.whiteColor()
        itemTypeLabel.font = UIFont.systemFontOfSize(UIScreen.mainScreen().bounds.size.width == 320 ? 13 : 15, weight: UIFontWeightSemibold)
        
        itemTypeLabel.autoPinEdge(.Bottom, toEdge: .Top, ofView: itemNameLabel, withOffset: 0)
        itemTypeLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8)
        itemTypeLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8)

        // Item Price
        // Revisit this for selectable currencies
        let priceFormatter = NSNumberFormatter()
            priceFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            priceFormatter.maximumFractionDigits = 2
            priceFormatter.minimumFractionDigits = 2
            priceFormatter.minimumIntegerDigits = 1
        
        containerView.addSubview(itemPriceLabel)
        itemPriceLabel.text = "$" + priceFormatter.stringFromNumber(item.price!)! + " USD"
        itemPriceLabel.textColor = UIColor.whiteColor()
        itemPriceLabel.font = UIFont.systemFontOfSize(UIScreen.mainScreen().bounds.size.width == 320 ? 11 : 12, weight: UIFontWeightMedium)

        itemPriceLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: itemImageViewMask, withOffset: 8)
        itemPriceLabel.autoPinEdge(.Left, toEdge: .Left, ofView: containerView, withOffset: 8)
        itemPriceLabel.autoPinEdge(.Right, toEdge: .Right, ofView: containerView, withOffset: -8)

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
