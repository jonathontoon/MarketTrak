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
    
    var imageOperation: SDWebImageOperation?
    var itemImageViewMask: UIImageView!
    var itemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.redColor()

        self.navigationController!.navigationBar.backgroundColor = UIColor.clearColor()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        itemImageViewMask = UIImageView(frame: CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.width))
        itemImageViewMask.image = UIImage(named: "gradientImage")
        
        self.view.addSubview(itemImageViewMask)
        
        // Item Image
        itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.width))
        
        // Resize images to fit
        if item.type == Type.Container || item.type == Type.Gift || item.type == Type.MusicKit || item.type == Type.Pass || item.type == Type.Tag {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.12), round(itemImageView.frame.size.height/1.12)))
        } else if item.type == Type.Rifle {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.1), round(itemImageView.frame.size.height/1.1)))
        } else if item.type == Type.Sticker {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/0.33), round(itemImageView.frame.size.height/0.33)))
        } else if item.type == Type.Key {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.2), round(itemImageView.frame.size.width/1.2)))
        }
        
        itemImageView.backgroundColor = UIColor.clearColor()
        itemImageView.layer.cornerRadius = 2.0
        itemImageView.center = CGPointMake(itemImageViewMask.frame.size.width/2, (itemImageViewMask.frame.size.height/2) + 10)
        itemImageView.contentMode = .ScaleAspectFit
        
        itemImageViewMask.addSubview(itemImageView)
        
        self.view.setNeedsLayout()
        
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
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
