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
        self.navigationController?.navigationBar.barTintColor = UIColor(rgba: "#1A1A1A")
        self.navigationController?.navigationBar.tintColor = UIColor(rgba: "#8ac33e")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.definesPresentationContext = true
        
        self.view.backgroundColor = UIColor(rgba: "#000000")
        
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
        searchField.backgroundColor = UIColor(rgba: "#000000")
        searchField.textColor = UIColor.whiteColor()
        (searchField.leftView as! UIImageView).image = (searchField.leftView as! UIImageView).image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        (searchField.leftView as! UIImageView).tintColor = searchField.textColor!.colorWithAlphaComponent(0.25)
        
        let placeholderText = searchField.valueForKey("_placeholderLabel") as! UILabel
        placeholderText.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        
        self.navigationItem.titleView = searchBar
        
        searchResultsTableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.registerClass(MTSearchResultCell.self, forCellReuseIdentifier: "MTSearchResultCell")
        searchResultsTableView.backgroundColor = UIColor(rgba: "#000000")
        searchResultsTableView.separatorColor = UIColor(rgba: "#363535")
        searchResultsTableView.contentInset = UIEdgeInsetsMake(7, 0, 100, 0)
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
        return 105.0
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
        
        var cell: MTSearchResultCell! = tableView.dequeueReusableCellWithIdentifier("MTSearchResultCell", forIndexPath: indexPath) as! MTSearchResultCell
        
        if cell == nil {
            
            cell = MTSearchResultCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MTSearchResultCell")
            
        }
        
            // Item Image
            cell.skinImageView = UIImageView(frame: CGRectMake(15.0, 15.0, 75.0, 75.0))
            cell.skinImageView.backgroundColor = UIColor(rgba: "#303030")
            cell.skinImageView.layer.cornerRadius = 2.0
        
            cell.addSubview(cell.skinImageView)
        
            cell.setNeedsLayout()
        
            let downloadManager = SDWebImageManager()

            cell.imageOperation = downloadManager.downloadImageWithURL(
                searchResultsDataSource[indexPath.row].imageURL!,
                options: SDWebImageOptions.RetryFailed,
                progress: nil,
                completed: {
            
                (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, finished: Bool, imageURL: NSURL!) in
                
                if image != nil {
                    
                    cell.skinImageView.image = image
                    cell.setNeedsLayout()
                    
                    let transition = CATransition()
                        transition.duration = 0.25
                        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                        transition.type = kCATransitionFade
        
                    cell.skinImageView.layer.addAnimation(transition, forKey: nil)
                }
                
            })
        
            // Item Price
            cell.priceLabel = UILabel()
            cell.priceLabel.text = (searchResultsDataSource[indexPath.row].price! as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            cell.priceLabel.textColor = UIColor(rgba:"#8ac33e")
            cell.priceLabel.font = UIFont.systemFontOfSize(12.0, weight: UIFontWeightBold)
            cell.priceLabel.sizeToFit()
            cell.priceLabel.frame = CGRectMake(105.0, cell.skinImageView.frame.origin.y, self.view.frame.size.width - 140.0, cell.priceLabel.frame.size.height)
        
            cell.addSubview(cell.priceLabel)
        
            // Skin Name
            cell.skinNameLabel = UILabel()
            cell.skinNameLabel.text = searchResultsDataSource[indexPath.row].skinName!
            cell.skinNameLabel.textColor = UIColor.whiteColor()
            cell.skinNameLabel.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightMedium)
            cell.skinNameLabel.sizeToFit()
            cell.skinNameLabel.frame = CGRectMake(105.0, cell.priceLabel.frame.origin.y + cell.priceLabel.frame.size.height, self.view.frame.size.width - 140.0, cell.skinNameLabel.frame.size.height)
            
            cell.addSubview(cell.skinNameLabel)
        
            // Skin Meta
            cell.skinMetaLabel = UILabel()
            cell.skinMetaLabel.text = searchResultsDataSource[indexPath.row].weapon!.stringDescription() + " • " + searchResultsDataSource[indexPath.row].collection!.stringDescription()
            cell.skinMetaLabel.text = cell.skinMetaLabel.text!.uppercaseString
            cell.skinMetaLabel.textColor = UIColor(rgba: "#6C6C6C")
            cell.skinMetaLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightMedium)
            cell.skinMetaLabel.sizeToFit()
            cell.skinMetaLabel.frame = CGRectMake(105.0, cell.skinNameLabel.frame.origin.y + cell.skinNameLabel.frame.size.height + 2.0, self.view.frame.size.width - 140.0, cell.skinMetaLabel.frame.size.height)
        
            cell.addSubview(cell.skinMetaLabel)
        
            cell.backgroundColor = UIColor(rgba: "#1A1A1A")
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.selectedBackgroundView = UIView(frame: cell.frame)
            cell.selectedBackgroundView?.backgroundColor = UIColor(rgba: "#1D1D1D")
        
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

