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
import TITokenField

class MTSearchViewController: UIViewController {
    
    var marketCommunicator: MTSteamMarketCommunicator!
    var currentSearch: MTSearch!
    var searchResultsDataSource: [MTListingItem]!
    
    var searchBar: TITokenFieldView!
    
    var optionsToolbar: UIView!
    
    var searchResultsTableView: UITableView!
    
    var searchFilterCollectionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        self.title = "Search"
        self.view.backgroundColor = UIColor.backgroundColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.navigationController!.setNavigationBarHidden(true, animated: false)
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        currentSearch = MTSearch(
            count: 1000
        )
        marketCommunicator.getResultsForSearch(currentSearch)
        
        let searchNavigationBar = UIView(frame: CGRectMake(0.0, 0.0, self.view.frame.size.width, 74.0))
            searchNavigationBar.backgroundColor = UIColor.navigationBarColor()
        
        searchResultsTableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        searchResultsTableView.frame.origin.y = searchNavigationBar.frame.size.height - 20.0
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.registerClass(MTSearchResultCell.self, forCellReuseIdentifier: "MTSearchResultCell")
        searchResultsTableView.backgroundColor = UIColor.backgroundColor()
        searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        searchResultsTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 65.0, 0)
        searchResultsTableView.contentInset = UIEdgeInsetsMake(0.0, 0, 95.0, 0)
        searchResultsTableView.separatorColor = UIColor.tableViewSeparatorColor()
        searchResultsTableView.tableFooterView = UIView(frame: CGRectMake(0.0, 0.0, self.view.frame.size.width, 0.1))
        
        self.view.addSubview(searchResultsTableView)
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.appTintColor()
        searchResultsTableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            self!.marketCommunicator.getResultsForSearch(self!.currentSearch)
            self!.searchResultsTableView.dg_stopLoading()
            }, loadingView: loadingView)
        
        searchResultsTableView.dg_setPullToRefreshFillColor(UIColor.navigationBarColor())
        searchResultsTableView.dg_setPullToRefreshBackgroundColor(UIColor.tableViewCellColor())
        
        searchFilterCollectionView = UIView(frame: self.view.frame)
        searchFilterCollectionView.frame.origin.y = searchNavigationBar.frame.size.height
        searchFilterCollectionView.backgroundColor = UIColor.tableViewCellColor()
        searchFilterCollectionView.alpha = 0.0
        self.view.addSubview(searchFilterCollectionView)
 
        searchBar = TITokenFieldView(frame: CGRectMake(10.0, 26.0, self.view.frame.size.width - 20.0, 36.0))
        searchBar.backgroundColor = UIColor.clearColor()
        searchBar.layer.cornerRadius = 5.0
        searchBar.delegate = self
        searchBar.tokenField.delegate = self
        searchBar.tokenField.font = UIFont.systemFontOfSize(12.0, weight: UIFontWeightRegular)
        searchBar.tokenField.backgroundColor = UIColor.searchBarColor()
        searchBar.tokenField.textColor = UIColor.whiteColor()
        searchBar.tokenField.tintColor = UIColor.searchBarPlaceholderColor()
        searchBar.tokenField.keyboardType = UIKeyboardType.Default
        searchBar.tokenField.keyboardAppearance = UIKeyboardAppearance.Dark
        searchBar.tokenField.setPromptText("    ")
        searchBar.tokenField.placeholder = "Search for items..."
        searchBar.separator.backgroundColor = UIColor.clearColor()
        
        let magnifyingGlass = UIImageView(image: UIImage(named: "magnifyingGlass")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate))
        magnifyingGlass.tintColor = UIColor.appTintColor()
        magnifyingGlass.sizeToFit()
        magnifyingGlass.frame = CGRectMake(0.0, magnifyingGlass.frame.origin.y, magnifyingGlass.frame.size.width, magnifyingGlass.frame.size.height)
        
        let paddingView = UIView(frame: magnifyingGlass.frame)
            paddingView.frame.size = CGSizeMake(magnifyingGlass.frame.size.width + 5.0, magnifyingGlass.frame.size.height + 5.0)
            magnifyingGlass.center = paddingView.center
            paddingView.addSubview(magnifyingGlass)
        
        searchBar.tokenField.leftView = paddingView
        
        searchNavigationBar.addSubview(searchBar)
        self.view.addSubview(searchNavigationBar)
    }
    
    override func viewWillAppear(animated: Bool) {
        
//        if self.navigationController!.navigationBar.hidden {
//            self.navigationController!.setNavigationBarHidden(false, animated: false)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

extension MTSearchViewController: MTSteamMarketCommunicatorDelegate {
    
    func searchResultsReturnedSuccessfully(searchResults: [MTListingItem]!) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.searchResultsDataSource = searchResults
            self.searchResultsTableView.reloadData()
        })
    }
}

