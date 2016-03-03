//
//  MTItemViewController.swift
//  
//
//  Created by Jonathon Toon on 10/11/15.
//
//

import UIKit
import SDWebImage

class MTItemViewController: UIViewController {

    var item: MTListedItem!
    
    var containerView: UIView!
    
    var imageRatio: CGFloat!
    var imageOperation: SDWebImageOperation?
    var itemImageViewMask: UIImageView!
    var itemImageView: UIImageView!
    
    var itemPriceLabel: UILabel!
    var itemNameLabel: UILabel!
    var itemMetaLabel: UILabel!
    var itemCategoryLabel: UILabel!
    var itemQualityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundColor()
        
        if navigationController!.navigationBarHidden {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
        let backButtonImage = UIImage(named: "back_arrow_icon")?.imageWithRenderingMode(.AlwaysTemplate)
        let backButton = UIBarButtonItem(image: backButtonImage, style: UIBarButtonItemStyle.Done, target: self, action: "backButtonPressed:")
            backButton.tintColor = UIColor.appTintColor()
        navigationItem.leftBarButtonItem = backButton
        
        let containerView = UIView(frame: CGRectMake(10.0, 10.0, view.frame.size.width - 20.0, view.frame.size.width + 100.0))
            containerView.backgroundColor = UIColor.searchResultCellColor()
            containerView.layer.cornerRadius = 6.0
            containerView.clipsToBounds = true
            containerView.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.05).CGColor
            containerView.layer.borderWidth = (1/UIScreen.mainScreen().scale) * 1.0
            containerView.layer.masksToBounds = true
        view.addSubview(containerView)
    
        // Item Price
        itemPriceLabel = UILabel(frame: CGRectZero)
        
        // Revisit this for selectable currencies
        let formatter = NSNumberFormatter()
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            formatter.minimumIntegerDigits = 1
            
