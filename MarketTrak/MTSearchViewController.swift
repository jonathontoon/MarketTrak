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
import TUSafariActivity
import PureLayout

class MTSearchViewController: UIViewController {
    
    var marketCommunicator: MTSteamMarketCommunicator!
    var currentSearch: MTSearch!
    var searchResultsDataSource: [MTItem]!
    
    var itemSize: CGSize!
    var searchResultsCollectionView: UICollectionView!
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    var searchResultCollectionViewWidth: NSLayoutConstraint!
    var searchResultCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.topItem!.title = "Market"
        navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor()
        navigationController?.navigationBar.backgroundColor = UIColor.navigationBarColor()
        navigationController?.navigationBar.translucent = false
        
        view.backgroundColor = UIColor.backgroundColor()
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        currentSearch = MTSearch(
            count: 1000
        )
        marketCommunicator.getResultsForSearch(currentSearch)
        
        itemSize = CGSizeMake(view.frame.size.width/2, (view.frame.size.width/2)/0.75)
        
        collectionViewFlowLayout.itemSize = CGSize(width: itemSize.width, height: itemSize.height)
        collectionViewFlowLayout.scrollDirection = .Vertical
    
        searchResultsCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionViewFlowLayout)
        searchResultsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.registerClass(MTSearchResultCell.self, forCellWithReuseIdentifier: "MTSearchResultCell")
        searchResultsCollectionView.backgroundColor = UIColor.backgroundColor()
        searchResultsCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 65.0, 0)
        searchResultsCollectionView.contentInset = UIEdgeInsetsMake(0.0, 0, 95.0, 0)
        searchResultsCollectionView.autoPinEdge(.Top, toEdge: .Top, ofView: self.view)
        searchResultsCollectionView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        searchResultCollectionViewWidth = searchResultsCollectionView.autoSetDimension(.Width, toSize: 0)
        searchResultCollectionViewHeight = searchResultsCollectionView.autoSetDimension(.Height, toSize: 0)
    }

    override func viewWillLayoutSubviews() {
        searchResultCollectionViewWidth.constant = self.view.frame.size.width
        searchResultCollectionViewHeight.constant = self.view.frame.size.height
        searchResultsCollectionView.layoutIfNeeded()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        (UIApplication.sharedApplication().delegate as! AppDelegate).overlayView.backgroundColor = UIColor.navigationBarColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

extension MTSearchViewController: MTSteamMarketCommunicatorDelegate {
    
    func searchResultsReturnedSuccessfully(searchResults: [MTItem]!) {
        
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
            cell = MTSearchResultCell.newAutoLayoutView()
        }
        
        dispatch_async(dispatch_get_main_queue(),{
            cell.renderCellContentForItem(item, indexPath: indexPath)
            cell.layoutSubviews()
        })
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let resultViewController = MTItemViewController(item: searchResultsDataSource[indexPath.row])
        
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
        let velocity = scrollView.panGestureRecognizer.velocityInView(view)
        print(velocity.y)
        if velocity.y > 250.0 {
            if scrollView.panGestureRecognizer.translationInView(scrollView.superview).y > 0 {
                navigationController?.setNavigationBarHidden(false, animated: true)
            }
        } else if velocity.y < -1800.0 {
            if scrollView.panGestureRecognizer.translationInView(scrollView.superview).y < 0 {
                navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }
    }
    
}