extension MTSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 105.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRectZero)
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRectZero)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let item = searchResultsDataSource[indexPath.row]
        var cell: MTSearchResultCell! = tableView.dequeueReusableCellWithIdentifier("MTSearchResultCell", forIndexPath: indexPath) as! MTSearchResultCell
        
        if cell == nil {
            cell = MTSearchResultCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MTSearchResultCell")
        }
        
        cell.delegate = self
        cell.renderCellContentForItem(item, indexPath: indexPath, resultCount: searchResultsDataSource.count)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // Remove seperator inset
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsMake(0.0, 15.0, 0.0, 0.0)
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        // Explictly set your cell's layout margins
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsMake(0.0, 15.0, 0.0, 0.0)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let resultViewController = MTItemViewController()
        resultViewController.title = (tableView.cellForRowAtIndexPath(indexPath) as! MTSearchResultCell).itemNameLabel.text
        resultViewController.marketCommunicator = MTSteamMarketCommunicator()
        resultViewController.marketCommunicator.delegate = resultViewController
        resultViewController.marketCommunicator.getResultsForItem(searchResultsDataSource[indexPath.row])
        
        self.navigationController?.pushViewController(resultViewController, animated: true)
        
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        (tableView.cellForRowAtIndexPath(indexPath) as! MTSearchResultCell).backgroundColor = UIColor.tableViewCellHighlightedColor()
    }
    
    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        (tableView.cellForRowAtIndexPath(indexPath) as! MTSearchResultCell).backgroundColor = UIColor.tableViewCellColor()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsDataSource == nil ? 0 : searchResultsDataSource.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
}

extension MTSearchViewController: MGSwipeTableCellDelegate {
    
    func swipeTableCell(cell: MGSwipeTableCell!, swipeButtonsForDirection direction: MGSwipeDirection, swipeSettings: MGSwipeSettings!, expansionSettings: MGSwipeExpansionSettings!) -> [AnyObject]! {
        
        swipeSettings.transition = MGSwipeTransition.ClipCenter
        
        expansionSettings.fillOnTrigger = false
        expansionSettings.threshold = 1
        expansionSettings.buttonIndex = 0
        
        if direction == MGSwipeDirection.RightToLeft {
            
            let trackButton = MGSwipeButton(title: "Track", backgroundColor: UIColor.priceTintColor(), callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                print("Track")
                return true
            })
            
            trackButton.titleLabel?.font = UIFont.systemFontOfSize(14.0, weight: UIFontWeightRegular)
            trackButton.frame = CGRectMake(trackButton.frame.origin.x, trackButton.frame.origin.y, cell.frame.size.height - 10.0, cell.frame.size.height)
            
            return [trackButton]
            
        } else if direction == MGSwipeDirection.LeftToRight {
            
            let shareButton = MGSwipeButton(title: "Share", backgroundColor: UIColor.rowActionShareButtonColor(), callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                
                let activityViewController = UIActivityViewController(
                    activityItems: [self.searchResultsDataSource[self.searchResultsTableView.indexPathForCell(cell)!.row].itemName, self.searchResultsDataSource[self.searchResultsTableView.indexPathForCell(cell)!.row].itemURL],
                    applicationActivities: [TUSafariActivity()]
                )
                
                if #available(iOS 9, *) {
                    activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeOpenInIBooks, UIActivityTypeAddToReadingList]
                } else {
                    activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList]
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.navigationController!.presentViewController(activityViewController, animated: true, completion: nil)
                })
                
                return true
            })
            
            shareButton.titleLabel?.font = UIFont.systemFontOfSize(14.0, weight: UIFontWeightRegular)
            shareButton.frame = CGRectMake(shareButton.frame.origin.x, shareButton.frame.origin.y, cell.frame.size.height - 10.0, cell.frame.size.height)
            
            return [shareButton]
        }
        
        return []
        
    }
    
}

extension MTSearchViewController: TITokenFieldDelegate {
    
    func tokenField(tokenField: TITokenField!, willAddToken token: TIToken!) -> Bool {
        
        //token.tintColor = UIColor.starItemColor()
        //token.textColor = token.tintColor
        //token.backgroundColor = token.tintColor
        
        return true
    }
    
    func tokenField(tokenField: TITokenField!, didAddToken token: TIToken!) {
        print("Added")
        
        dispatch_async(dispatch_get_main_queue(), {
            self.currentSearch = MTSearch(
                query: token.title,
                count: 1000
            )
            self.marketCommunicator.getResultsForSearch(self.currentSearch)
            
            //self.searchBar.resignFirstResponder()
        })

    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.25, animations: {
            self.searchFilterCollectionView.alpha = 1.0
        })
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        
//        return true
//    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if searchBar.tokenField.text?.characters.count == 0 {
            currentSearch =  MTSearch(
                count: 1000
            )
            marketCommunicator.getResultsForSearch(currentSearch)
            
        }
        
        UIView.animateWithDuration(0.25, animations: {
            self.searchFilterCollectionView.alpha = 0.0
        })
        
        searchBar.resignFirstResponder()
        
        return true
    }
}
extension MTSearchViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if searchResultsTableView == scrollView {
            //searchBar.resignFirstResponder()
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if velocity.y < -0.2 {
            //self.navigationController!.setNavigationBarHidden(false, animated: true)
        } else if velocity.y > 0.7 {
            //self.navigationController!.setNavigationBarHidden(true, animated: true)
        }
    }
}
