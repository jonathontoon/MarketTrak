//
//  MTItemImageHeaderView.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 3/6/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit
import SDWebImage
import PureLayout

class MTItemImageHeaderView: UIView {

    var item: MTItem!
    
    var imageOperation: SDWebImageOperation?
    
    let itemImageViewMask = UIImageView.newAutoLayoutView()
    let itemImageView = UIImageView.newAutoLayoutView()
    
    init(item: MTItem!, frame: CGRect!) {
        super.init(frame: frame)
        
        self.item = item
        
        self.frame = frame
        
        self.addSubview(itemImageViewMask)
        //itemImageViewMask.image = UIImage(named: "gradient_image_small")
        itemImageViewMask.backgroundColor = UIColor(rgba: "#D8D8D8")
        itemImageViewMask.clipsToBounds = true
        itemImageViewMask.addSubview(itemImageView)
        itemImageView.backgroundColor = UIColor.clearColor()
        itemImageView.contentMode = .ScaleAspectFit
        
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
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Item Image
        let imageViewMaskHeight = itemImageViewMask.autoSetDimension(.Height, toSize: 315)
        itemImageViewMask.autoPinEdge(.Left, toEdge: .Left, ofView: self)
        itemImageViewMask.autoPinEdge(.Top, toEdge: .Top, ofView: self)
        itemImageViewMask.autoPinEdge(.Right, toEdge: .Right, ofView: self)
        
        // Resize images to fit
        if item.weaponType == WeaponType.SCAR20 || item.weaponType == WeaponType.G3SG1 {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.frame.size.width/1.05, imageViewMaskHeight.constant/1.05))
        } else if item.type == Type.Container || item.type == Type.Gift || item.type == Type.MusicKit || item.type == Type.Pass || item.type == Type.Tag || item.type == Type.Pistol || item.type == Type.SMG {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.frame.size.width/1.3, imageViewMaskHeight.constant/1.3))
        } else if item.type == Type.Key {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.frame.size.width/1.5, imageViewMaskHeight.constant/1.5))
        } else if item.type == Type.Rifle {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.frame.size.width/1.4, imageViewMaskHeight.constant/1.1))
        } else if item.type == Type.Sticker {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.frame.size.width/1.1, imageViewMaskHeight.constant/1.4))
        } else if item.type == Type.SniperRifle {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.frame.size.width/0.97, imageViewMaskHeight.constant/0.97))
        } else if item.type == Type.Knife {
            itemImageView.autoSetDimensionsToSize(CGSizeMake(self.frame.size.width/1.2, imageViewMaskHeight.constant/1.2))
        }
        
        itemImageView.autoAlignAxis(.Vertical, toSameAxisOfView: itemImageViewMask, withOffset: item.type == Type.SniperRifle ? -8 : 0)
        itemImageView.autoAlignAxis(.Horizontal, toSameAxisOfView: itemImageViewMask)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
