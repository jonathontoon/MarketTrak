//
//  MTSegmentedViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 6/12/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTSegmentedViewController: MTViewController {
    
    let watchListViewController = MTWatchlistViewController()
    let inventoryViewController = MTViewController()
    
    var childView = UIView.newAutoLayoutView()
    
    let bottomNavigationBar = UIView.newAutoLayoutView()
    var segmentedControl: UISegmentedControl!
    let leftButton = UIButton.newAutoLayoutView()
    let rightButton = UIButton.newAutoLayoutView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChildViewController(watchListViewController)
        watchListViewController.view.frame = view.frame
        childView = watchListViewController.view
        watchListViewController.didMoveToParentViewController(self)
        
        self.addChildViewController(inventoryViewController)
        inventoryViewController.view.frame = view.frame
        inventoryViewController.view.backgroundColor = .yellowColor()
        inventoryViewController.didMoveToParentViewController(self)
        
        view.addSubview(bottomNavigationBar)
        bottomNavigationBar.backgroundColor = UIColor.searchResultCellColor()
        bottomNavigationBar.layer.shadowColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        bottomNavigationBar.layer.shadowRadius = 0.0
        bottomNavigationBar.layer.shadowOpacity = 1.0
        bottomNavigationBar.layer.shadowOffset = CGSizeMake(0, (1.0 / UIScreen.mainScreen().scale) * -1)
        
        segmentedControl = UISegmentedControl(items: ["Watchlist", "Inventory"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor.appTintColor()
        segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.appTintColor(), NSFontAttributeName: UIFont.systemFontOfSize(13, weight: UIFontWeightMedium)], forState: .Normal)
        segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.navigationBarColor(), NSFontAttributeName: UIFont.systemFontOfSize(13, weight: UIFontWeightMedium)], forState: .Selected)
        segmentedControl.addTarget(self, action: #selector(MTSegmentedViewController.selectedSegment), forControlEvents: .ValueChanged)
        bottomNavigationBar.addSubview(segmentedControl)
        
        bottomNavigationBar.addSubview(leftButton)
        leftButton.setImage(UIImage(named: "market_icon")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        leftButton.imageView?.contentMode = .ScaleAspectFit
        leftButton.tintColor = UIColor.appTintColor()
        leftButton.setTitleColor(leftButton.tintColor, forState: .Normal)
        leftButton.setTitleColor(leftButton.tintColor.colorWithAlphaComponent(0.5), forState: .Highlighted)
        leftButton.addTarget(self, action: #selector(MTSegmentedViewController.presentSearchViewController), forControlEvents: .TouchUpInside)
        
        bottomNavigationBar.addSubview(rightButton)
        rightButton.setImage(UIImage(named: "settings_icon_stroke")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        rightButton.imageView?.contentMode = .ScaleAspectFit
        rightButton.tintColor = UIColor.appTintColor()
        rightButton.setTitleColor(rightButton.tintColor, forState: .Normal)
        rightButton.setTitleColor(rightButton.tintColor.colorWithAlphaComponent(0.5), forState: .Highlighted)
        rightButton.addTarget(self, action: #selector(MTSegmentedViewController.presentSettingsViewController), forControlEvents: .TouchUpInside)
        
        let topView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 20))
            topView.backgroundColor = UIColor.searchResultCellColor()
        self.view.addSubview(topView)
        
        selectedSegment()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        bottomNavigationBar.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view)
        bottomNavigationBar.autoPinEdge(.Left, toEdge: .Left, ofView: view)
        bottomNavigationBar.autoPinEdge(.Right, toEdge: .Right, ofView: view)
        bottomNavigationBar.autoSetDimension(.Height, toSize:  50)
        
        segmentedControl.autoSetDimensionsToSize(CGSizeMake(view.frame.size.width*0.54, 27))
        segmentedControl.autoAlignAxis(.Vertical, toSameAxisOfView: bottomNavigationBar)
        segmentedControl.autoAlignAxis(.Horizontal, toSameAxisOfView: bottomNavigationBar)
        
        var offset: CGFloat = 10
        if view.frame.size.width > 320 {
            offset = 20
        }
        
        leftButton.autoPinEdge(.Left, toEdge: .Left, ofView: bottomNavigationBar, withOffset: 0)
        leftButton.autoPinEdge(.Right, toEdge: .Left, ofView: segmentedControl, withOffset: -offset)
        leftButton.autoAlignAxis(.Horizontal, toSameAxisOfView: bottomNavigationBar, withOffset: 0.5)
        leftButton.autoSetDimension(.Height, toSize: 26)
        
        rightButton.autoPinEdge(.Left, toEdge: .Right, ofView: segmentedControl, withOffset: offset)
        rightButton.autoPinEdge(.Right, toEdge: .Right, ofView: bottomNavigationBar, withOffset: 0)
        rightButton.autoAlignAxis(.Horizontal, toSameAxisOfView: bottomNavigationBar, withOffset: 0.5)
        rightButton.autoSetDimension(.Height, toSize: 26)
    }
    
    func selectedSegment() {
        
        childView.removeFromSuperview()
        childView = UIView.newAutoLayoutView()
        
        if segmentedControl.selectedSegmentIndex == 0 {
            childView = watchListViewController.view
        } else {
            childView = inventoryViewController.view
        }
        
        view.insertSubview(childView, atIndex: 0)
        childView.autoPinEdge(.Top, toEdge: .Top, ofView: view, withOffset: 20)
        childView.autoPinEdge(.Left, toEdge: .Left, ofView: view)
        childView.autoPinEdge(.Right, toEdge: .Right, ofView: view)
        childView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view)
        
    }
    
    func presentSearchViewController() {
        let searchViewController = MTSearchViewController()
        let navigationController = MTNavigationViewController(rootViewController: searchViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func presentSettingsViewController() {
        let searchViewController = MTSettingsViewController()
        let navigationController = MTNavigationViewController(rootViewController: searchViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}
