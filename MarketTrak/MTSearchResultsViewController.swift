//
//  MTSearchResultsViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/31/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit
import TUSafariActivity

class MTSearchResultsViewController: MTItemListViewController {
    
    var numberOfFilters: Int?
    
    init(dataSource: [MTItem], numberOfFilters: Int) {
        super.init(nibName: nil, bundle: nil)
        
        self.itemDataSource = dataSource
        self.numberOfFilters = numberOfFilters
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_button")?.imageWithRenderingMode(.AlwaysTemplate), style: .Plain, target: self, action: #selector(MTSearchResultsViewController.popViewController))
        navigationItem.backBarButtonItem?.tintColor = UIColor.appTintColor()
        navigationController?.interactivePopGestureRecognizer?.enabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        if numberOfFilters != 0 {
            title = "Search Results"
        } else {
            title = "Popular Items"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_filter_icon")?.imageWithRenderingMode(.AlwaysTemplate), style: .Plain, target: self, action: #selector(MTSearchResultsViewController.presentSortActionSheet))
    }
    
    func popViewController() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func presentSortActionSheet() {
        let sortActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let sortPriceHighLow = UIAlertAction(title: "Price (High to Low)", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.itemDataSource.sortInPlace({ $0.currentPrice?.currencyAmount.intValue > $1.currentPrice?.currencyAmount.intValue })
            self.reloadItemResults()
        })
        let sortPriceLowHigh = UIAlertAction(title: "Price (Low to High)", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.itemDataSource.sortInPlace({ $0.currentPrice?.currencyAmount.intValue < $1.currentPrice?.currencyAmount.intValue })
            self.reloadItemResults()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        sortActionSheet.addAction(sortPriceHighLow)
        sortActionSheet.addAction(sortPriceLowHigh)
        sortActionSheet.addAction(cancel)
        
        self.presentViewController(sortActionSheet, animated: true, completion: nil)
    }
    
    func reloadItemResults() {
        self.itemResultsCollectionView.reloadData()
        self.itemResultsCollectionView.setContentOffset(CGPoint(x: 0, y: -5), animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if itemDataSource.count % 100 == 0 {
            if indexPath.item == itemDataSource.count-1 {
                currentSearch.start = currentSearch.start + 100
                currentSearch.constructSearchURL()
                marketCommunicator.getResultsForSearch(currentSearch)
                showLoadingIndicator()
            }
        }
    }
}