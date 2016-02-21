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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        separator = UIView(frame: CGRectMake(0.0, 0.0, self.tabBar.frame.size.width, 1.0 / UIScreen.mainScreen().scale))
        separator.backgroundColor = UIColor.tableViewSeparatorColor()
        self.tabBar.addSubview(separator)
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
