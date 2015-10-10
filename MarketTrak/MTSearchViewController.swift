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
        
        self.definesPresentationContext = true
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        marketCommunicator.getResultsForSearch(
            MTSearch(
                count: 1000
            )
        )
        
        searchResultsTableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.registerClass(MTSearchResultCell.self, forCellReuseIdentifier: "MTSearchResultCell")
        searchResultsTableView.backgroundColor = UIColor(rgba: "#131313")
        searchResultsTableView.separatorColor = UIColor(rgba: "#2A2A2A")
        searchResultsTableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        searchResultsTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 65, 0)
        
        self.view.addSubview(searchResultsTableView)
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search for Skins and more..."
        searchBar.tintColor = UIColor.whiteColor()
        searchBar.keyboardAppearance = UIKeyboardAppearance.Dark
        
        let searchField = searchBar.valueForKey("_searchField") as! UITextField
            searchField.backgroundColor = UIColor(rgba: "#171717")
            searchField.textColor = UIColor.whiteColor()
            (searchField.leftView as! UIImageView).image = (searchField.leftView as! UIImageView).image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            (searchField.leftView as! UIImageView).tintColor = searchField.textColor!.colorWithAlphaComponent(0.25)
        
        let placeholderText = searchField.valueForKey("_placeholderLabel") as! UILabel
            placeholderText.textColor = searchField.textColor!.colorWithAlphaComponent(0.25)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        let superview = self.navigationController!.view
        
        searchBar.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(superview).offset(10)
            make.width.equalTo(superview).offset(-20)
            make.height.equalTo(44.0)
            make.top.equalTo(superview).offset(18)
        }
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
            self.searchResultsTableView.reloadData()
        })
    }
    
    // UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
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
            cell.textLabel?.text = searchResultsDataSource[indexPath.row].name
            cell.textLabel?.textColor = UIColor(rgba: searchResultsDataSource[indexPath.row].textColor!)
            cell.imageView!.image = searchResultsDataSource[indexPath.row].imageView.image
            cell.backgroundColor = UIColor(rgba: "#171717")
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
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
            searchBarCancelButtonClicked(searchBar)
        }
    }
    
    // UISearchBarDelegate

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        marketCommunicator.getResultsForSearch(
            MTSearch(
                query: searchBar.text!,
                count: 100
            )
        )
        
        searchBarTextDidEndEditing(searchBar)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBarTextDidEndEditing(searchBar)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}

