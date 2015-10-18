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
import UIImage_ImageWithColor

class MTSearchViewController: UIViewController, MTSteamMarketCommunicatorDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate {

    var marketCommunicator: MTSteamMarketCommunicator!
    var searchResultsDataSource: [MTListingItem]!
    
    var searchBar: UISearchBar!
    
    var searchResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#292929")
        self.navigationController?.navigationBar.tintColor = UIColor(rgba: "#8ac33e")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.definesPresentationContext = true
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        marketCommunicator.getResultsForSearch(
            MTSearch(
                count: 500
            )
        )
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search for Skins and more..."
        searchBar.tintColor = UIColor(rgba: "#8ac33e")
        searchBar.keyboardAppearance = UIKeyboardAppearance.Dark
        
        let searchField = searchBar.valueForKey("_searchField") as! UITextField
        searchField.backgroundColor = UIColor(rgba: "#171717")
        searchField.textColor = UIColor.whiteColor()
        (searchField.leftView as! UIImageView).image = (searchField.leftView as! UIImageView).image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        (searchField.leftView as! UIImageView).tintColor = searchField.textColor!.colorWithAlphaComponent(0.25)
        
        let placeholderText = searchField.valueForKey("_placeholderLabel") as! UILabel
        placeholderText.textColor = searchField.textColor!.colorWithAlphaComponent(0.25)
        
        self.navigationItem.titleView = searchBar
        
        searchResultsTableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.registerClass(MTSearchResultCell.self, forCellReuseIdentifier: "MTSearchResultCell")
        searchResultsTableView.backgroundColor = UIColor(rgba: "#131313")
        searchResultsTableView.separatorColor = UIColor(rgba: "#2A2A2A")
        searchResultsTableView.contentInset = UIEdgeInsetsMake(1, 0, 100, 0)
        searchResultsTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 65, 0)
        
        self.view.addSubview(searchResultsTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MTSteamMarketCommunicatorDelegate
    
    func searchResultsReturnedSuccessfully(searchResults: [MTListingItem]!) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        dispatch_async(dispatch_get_main_queue(), {
            self.searchResultsDataSource = searchResults
            self.searchResultsTableView.setContentOffset(CGPointZero, animated: false)
            self.searchResultsTableView.reloadData()
        })
    }
    
    // UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: MTSearchResultCell = tableView.dequeueReusableCellWithIdentifier("MTSearchResultCell", forIndexPath: indexPath) as! MTSearchResultCell
            cell.textLabel?.text = searchResultsDataSource[indexPath.row].skinName
            cell.textLabel?.textColor = UIColor(rgba: searchResultsDataSource[indexPath.row].textColor!)
            cell.textLabel!.font = UIFont.systemFontOfSize(16.0)
        
            cell.imageView!.image = UIImage(named: "placeholder")
            cell.imageView!.frame = CGRectMake(0.0, cell.imageView!.frame.origin.y, cell.imageView!.frame.size.width, cell.imageView!.frame.size.height)
            cell.imageView!.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.04)
            cell.imageView!.layer.cornerRadius = 2.0
            cell.setNeedsLayout()
        
            let downloadManager = SDWebImageManager()

            cell.imageOperation = downloadManager.downloadImageWithURL(
                searchResultsDataSource[indexPath.row].imageURL!,
                options: SDWebImageOptions.RetryFailed,
                progress: nil,
                completed: {
            
                (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, finished: Bool, imageURL: NSURL!) in
                
                if image != nil {
                    
                    cell.imageView!.image = image
                    cell.setNeedsLayout()
                    
                    let transition = CATransition()
                        transition.duration = 0.25
                        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                        transition.type = kCATransitionFade
        
                    cell.imageView!.layer.addAnimation(transition, forKey: nil)
                }
                
            })
        
            cell.backgroundColor = UIColor(rgba: "#171717")
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.selectedBackgroundView = UIView(frame: cell.frame)
            cell.selectedBackgroundView?.backgroundColor = UIColor(rgba: "#1D1D1D")
        
            //if searchResultsDataSource[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // Remove seperator inset
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        // Explictly set your cell's layout margins
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("didSelectRowAtIndexPath")
        
        let resultViewController = MTItemViewController()
            resultViewController.title = searchResultsDataSource[indexPath.row].skinName
        
            resultViewController.marketCommunicator = MTSteamMarketCommunicator()
            resultViewController.marketCommunicator.delegate = resultViewController
            resultViewController.marketCommunicator.getResultsForItem(searchResultsDataSource[indexPath.row])
        
        self.navigationController?.pushViewController(resultViewController, animated: true)
        
    }
    
    // UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsDataSource == nil ? 0 : searchResultsDataSource.count
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // UIScrollViewDelegate
   
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if searchResultsTableView == scrollView {
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.resignFirstResponder()
        }
    }
    
    // UISearchBarDelegate

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
      
        dispatch_async(dispatch_get_main_queue(), {
            self.marketCommunicator.getResultsForSearch(
                MTSearch(
                    query: searchBar.text!,
                    count: 500
                )
            )
            
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.resignFirstResponder()
        })
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        dispatch_async(dispatch_get_main_queue(), {
            searchBar.setShowsCancelButton(true, animated: true)
        })
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        if searchBar.text?.characters.count == 0 {
            
            marketCommunicator.getResultsForSearch(
                MTSearch(
                    count: 500
                )
            )
            
        }
        
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}

