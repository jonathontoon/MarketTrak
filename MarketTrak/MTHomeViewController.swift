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

class MTHomeViewController: MTViewController, UIGestureRecognizerDelegate {
 
    var previousController: MTViewController! = nil
    
    let bottomNavigationBar = UIView.newAutoLayoutView()
    var segmentedControl: NYSegmentedControl!
    let leftButton = UIButton.newAutoLayoutView()
    let rightButton = UIButton.newAutoLayoutView()

    var marketCommunicator: MTSteamMarketCommunicator!
    var currentSearch: MTSearch!
    var watchListDataSource: [MTItem]! = []
    var inventoryDataSource: [MTItem]! = []
    
    var itemSize: CGSize!
    var itemResultsCollectionView: UICollectionView!
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    var itemResultCollectionViewWidth: NSLayoutConstraint!
    var itemResultCollectionViewHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        currentSearch = MTSearch()
        marketCommunicator.getResultsForSearch(currentSearch)
    
        title = nil
        view.backgroundColor = UIColor.backgroundColor()
        navigationController?.setNavigationBarHidden(true, animated: false)

        itemSize = CGSizeMake(view.frame.size.width/2, (view.frame.size.width/2) + 112)
        
        collectionViewFlowLayout.itemSize = CGSize(width: itemSize.width, height: itemSize.height)
        collectionViewFlowLayout.scrollDirection = .Vertical
    
        itemResultsCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionViewFlowLayout)
        itemResultsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(itemResultsCollectionView)
        
        itemResultsCollectionView.delegate = self
        itemResultsCollectionView.dataSource = self
        itemResultsCollectionView.registerClass(MTSearchResultCell.self, forCellWithReuseIdentifier: "MTSearchResultCell")
        itemResultsCollectionView.backgroundColor = UIColor.backgroundColor()
        itemResultsCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        itemResultsCollectionView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0)
        itemResultsCollectionView.autoPinEdge(.Top, toEdge: .Top, ofView: self.view)
        itemResultsCollectionView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        itemResultCollectionViewWidth = itemResultsCollectionView.autoSetDimension(.Width, toSize: 0)
        itemResultCollectionViewHeight = itemResultsCollectionView.autoSetDimension(.Height, toSize: 0)
        
        view.addSubview(bottomNavigationBar)
        bottomNavigationBar.backgroundColor = UIColor.searchResultCellColor()
        bottomNavigationBar.layer.shadowColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        bottomNavigationBar.layer.shadowRadius = 0.0
        bottomNavigationBar.layer.shadowOpacity = 1.0
        bottomNavigationBar.layer.shadowOffset = CGSizeMake(0, (1.0 / UIScreen.mainScreen().scale) * -1)
        
        segmentedControl = NYSegmentedControl(items: ["Watchlist", "Inventory"])
        bottomNavigationBar.addSubview(segmentedControl)
        segmentedControl.titleFont = UIFont.systemFontOfSize(13, weight: UIFontWeightMedium)
        segmentedControl.cornerRadius = 5
        segmentedControl.segmentIndicatorBackgroundColor = UIColor.appTintColor()
        segmentedControl.segmentIndicatorBorderColor = segmentedControl.segmentIndicatorBackgroundColor
        segmentedControl.segmentIndicatorBorderWidth = 0
        segmentedControl.segmentIndicatorInset = 3
        segmentedControl.backgroundColor = UIColor.backgroundColor()
        segmentedControl.borderColor = UIColor.clearColor()
        segmentedControl.titleTextColor = UIColor.appTintColor()
        segmentedControl.selectedTitleTextColor = UIColor.whiteColor()
        segmentedControl.selectedTitleFont = UIFont.systemFontOfSize(13, weight: UIFontWeightMedium)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MTHomeViewController.segmentChanged(_:)), forControlEvents: .ValueChanged)

        bottomNavigationBar.addSubview(leftButton)
        leftButton.setImage(UIImage(named: "market_icon")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        leftButton.imageView?.contentMode = .ScaleAspectFit
        leftButton.tintColor = UIColor.appTintColor()
        leftButton.setTitleColor(leftButton.tintColor, forState: .Normal)
        leftButton.setTitleColor(leftButton.tintColor.colorWithAlphaComponent(0.5), forState: .Highlighted)
        leftButton.addTarget(self, action: #selector(MTHomeViewController.presentSearchViewController), forControlEvents: .TouchUpInside)
        
        bottomNavigationBar.addSubview(rightButton)
        rightButton.setImage(UIImage(named: "settings_icon")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        rightButton.imageView?.contentMode = .ScaleAspectFit
        rightButton.tintColor = UIColor.appTintColor()
        rightButton.setTitleColor(rightButton.tintColor, forState: .Normal)
        rightButton.setTitleColor(rightButton.tintColor.colorWithAlphaComponent(0.5), forState: .Highlighted)

    }

    override func viewWillLayoutSubviews() {
        itemResultCollectionViewWidth.constant = self.view.frame.size.width
        itemResultCollectionViewHeight.constant = self.view.frame.size.height
        itemResultsCollectionView.layoutIfNeeded()

        bottomNavigationBar.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self.view)
        bottomNavigationBar.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        bottomNavigationBar.autoPinEdge(.Right, toEdge: .Right, ofView: self.view)
        bottomNavigationBar.autoSetDimension(.Height, toSize:  50)
        
        segmentedControl.autoSetDimensionsToSize(CGSizeMake(200, 33))
        
        segmentedControl.autoAlignAxis(.Vertical, toSameAxisOfView: bottomNavigationBar)
        segmentedControl.autoAlignAxis(.Horizontal, toSameAxisOfView: bottomNavigationBar)
        
        var offset: CGFloat = 10
        if view.frame.size.width > 320 {
            offset = 15
        }
        
        leftButton.autoPinEdge(.Left, toEdge: .Left, ofView: bottomNavigationBar, withOffset: offset)
        leftButton.autoPinEdge(.Right, toEdge: .Left, ofView: segmentedControl, withOffset: -offset)
        leftButton.autoAlignAxis(.Horizontal, toSameAxisOfView: bottomNavigationBar, withOffset: 0.5)
        leftButton.autoSetDimensionsToSize(CGSizeMake(52, 26))
        
        rightButton.autoPinEdge(.Left, toEdge: .Right, ofView: segmentedControl, withOffset: offset)
        rightButton.autoPinEdge(.Right, toEdge: .Right, ofView: bottomNavigationBar, withOffset: -offset)
        rightButton.autoAlignAxis(.Horizontal, toSameAxisOfView: bottomNavigationBar, withOffset: 0.5)
        rightButton.autoSetDimensionsToSize(CGSizeMake(52, 26))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        canScrollToTop = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        canScrollToTop = false
    }
    
    func segmentChanged(segmentedControl: NYSegmentedControl) {
        itemResultsCollectionView.reloadData()
    }
    
    func presentSearchViewController() {
        let searchViewController = MTSearchViewController()
        let navigationController = MTNavigationViewController(rootViewController: searchViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}

extension MTHomeViewController: MTSteamMarketCommunicatorDelegate {
    
    func searchResultsReturnedSuccessfully(searchResults: [MTItem]!) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.watchListDataSource = searchResults
            
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
        let item = watchListDataSource[indexPath.row]

        var cell: MTSearchResultCell! = collectionView.dequeueReusableCellWithReuseIdentifier("MTSearchResultCell", forIndexPath: indexPath) as! MTSearchResultCell
        
        if cell == nil {
            cell = MTSearchResultCell(frame: CGRectZero)
        }
        
        dispatch_async(dispatch_get_main_queue(),{
            cell.renderCellContentForItem(item, indexPath: indexPath)
            cell.layoutSubviews()
        })
        
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let resultViewController = MTItemViewController(item: watchListDataSource[indexPath.row])
//        
//        dispatch_async(dispatch_get_main_queue(),{
//            self.navigationController!.pushViewController(resultViewController, animated: true)
//        })
//    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return watchListDataSource == nil ? 0 : watchListDataSource.count
        }
        
        return inventoryDataSource == nil ? 0 : inventoryDataSource.count
    }
    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        
//        if scrollView == searchFilterTableView {
//            searchBar.resignFirstResponder()
//        }
//    }
}