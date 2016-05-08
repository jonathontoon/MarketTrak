//
//  MTMarketViewController.swift
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

class MTSearchField: UITextField {
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
}

class MTMarketViewController: MTViewController, UIGestureRecognizerDelegate {
 
    var previousController: MTViewController! = nil
    
    var marketCommunicator: MTSteamMarketCommunicator!
    var currentSearch: MTSearch!
    var itemResultDataSource: MTItemResultDataSource!
    
    let searchBar = MTSearchField(frame: CGRectMake(0, 0, 400, 30))
    
    var itemSize: CGSize!
    var itemResultsCollectionView: UICollectionView!
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    var itemResultCollectionViewWidth: NSLayoutConstraint!
    var itemResultCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        currentSearch = MTSearch(
            count: 1000
        )
        marketCommunicator.getResultsForSearch(currentSearch)
        
        navigationController?.hidesBarsOnSwipe = true
        title = "Market"
        view.backgroundColor = UIColor.backgroundColor()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_filter_icon"), style: .Done, target: self, action: "openFilters")
        
        navigationItem.titleView = searchBar
        searchBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        searchBar.textColor = UIColor.whiteColor()
        searchBar.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search for items...", attributes: [NSForegroundColorAttributeName : UIColor.metaTextColor()])
        searchBar.layer.cornerRadius = 5
        searchBar.keyboardAppearance = .Dark
        searchBar.returnKeyType = .Search
        searchBar.autocorrectionType = .No
        searchBar.clearButtonMode = .WhileEditing
        
        itemSize = CGSizeMake(view.frame.size.width/2, (view.frame.size.width/2)/0.75)
        
        collectionViewFlowLayout.itemSize = CGSize(width: itemSize.width, height: itemSize.height)
        collectionViewFlowLayout.scrollDirection = .Vertical
        collectionViewFlowLayout.headerReferenceSize = CGSizeMake(view.frame.size.width, 44)
    
        itemResultsCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionViewFlowLayout)
        itemResultsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(itemResultsCollectionView)
        
        itemResultsCollectionView.delegate = self
        itemResultsCollectionView.dataSource = self
        itemResultsCollectionView.registerClass(MTSearchResultCell.self, forCellWithReuseIdentifier: "MTSearchResultCell")
        itemResultsCollectionView.registerClass(MTSegmentHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MTSortSearchResultsView")
        itemResultsCollectionView.backgroundColor = UIColor.backgroundColor()
        itemResultsCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        itemResultsCollectionView.contentInset = UIEdgeInsetsMake(4, 0, 5, 0)
        itemResultsCollectionView.autoPinEdge(.Top, toEdge: .Top, ofView: self.view)
        itemResultsCollectionView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        itemResultCollectionViewWidth = itemResultsCollectionView.autoSetDimension(.Width, toSize: 0)
        itemResultCollectionViewHeight = itemResultsCollectionView.autoSetDimension(.Height, toSize: 0)
    }

    override func viewWillLayoutSubviews() {
        itemResultCollectionViewWidth.constant = self.view.frame.size.width
        itemResultCollectionViewHeight.constant = self.view.frame.size.height
        itemResultsCollectionView.layoutIfNeeded()
        itemResultsCollectionView.contentOffset = CGPointMake(0, 39)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        canScrollToTop = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        canScrollToTop = false
    }
    
    func openFilters() {
        let filterNavigationController = MTNavigationViewController(rootViewController: MTFilterViewController())
        self.navigationController?.presentViewController(filterNavigationController, animated: true, completion: nil)
    }
    
    func scrollToTop() {
        itemResultsCollectionView.setContentOffset(CGPoint(x: 0, y: -20), animated: true)
    }
}

extension MTMarketViewController: MTSteamMarketCommunicatorDelegate {
    
    func searchResultsReturnedSuccessfully(searchResults: [MTItem]!) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.itemResultDataSource = MTItemResultDataSource(items: searchResults)
            
            dispatch_async(dispatch_get_main_queue(),{
                self.itemResultsCollectionView.reloadData()
            })
        })
    }
}

extension MTMarketViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let item = itemsDataSource[indexPath.row]

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
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let segmentHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "MTSortSearchResultsView", forIndexPath: indexPath) as! MTSegmentHeaderView
        
            segmentHeaderView.delegate = self
        
        return segmentHeaderView
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let resultViewController = MTItemViewController(item: itemsDataSource[indexPath.row])
        
        dispatch_async(dispatch_get_main_queue(),{
            self.navigationController!.pushViewController(resultViewController, animated: true)
        })
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsDataSource == nil ? 0 : itemsDataSource.count
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

extension MTMarketViewController: MTSegmentHeaderViewDelegate {
    
    func didChangeSegmentIndex(index: Int) {
        print(index)
    }
}

extension MTMarketViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        let rootViewController = (viewController as! MTNavigationViewController).viewControllers[0] as! MTViewController
        
        if let p = previousController {
            
            if p == rootViewController {
                scrollToTop()
            }
        }
        
        previousController = rootViewController
    }
    
}