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
    
    var imageOperation: SDWebImageOperation?
    var itemImageViewMask: UIImageView!
    var itemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.redColor()
        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 8.0
        
        self.navigationController!.navigationBar.backgroundColor = UIColor.clearColor()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : self.navigationController!.navigationBar.tintColor]
        
        let closeButton = UIButton(frame: CGRectMake(0, 0, 18.0, 18.0))
            closeButton.setBackgroundImage(UIImage(named: "closeButton"), forState: UIControlState.Normal)
            closeButton.addTarget(self, action: "closeButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        itemImageViewMask = UIImageView(frame: CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.width - 50.0))
        itemImageViewMask.image = UIImage(named: "gradientImage")
        
        self.view.addSubview(itemImageViewMask)
        
        // Item Image
        itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, itemImageViewMask.frame.size.width, itemImageViewMask.frame.size.width))
        
        // Resize images to fit
        if item.type == Type.Container || item.type == Type.Gift || item.type == Type.MusicKit || item.type == Type.Pass || item.type == Type.Tag {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.8), round(itemImageView.frame.size.height/1.8)))
        } else if item.type == Type.Rifle {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.3), round(itemImageView.frame.size.height/1.3)))
        } else if item.type == Type.Sticker {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/0.33), round(itemImageView.frame.size.height/0.33)))
        } else if item.type == Type.Key {
            itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, round(itemImageView.frame.size.width/1.6), round(itemImageView.frame.size.width/1.6)))
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
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        dump(item)
    }
    
    func closeButtonPressed() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