        itemPriceLabel.text = "$" + formatter.stringFromNumber(item.currentPrice!)! + " USD"
        itemPriceLabel.textColor = UIColor.priceTintColor()
        itemPriceLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightMedium)
        
        let sizeOfItemPriceLabel = NSString(string: itemPriceLabel.text!).sizeWithAttributes([NSFontAttributeName: itemPriceLabel.font])
        itemPriceLabel.frame = CGRectMake(15.0, 15.0, sizeOfItemPriceLabel.width, sizeOfItemPriceLabel.height)
        containerView.addSubview(itemPriceLabel)
        
        // Skin Name
        itemNameLabel = UILabel(frame: CGRectZero)
        itemNameLabel.text = item.name!
        
        if item.weaponType != nil && item.weaponType != WeaponType.None  {
            itemNameLabel.text = item.weaponType!.stringDescription() + " | " + item.name! + " (" + item.exterior!.stringDescription() + ")"
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
            itemNameLabel.text = "★ " + item.weaponType!.stringDescription() + " (" + item.exterior!.stringDescription() + ")"
        }
        
        itemNameLabel.textColor = UIColor.whiteColor()
        itemNameLabel.font = UIFont.systemFontOfSize(19.0, weight: UIFontWeightMedium)
        
        let sizeOfItemNameLabel = NSString(string: itemNameLabel.text!).sizeWithAttributes([NSFontAttributeName: itemNameLabel.font])
        itemNameLabel.frame = CGRectMake(itemPriceLabel.frame.origin.x, itemPriceLabel.frame.origin.y + itemPriceLabel.frame.size.height + 2.0, containerView.frame.size.width - (itemPriceLabel.frame.origin.x * 2), sizeOfItemNameLabel.height)
        containerView.addSubview(itemNameLabel)
        
        // Category Tag
        if let category = item.category {
            
            if category != Category.None && category != Category.Normal {
                
                itemCategoryLabel = UILabel(frame: CGRectZero)
                itemCategoryLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightBold)
                itemCategoryLabel.text = category.stringDescription()
                itemCategoryLabel.textColor = category.colorForCategory()
                itemCategoryLabel.textAlignment = NSTextAlignment.Center
                itemCategoryLabel.layer.borderColor = category.colorForCategory().CGColor
                itemCategoryLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                itemCategoryLabel.clipsToBounds = true
                
                let sizeOfItemCategoryLabel = NSString(string: itemCategoryLabel.text!).sizeWithAttributes([NSFontAttributeName: itemCategoryLabel.font])
                
                itemCategoryLabel.frame = CGRectMake(itemPriceLabel.frame.origin.x, itemNameLabel.frame.origin.y + itemNameLabel.frame.size.height + 6.0, sizeOfItemCategoryLabel.width + 12.0, sizeOfItemCategoryLabel.height + 9.0)
                itemCategoryLabel.layer.cornerRadius = 4.0
                
                containerView.addSubview(itemCategoryLabel)
            }
        }
        
        // Quality Tag
        if let quality = item.quality {
            
            if quality != Quality.None {
                
                itemQualityLabel = UILabel(frame: CGRectZero)
                itemQualityLabel.text = quality.stringDescription()
                itemQualityLabel.textColor = quality.colorForQuality()
                itemQualityLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightBold)
                itemQualityLabel.textAlignment = NSTextAlignment.Center
                itemQualityLabel.layer.borderColor = quality.colorForQuality().CGColor
                itemQualityLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                itemQualityLabel.clipsToBounds = true
                
                let sizeOfItemQualityLabel = NSString(string: itemQualityLabel.text!).sizeWithAttributes([NSFontAttributeName: itemQualityLabel.font])
                
                itemQualityLabel.frame = CGRectMake(itemPriceLabel.frame.origin.x, itemNameLabel.frame.origin.y + itemNameLabel.frame.size.height + 6.0, sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 10.0)
                
                if let categoryLabel = itemCategoryLabel {
                    
                    if item.category != Category.None && item.category != Category.Normal {
                        
                        itemQualityLabel.frame = CGRectMake(categoryLabel.frame.origin.x + categoryLabel.frame.size.width + 4.0, itemMetaLabel.frame.origin.y + itemMetaLabel.frame.size.height + 8.0, sizeOfItemQualityLabel.width + 12.0, sizeOfItemQualityLabel.height + 9.0)
                    }
                    
                }
                
                itemQualityLabel.layer.cornerRadius = 4.0
                containerView.addSubview(itemQualityLabel)
            }
        }
        
        itemImageViewMask = UIImageView(frame: CGRectMake(15.0, itemQualityLabel.frame.origin.y + itemQualityLabel.frame.size.height + 18.0, containerView.frame.size.width - 30.0, (containerView.frame.size.width - 30.0) * 0.84))
        itemImageViewMask.image = UIImage(named: "gradient_image_large")
        itemImageViewMask.layer.cornerRadius = 6.0
        itemImageViewMask.clipsToBounds = true
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
        itemImageView.center = item.type == Type.SniperRifle ? CGPointMake((itemImageViewMask.frame.size.width/2) - 20.0, itemImageViewMask.frame.size.height/2)
            : CGPointMake(itemImageViewMask.frame.size.width/2, itemImageViewMask.frame.size.height/2)
        
        itemImageView.contentMode = .ScaleAspectFit
        itemImageViewMask.addSubview(itemImageView)
        
        view.setNeedsLayout()
        
        let downloadManager = SDWebImageManager()
        
        imageOperation = downloadManager.downloadImageWithURL(
            item.imageURL!,
            options: SDWebImageOptions.RetryFailed,
            progress: nil,
            completed: {
                
                (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, finished: Bool, imageURL: NSURL!) in
                
                if image != nil {
                    
                    self.itemImageView.image = image
                    self.view.setNeedsLayout()
                    
                    let transition = CATransition()
                    transition.duration = 0.25
                    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                    transition.type = kCATransitionFade
                    
                    self.itemImageView.layer.addAnimation(transition, forKey: nil)
                }
                
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        dump(item)
    }
    
    func backButtonPressed(button: UIButton) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
