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
    var itemResultDataSource: [MTItem]!
    
    let searchBar = MTSearchField.newAutoLayoutView()
    
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
        
        view.backgroundColor = UIColor.backgroundColor()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_filter_icon"), style: .Done, target: self, action: #selector(MTMarketViewController.openFilters))
        
        navigationController?.navigationBar.addSubview(searchBar)
        searchBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        searchBar.textColor = UIColor.whiteColor()
        searchBar.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search for items...", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor().colorWithAlphaComponent(0.3)])
        searchBar.layer.cornerRadius = 5
        searchBar.keyboardAppearance = .Dark
        searchBar.returnKeyType = .Search
        searchBar.autocorrectionType = .No
        searchBar.clearButtonMode = .WhileEditing
        searchBar.delegate = self
        searchBar.autoSetDimension(.Height, toSize: 30)
        searchBar.autoPinEdge(.Left, toEdge: .Left, ofView: (navigationController?.navigationBar)!, withOffset: 8)
        searchBar.autoPinEdge(.Right, toEdge: .Right, ofView: (navigationController?.navigationBar)!, withOffset: -61)
        searchBar.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: (navigationController?.navigationBar)!, withOffset: -8)
        
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

extension MTMarketViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let queryFilter = MTFilter()
            queryFilter.category = "query"
            queryFilter.name = "Keyword"
        
        let filterOption = MTFilterOption()
            filterOption.name = textField.text
            filterOption.tag = textField.text!+"&descriptions=1"
            queryFilter.options = [filterOption]
        
        currentSearch = MTSearch(filters: [queryFilter])
        marketCommunicator.getResultsForSearch(currentSearch)
        
        
        return true
    }
    
}

extension MTMarketViewController: MTSteamMarketCommunicatorDelegate {
    
    func searchResultsReturnedSuccessfully(searchResults: [MTItem]!) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.itemResultDataSource = searchResults
            
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
        let item = itemResultDataSource[indexPath.row]

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
        let resultViewController = MTItemViewController(item: itemResultDataSource[indexPath.row])
        
        dispatch_async(dispatch_get_main_queue(),{
            self.navigationController!.pushViewController(resultViewController, animated: true)
        })
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemResultDataSource == nil ? 0 : itemResultDataSource.count
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
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