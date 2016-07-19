//
//  MTItemListViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 9/30/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
import SDWebImage
import PureLayout
import TUSafariActivity

class MTItemListViewController: MTViewController, UIGestureRecognizerDelegate {

    var marketCommunicator: MTSteamMarketCommunicator!
    var currentSearch: MTSearch!
    var itemDataSource: [MTItem]! = []
    
    var itemSize: CGSize!
    var itemResultsCollectionView: UICollectionView!
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    var itemResultsCollectionViewWidth: NSLayoutConstraint!
    var itemResultsCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
     
        view.backgroundColor = UIColor.backgroundColor()
        
        itemSize = CGSizeMake(view.frame.size.width/2, (view.frame.size.width/2) + 74)
        
        collectionViewFlowLayout.itemSize = CGSize(width: itemSize.width, height: itemSize.height)
        collectionViewFlowLayout.scrollDirection = .Vertical
        
        itemResultsCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionViewFlowLayout)
        itemResultsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(itemResultsCollectionView)
        
        itemResultsCollectionView.delegate = self
        itemResultsCollectionView.dataSource = self
        itemResultsCollectionView.registerClass(MTItemCell.self, forCellWithReuseIdentifier: "MTItemCell")
        itemResultsCollectionView.backgroundColor = UIColor.backgroundColor()
        itemResultsCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        itemResultsCollectionView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0)
        itemResultsCollectionView.delaysContentTouches = false
        itemResultsCollectionView.alwaysBounceVertical = true
        itemResultsCollectionView.autoPinEdge(.Top, toEdge: .Top, ofView: self.view)
        itemResultsCollectionView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        itemResultsCollectionViewWidth = itemResultsCollectionView.autoSetDimension(.Width, toSize: 0)
        itemResultsCollectionViewHeight = itemResultsCollectionView.autoSetDimension(.Height, toSize: 0)
    }
    
    override func viewWillLayoutSubviews() {
        itemResultsCollectionViewWidth.constant = view.frame.size.width
        itemResultsCollectionViewHeight.constant = view.frame.size.height
        itemResultsCollectionView.layoutIfNeeded()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

extension MTItemListViewController: MTSteamMarketCommunicatorDelegate {
    
    func returnResultsForSearch(searchResults: [MTItem]) {
        hideLoadingIndicator()
        
        dispatch_async(dispatch_get_main_queue()) {
            self.itemDataSource = searchResults
            self.itemResultsCollectionView.reloadData()
        }
    }
    
    func returnResultForItem(itemResult: MTItem) {
        hideLoadingIndicator()
        
        let itemPriceHistoryViewController = MTItemPriceHistoryViewController(item: itemResult)
        let navigationController = MTNavigationViewController(rootViewController: itemPriceHistoryViewController)
        self.navigationController?.presentViewController(navigationController, animated: true, completion: nil)
    }
}

extension MTItemListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let item = itemDataSource[indexPath.row]
        
        var cell: MTItemCell! = collectionView.dequeueReusableCellWithReuseIdentifier("MTItemCell", forIndexPath: indexPath) as! MTItemCell
        
        if cell == nil {
            cell = MTItemCell(frame: CGRectZero)
        }
        
        cell.delegate = self
        
        dispatch_async(dispatch_get_main_queue(),{
            cell.renderCellContentForItem(item, indexPath: indexPath)
            cell.layoutSubviews()
        })
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
  
        let itemSelected = itemDataSource[indexPath.row]
        let addItemToWatchList = MTAddItemToWatchListViewController(item: itemSelected)
        let navigationController = MTNavigationViewController(rootViewController: addItemToWatchList)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemDataSource == nil ? 0 : itemDataSource.count
    }
}

extension MTItemListViewController: MTItemCellDelegate {
    
    func didTapSearchResultCellFooter(item: MTItem) {
        dispatch_async(dispatch_get_main_queue(),{
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            alertController.addAction(UIAlertAction(title: "View Price History", style: .Default, handler: {
                (action) in
                self.showLoadingIndicator()
                self.marketCommunicator.getResultForItem(item)
            }))
            alertController.addAction(UIAlertAction(title: "Share This Item", style: .Default, handler: {
                (action) in
                
                let itemURL: NSURL = item.itemURL
                let applicationActivities: [UIActivity] = [TUSafariActivity()]
                let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [itemURL], applicationActivities: applicationActivities)
                
                activityViewController.excludedActivityTypes = [
                    UIActivityTypePrint,
                    UIActivityTypeAssignToContact,
                    UIActivityTypeSaveToCameraRoll,
                    UIActivityTypePostToFlickr,
                    UIActivityTypePostToVimeo,
                    UIActivityTypePostToTencentWeibo
                ]
                self.presentViewController(activityViewController, animated: true, completion: nil)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        })
    }
}