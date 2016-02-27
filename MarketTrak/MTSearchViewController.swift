//
//  MTSearchViewController.swift
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
import SnapKit
import MGSwipeTableCell
import TUSafariActivity
import DGElasticPullToRefresh
import CLTokenInputView

class MTSearchViewController: UIViewController {
    
    var marketCommunicator: MTSteamMarketCommunicator!
    var currentSearch: MTSearch!
    var searchResultsDataSource: [MTListedItem]!
    
    var itemSize: CGSize!
    var searchResultsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.title = "Market"
        self.view.backgroundColor = UIColor.backgroundColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        currentSearch = MTSearch(
            count: 1000
        )
        marketCommunicator.getResultsForSearch(currentSearch)
        
        if self.view.frame.size.width == 320.0 {
            itemSize = CGSize(width: self.view.frame.size.width/2, height: 216.0)
        } else if self.view.frame.size.width == 375.0 {
            itemSize = CGSize(width: self.view.frame.size.width/2, height: 238.0)
        } else {
            itemSize = CGSize(width: self.view.frame.size.width/2, height: 256.0)
        }
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: itemSize.width, height: itemSize.height)
            collectionViewFlowLayout.scrollDirection = .Vertical
        
        searchResultsCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionViewFlowLayout)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.registerClass(MTSearchResultCell.self, forCellWithReuseIdentifier: "MTSearchResultCell")
        searchResultsCollectionView.backgroundColor = UIColor.backgroundColor()
        searchResultsCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 65.0, 0)
        searchResultsCollectionView.contentInset = UIEdgeInsetsMake(0.0, 0, 95.0, 0)
        
        self.view.addSubview(searchResultsCollectionView)

        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
            loadingView.tintColor = UIColor.appTintColor()
        searchResultsCollectionView.dg_setPullToRefreshFillColor(UIColor.tableViewSeparatorColor())
        searchResultsCollectionView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            self!.marketCommunicator.getResultsForSearch(self!.currentSearch)
            self!.searchResultsCollectionView.dg_stopLoading()
        }, loadingView: loadingView)
        
        let view = UIView(frame: CGRectMake(0.0, 0.0, self.view.frame.size.width, 20.0))
            view.backgroundColor = UIColor.navigationBarColor()
        let currentWindow = UIApplication.sharedApplication().keyWindow
            currentWindow?.addSubview(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

extension MTSearchViewController: MTSteamMarketCommunicatorDelegate {
    
    func searchResultsReturnedSuccessfully(searchResults: [MTListedItem]!) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.searchResultsDataSource = searchResults
            //dump(self.searchResultsDataSource)
            
            dispatch_async(dispatch_get_main_queue(),{
                self.searchResultsCollectionView.reloadData()
            })
        })
    }
}

extension MTSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let item = searchResultsDataSource[indexPath.row]
        
        var cell: MTSearchResultCell! = collectionView.dequeueReusableCellWithReuseIdentifier("MTSearchResultCell", forIndexPath: indexPath) as! MTSearchResultCell
        if cell == nil {
            cell = MTSearchResultCell(frame: CGRectMake(0.0, 0.0, self.view.frame.size.width/2, (self.view.frame.size.width/2) * 1.225))
        }
        
        //cell.delegate = self
        cell.renderCellContentForItem(item, indexPath: indexPath, resultCount: searchResultsDataSource.count)
        cell.layoutSubviews()
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let resultViewController = MTItemViewController()
            resultViewController.item = searchResultsDataSource[indexPath.row]
            resultViewController.imageRatio = (itemSize.width - 20.0) / ((itemSize.width - 20.0) * 0.84)
        
        dispatch_async(dispatch_get_main_queue(),{
            self.navigationController!.pushViewController(resultViewController, animated: true)
        })
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultsDataSource == nil ? 0 : searchResultsDataSource.count
    }
}

extension MTSearchViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let velocity = scrollView.panGestureRecognizer.velocityInView(self.view)
        print(velocity.y)
        if velocity.y > 250.0 {
            if scrollView.panGestureRecognizer.translationInView(scrollView.superview).y > 0 {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        } else if velocity.y < -1800.0 {
            if scrollView.panGestureRecognizer.translationInView(scrollView.superview).y < 0 {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }
    }
    
}