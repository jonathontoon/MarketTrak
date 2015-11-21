//
//  MTFilterSearchViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 11/15/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTFilterSearchViewController: UIViewController {

    var halfModal: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        
        halfModal = UIView(frame: CGRectMake(0.0, self.view.frame.size.height, self.view.frame.size.width, round(self.view.frame.size.height * 0.8)))
        halfModal.backgroundColor = UIColor.tableViewCellColor()
        
        let navigationBar = UINavigationBar()
            navigationBar.barTintColor = UIColor.navigationBarColor()
            navigationBar.tintColor = UIColor.greenTintColor()
            navigationBar.translucent = false
            navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName: UIColor.greenTintColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(17.0, weight: UIFontWeightMedium)
            ]
            navigationBar.items = [UINavigationItem(title: self.title!)]
            navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "filteringDone")
            navigationBar.sizeToFit()
        halfModal.addSubview(navigationBar)
        
        let path = UIBezierPath(roundedRect:halfModal.bounds, byRoundingCorners:[UIRectCorner.TopRight, UIRectCorner.TopLeft], cornerRadii: CGSizeMake(5, 5))
        
        let maskLayer = CAShapeLayer()
            maskLayer.path = path.CGPath
        halfModal.layer.mask = maskLayer
        
        self.view.addSubview(halfModal)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.25, animations: {
            
            self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75)
            self.halfModal.frame = CGRectMake(0.0, self.view.frame.size.height - round(self.view.frame.size.height * 0.8), self.view.frame.size.width, round(self.view.frame.size.height * 0.8))
            
        }, completion: nil)
    }
    
    func filteringDone() {
        
        UIView.animateWithDuration(0.25, animations: {
            
            self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
            self.halfModal.frame = CGRectMake(0.0, self.view.frame.size.height, self.view.frame.size.width, round(self.view.frame.size.height * 0.8))
            
        }, completion: {
            
            finished in
            
            self.dismissViewControllerAnimated(false, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
