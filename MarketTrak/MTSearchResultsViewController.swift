//
//  MTSearchResultsViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/31/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTSearchResultsViewController: MTViewController {
    
    var marketCommunicator: MTSteamMarketCommunicator!
    var searchQuery: MTSearch!
    
    var itemResultsDataSource: [MTItem]! = []
    var numberOfFilters: Int?
    
    var itemSize: CGSize!
    var itemResultsCollectionView: UICollectionView!
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    var itemResultsCollectionViewWidth: NSLayoutConstraint!
    var itemResultsCollectionViewHeight: NSLayoutConstraint!
    
    init(dataSource: [MTItem], numberOfFilters: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.itemResultsDataSource = dataSource
        self.numberOfFilters = numberOfFilters
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        
        view.backgroundColor = UIColor.backgroundColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_button")?.imageWithRenderingMode(.AlwaysTemplate), style: .Plain, target: self, action: #selector(MTSearchResultsViewController.popViewController))
        navigationItem.backBarButtonItem?.tintColor = UIColor.appTintColor()
        navigationController?.interactivePopGestureRecognizer?.enabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        if numberOfFilters != 0 {
        
            let containerTitleView = UIView(frame: CGRectMake(0, 0, 200, 33))
            self.navigationItem.titleView = containerTitleView
            containerTitleView.sizeToFit()
            
            let titleLabel = UILabel()
                titleLabel.text = "Search Results"
                titleLabel.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
                titleLabel.textColor = UIColor.whiteColor()
                titleLabel.textAlignment = .Center
                titleLabel.sizeToFit()
                titleLabel.frame = CGRectMake(0, -1, containerTitleView.frame.size.width, 17)
            containerTitleView.addSubview(titleLabel)
            
            let subTitleLabel = UILabel()
            
                subTitleLabel.text = (numberOfFilters!.description + " Filters Applied").uppercaseString
                if numberOfFilters == 0 {
                    subTitleLabel.text = "No Filters Applied".uppercaseString
                } else if numberOfFilters == 1 {
                    subTitleLabel.text = "1 Filter Applied".uppercaseString
                }
            
                subTitleLabel.font = UIFont.systemFontOfSize(10, weight: UIFontWeightRegular)
                subTitleLabel.textColor = UIColor.subTextColor()
                subTitleLabel.textAlignment = .Center
                subTitleLabel.frame = CGRectMake(0, 18, containerTitleView.frame.size.width, 12)
            containerTitleView.addSubview(subTitleLabel)
               
        } else {
            title = "Popular Items"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_filter_icon")?.imageWithRenderingMode(.AlwaysTemplate), style: .Plain, target: self, action: #selector(MTSearchResultsViewController.presentSortActionSheet))
        
        itemSize = CGSizeMake(view.frame.size.width/2, (view.frame.size.width/2) + 102)
        
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
    }
    
    override func viewWillLayoutSubviews() {
        itemResultsCollectionViewWidth.constant = self.view.frame.size.width
        itemResultsCollectionViewHeight.constant = self.view.frame.size.height
        itemResultsCollectionView.layoutIfNeeded()
    }
    
    func popViewController() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func presentSortActionSheet() {
        let sortActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let sortPriceHighLow = UIAlertAction(title: "Price (High to Low)", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.itemResultsDataSource.sortInPlace({ $0.price > $1.price })
            self.reloadItemResults()
        })
        let sortPriceLowHigh = UIAlertAction(title: "Price (Low to High)", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.itemResultsDataSource.sortInPlace({ $0.price < $1.price })
            self.reloadItemResults()
        })
        let sortQuantityHighLow = UIAlertAction(title: "Quantity (High to Low)", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.itemResultsDataSource.sortInPlace({ $0.quantity > $1.quantity })
            self.reloadItemResults()
            
        })
        let sortQuantityLowHigh = UIAlertAction(title: "Quantity (Low to High)", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.itemResultsDataSource.sortInPlace({ $0.quantity < $1.quantity })
            self.reloadItemResults()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        sortActionSheet.addAction(sortPriceHighLow)
        sortActionSheet.addAction(sortPriceLowHigh)
        sortActionSheet.addAction(sortQuantityHighLow)
        sortActionSheet.addAction(sortQuantityLowHigh)
        sortActionSheet.addAction(cancel)
        
        self.presentViewController(sortActionSheet, animated: true, completion: nil)
    }
    
    func reloadItemResults() {
        self.itemResultsCollectionView.reloadData()
        self.itemResultsCollectionView.setContentOffset(CGPoint(x: 0, y: -5), animated: true)
    }
}

extension MTSearchResultsViewController: MTSteamMarketCommunicatorDelegate {
    
    func searchResultsReturnedSuccessfully(searchResults: [MTItem]!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        dispatch_async(dispatch_get_main_queue(), {
            self.itemResultsDataSource.appendContentsOf(searchResults)
            self.itemResultsCollectionView.reloadData()
            self.hideLoadingIndicator()
        })
    }
}

extension MTSearchResultsViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension MTSearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let item = itemResultsDataSource[indexPath.row]
        
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let item = itemResultsDataSource[indexPath.row]
        
        let webViewController = MTWebViewController(item: item)
        let navigationController = MTNavigationViewController(rootViewController: webViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemResultsDataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if itemResultsDataSource.count % 100 == 0 {
            if indexPath.item == itemResultsDataSource.count-1 {
                searchQuery.start = searchQuery.start + 100
                searchQuery.constructSearchURL()
                marketCommunicator.getResultsForSearch(searchQuery)
                showLoadingIndicator()
            }
        }
    }
}
