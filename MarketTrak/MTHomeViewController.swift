//
//  MTHomeViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 9/30/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kanna
import UIColor_Hex_Swift
import SDWebImage
import PureLayout
import NYSegmentedControl

class MTHomeViewController: UIViewController {
    
    let bottomNavigationBar = UIView.newAutoLayoutView()
    let leftButton = UIButton.newAutoLayoutView()
    let rightButton = UIButton.newAutoLayoutView()
    
    var segmentedControl: NYSegmentedControl!
    
    var marketCommunicator: MTSteamMarketCommunicator!
    var currentSearch: MTSearch!
    var popularItemsDataSource: [MTItem]!
    var watchedItemsDataSource: [MTItem]!
    
    var itemSize: CGSize!
    var itemResultsCollectionView: UICollectionView!
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    var itemResultCollectionViewWidth: NSLayoutConstraint!
    var itemResultCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = UIColor.backgroundColor()
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        currentSearch = MTSearch(
            count: 1000
        )
        marketCommunicator.getResultsForSearch(currentSearch)
        
        watchedItemsDataSource = []
        
        itemSize = CGSizeMake(view.frame.size.width/2, (view.frame.size.width/2)/0.75)
        
        collectionViewFlowLayout.itemSize = CGSize(width: itemSize.width, height: itemSize.height)
        collectionViewFlowLayout.scrollDirection = .Vertical
    
        itemResultsCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionViewFlowLayout)
        itemResultsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(itemResultsCollectionView)
        
        itemResultsCollectionView.delegate = self
        itemResultsCollectionView.dataSource = self
        itemResultsCollectionView.registerClass(MTSearchResultCell.self, forCellWithReuseIdentifier: "MTSearchResultCell")
        itemResultsCollectionView.backgroundColor = UIColor.backgroundColor()
        itemResultsCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 65.0, 0)
        itemResultsCollectionView.contentInset = UIEdgeInsetsMake(-20.0, 0, 72.0, 0)
        itemResultsCollectionView.autoPinEdge(.Top, toEdge: .Top, ofView: self.view, withOffset: 20)
        itemResultsCollectionView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        itemResultCollectionViewWidth = itemResultsCollectionView.autoSetDimension(.Width, toSize: 0)
        itemResultCollectionViewHeight = itemResultsCollectionView.autoSetDimension(.Height, toSize: 0)
        
        view.addSubview(bottomNavigationBar)
        bottomNavigationBar.backgroundColor = UIColor.searchResultCellColor()
        bottomNavigationBar.layer.shadowColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        bottomNavigationBar.layer.shadowRadius = 0.0
        bottomNavigationBar.layer.shadowOpacity = 1.0
        bottomNavigationBar.layer.shadowOffset = CGSizeMake(0, (UIScreen.mainScreen().scale * 0.25) * -1)
        
        segmentedControl = NYSegmentedControl(items: ["Popular", "Watchlist"])
        bottomNavigationBar.addSubview(segmentedControl)
        segmentedControl.titleFont = UIFont.systemFontOfSize(13, weight: UIFontWeightMedium)
        segmentedControl.cornerRadius = 16
        segmentedControl.segmentIndicatorBackgroundColor = UIColor.appTintColor()
        segmentedControl.segmentIndicatorBorderColor = segmentedControl.segmentIndicatorBackgroundColor
        segmentedControl.segmentIndicatorBorderWidth = 0
        segmentedControl.segmentIndicatorInset = 3
        segmentedControl.backgroundColor = UIColor.backgroundColor()
        segmentedControl.borderColor = UIColor.clearColor()
        segmentedControl.titleTextColor = UIColor.appTintColor()
        segmentedControl.selectedTitleTextColor = UIColor.whiteColor()
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MTHomeViewController.segmentChanged(_:)), forControlEvents: .ValueChanged)
       
        bottomNavigationBar.addSubview(leftButton)
        leftButton.setImage(UIImage(named: "search_icon")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        leftButton.tintColor = UIColor.appTintColor()
        leftButton.setTitleColor(leftButton.tintColor, forState: .Normal)
        leftButton.setTitleColor(leftButton.tintColor.colorWithAlphaComponent(0.5), forState: .Highlighted)
        
        bottomNavigationBar.addSubview(rightButton)
        rightButton.setImage(UIImage(named: "inventory_icon")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        rightButton.tintColor = UIColor.appTintColor()
        rightButton.setTitleColor(rightButton.tintColor, forState: .Normal)
        rightButton.setTitleColor(rightButton.tintColor.colorWithAlphaComponent(0.5), forState: .Highlighted)
    }

    override func viewWillLayoutSubviews() {
        itemResultCollectionViewWidth.constant = self.view.frame.size.width
        itemResultCollectionViewHeight.constant = self.view.frame.size.height - 20
        itemResultsCollectionView.layoutIfNeeded()
        
        bottomNavigationBar.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self.view)
        bottomNavigationBar.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        bottomNavigationBar.autoPinEdge(.Right, toEdge: .Right, ofView: self.view)
        bottomNavigationBar.autoSetDimension(.Height, toSize:  50)
        
        segmentedControl.autoSetDimensionsToSize(CGSizeMake(200, 33))
      
        segmentedControl.autoAlignAxis(.Vertical, toSameAxisOfView: bottomNavigationBar)
        segmentedControl.autoAlignAxis(.Horizontal, toSameAxisOfView: bottomNavigationBar)
        
        leftButton.autoPinEdge(.Left, toEdge: .Left, ofView: bottomNavigationBar, withOffset: 15)
        leftButton.autoAlignAxisToSuperviewAxis(.Horizontal)
        leftButton.autoSetDimensionsToSize(CGSizeMake(26, 26))
        
        rightButton.autoPinEdge(.Right, toEdge: .Right, ofView: bottomNavigationBar, withOffset: -15)
        rightButton.autoAlignAxisToSuperviewAxis(.Horizontal)
        rightButton.autoSetDimensionsToSize(CGSizeMake(26, 26))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

extension MTHomeViewController {
    
    func segmentChanged(sender: UISegmentedControl) {
        
//        if sender.selectedSegmentIndex == 0 {
//            marketCommunicator.getResultsForSearch(currentSearch)
//        }
        
        dispatch_async(dispatch_get_main_queue(),{
            self.itemResultsCollectionView.reloadData()
        })
    }

}

extension MTHomeViewController: MTSteamMarketCommunicatorDelegate {
    
    func searchResultsReturnedSuccessfully(searchResults: [MTItem]!) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.popularItemsDataSource = searchResults
            
            dispatch_async(dispatch_get_main_queue(),{
                self.itemResultsCollectionView.reloadData()
            })
        })
    }
}

extension MTHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: itemSize.width, height: itemSize.height)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = popularItemsDataSource[indexPath.row]
        
        var cell: MTSearchResultCell! = collectionView.dequeueReusableCellWithReuseIdentifier("MTSearchResultCell", forIndexPath: indexPath) as! MTSearchResultCell
        
        if cell == nil {
            cell = MTSearchResultCell.newAutoLayoutView()
        }
        
        dispatch_async(dispatch_get_main_queue(),{
            cell.renderCellContentForItem(item, indexPath: indexPath)
            cell.layoutSubviews()
        })
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let resultViewController = MTItemViewController(item: popularItemsDataSource[indexPath.row])
        
        dispatch_async(dispatch_get_main_queue(),{
            self.navigationController!.pushViewController(resultViewController, animated: true)
        })
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if segmentedControl.selectedSegmentIndex == 1 {
            return watchedItemsDataSource == nil ? 0 : watchedItemsDataSource.count
        }
        
        return popularItemsDataSource == nil ? 0 : popularItemsDataSource.count
    }
}