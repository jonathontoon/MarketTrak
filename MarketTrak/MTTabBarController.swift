//
//  MTTabBarController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 2/21/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTTabBarController: UITabBarController {

    var separator: UIView!
    var initialTabBarYOffset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.translucent = false
        tabBar.barTintColor = UIColor.tabBarColor()
        tabBar.tintColor = UIColor.appTintColor()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        separator = UIView(frame: CGRectMake(0.0, 0.0, tabBar.frame.size.width, 1.0 / UIScreen.mainScreen().scale))
        separator.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.05)

        tabBar.addSubview(separator)
        
        initialTabBarYOffset =  tabBar.frame.origin.y
    }

    func setTabBarHiddenWithAnimation(tabBarHidden: Bool) {
        if tabBarHidden == tabBar.hidden {
            return
        }
        
        let offset = tabBarHidden ? view.frame.size.height : initialTabBarYOffset
       
        dispatch_async(dispatch_get_main_queue(), {
            
            UIView.animateWithDuration(0.25, animations: {
                
                self.tabBar.frame.origin.y = offset
            
            }, completion: { finished in
            
                self.tabBar.hidden = tabBarHidden
            
            })
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
