//
//  MTNavigationViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 11/7/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTNavigationViewController: UINavigationController {

    var separator: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.translucent = false
        navigationBar.barTintColor = UIColor.searchResultCellColor()
        navigationBar.tintColor = UIColor.appTintColor()
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationBar.barStyle = UIBarStyle.Black
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        
//        separator = UIView(frame: CGRectMake(0.0, navigationBar.frame.size.height - (1.0 / UIScreen.mainScreen().scale), navigationBar.frame.size.width, 1.0 / UIScreen.mainScreen().scale))
//        separator.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.05)
//        navigationBar.addSubview(separator)
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
