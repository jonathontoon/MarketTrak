//
//  MTWatchlistViewController.swift
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

class MTWatchlistViewController: MTViewController, UIGestureRecognizerDelegate {
 
    var previousController: MTViewController! = nil
    
    var marketCommunicator: MTSteamMarketCommunicator!
    var currentSearch: MTSearch!
    var watchListDataSource: [MTItem]! = []
    var inventoryDataSource: [MTItem]! = []
    
    var itemSize: CGSize!
    var itemResultsCollectionView: UICollectionView!
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    var itemResultsCollectionViewWidth: NSLayoutConstraint!
    var itemResultsCollectionViewHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        currentSearch = MTSearch()
        marketCommunicator.getResultsForSearch(currentSearch)
    
        title = nil
        view.backgroundColor = UIColor.backgroundColor()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        itemSize = CGSizeMake(view.frame.size.width/2, (view.frame.size.width/2) + 74)
        
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
        itemResultsCollectionView.delaysContentTouches = false
        itemResultsCollectionView.alwaysBounceVertical = true
        itemResultsCollectionView.autoPinEdge(.Top, toEdge: .Top, ofView: self.view)
        itemResultsCollectionView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        itemResultsCollectionViewWidth = itemResultsCollectionView.autoSetDimension(.Width, toSize: 0)
        itemResultsCollectionViewHeight = itemResultsCollectionView.autoSetDimension(.Height, toSize: 0)
        
        showLoadingIndicator()
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

extension MTWatchlistViewController: MTSteamMarketCommunicatorDelegate {
    
    func returnResultsForSearch(searchResults: [MTItem]) {
        hideLoadingIndicator()
        
        dispatch_async(dispatch_get_main_queue()) {
            self.watchListDataSource = searchResults
            self.itemResultsCollectionView.reloadData()
        }
    }
    
    func returnResultForItem(itemResult: MTItem) {
        hideLoadingIndicator()
        //dump(itemResult)
    }
}

extension MTWatchlistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        cell.delegate = self
        
        dispatch_async(dispatch_get_main_queue(),{
            cell.renderCellContentForItem(item, indexPath: indexPath)
            cell.layoutSubviews()
        })
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        showLoadingIndicator()
        
        let item = watchListDataSource[indexPath.row]
        marketCommunicator.getResultForItem(item)
        
//        let webViewController = MTWebViewController(item: item)
//        let navigationController = MTNavigationViewController(rootViewController: webViewController)
//        self.presentViewController(navigationController, animated: true, completion: nil)
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return watchListDataSource == nil ? 0 : watchListDataSource.count
    }
}

extension MTWatchlistViewController: MTSearchResultCellDelegate {
    
    func didTapSearchResultCellFooter(item: MTItem) {
        dispatch_async(dispatch_get_main_queue(),{
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            alertController.addAction(UIAlertAction(title: "View Sale Prices", style: .Default, handler: {
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