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

class MTSearchViewController: UIViewController, MTSteamMarketCommunicatorDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UISearchBarDelegate {

    var marketCommunicator: MTSteamMarketCommunicator!
    var searchResultsDataSource: [MTListingItem]!
    
    var searchBar: UISearchBar!
    
    var searchResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor()
        self.navigationController?.navigationBar.tintColor = UIColor.greenTintColor()
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
            searchField.backgroundColor = UIColor.blackColor()
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
        searchResultsTableView.backgroundColor = UIColor.blackColor()
        searchResultsTableView.separatorColor = UIColor.tableViewSeparatorColor()
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
        
        let item = searchResultsDataSource[indexPath.row]
        
        var cell: MTSearchResultCell! = tableView.dequeueReusableCellWithIdentifier("MTSearchResultCell", forIndexPath: indexPath) as! MTSearchResultCell
        
            if cell == nil {
                cell = MTSearchResultCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MTSearchResultCell")
            }
        
            cell.itemImageViewMask = UIImageView(frame: CGRectMake(15.0, 15.0, 75.0, 75.0))
            cell.itemImageViewMask.image = UIImage(named: "gradientImage")
            cell.itemImageViewMask.layer.cornerRadius = 3.0
            cell.itemImageViewMask.clipsToBounds = true
        
            cell.addSubview(cell.itemImageViewMask)
        
            // Item Image
            cell.itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 75.0, 75.0))

            // Resize images to fit
            if item.type == Type.Container || item.type == Type.Gift || item.type == Type.Key || item.type == Type.MusicKit || item.type == Type.Pass {
                cell.itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 110.0, 110.0))
            } else if item.type == Type.Rifle {
                cell.itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 75.0, 75.0))
            } else if item.type == Type.Sticker {
                cell.itemImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 230.0, 230.0))
            }
        
            cell.itemImageView.backgroundColor = UIColor.clearColor()
            cell.itemImageView.layer.cornerRadius = 4.0
            cell.itemImageView.center = CGPointMake(cell.itemImageViewMask.frame.size.width/2, cell.itemImageViewMask.frame.size.height/2)
        
            cell.itemImageViewMask.addSubview(cell.itemImageView)
        
            cell.setNeedsLayout()
        
            let downloadManager = SDWebImageManager()

            cell.imageOperation = downloadManager.downloadImageWithURL(
                searchResultsDataSource[indexPath.row].imageURL!,
                options: SDWebImageOptions.RetryFailed,
                progress: nil,
                completed: {
            
                (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, finished: Bool, imageURL: NSURL!) in
                
                if image != nil {
                    
                    cell.itemImageView.image = image
                    cell.setNeedsLayout()
                    
                    let transition = CATransition()
                        transition.duration = 0.25
                        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                        transition.type = kCATransitionFade
        
                    cell.itemImageView.layer.addAnimation(transition, forKey: nil)
                }
                
            })
        
            // Item Price
            cell.itemPriceLabel = UILabel()
            cell.itemPriceLabel.text = (item.price! as NSString).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            cell.itemPriceLabel.textColor = UIColor.greenTintColor()
            cell.itemPriceLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightMedium)
            cell.itemPriceLabel.sizeToFit()
        
            cell.itemPriceLabel.frame = CGRectMake(105.0, cell.itemImageViewMask.frame.origin.y + 5.0, self.view.frame.size.width - 145.0, cell.itemPriceLabel.frame.size.height)
        
            if item.quality == Quality.None || item.quality == nil {
                cell.itemPriceLabel.frame = CGRectMake(105.0, cell.itemImageViewMask.frame.origin.y + 14.0, self.view.frame.size.width - 145.0, cell.itemPriceLabel.frame.size.height)
            }
        
            cell.addSubview(cell.itemPriceLabel)
        
            // Skin Name
            cell.itemNameLabel = UILabel()
            cell.itemNameLabel.text = searchResultsDataSource[indexPath.row].skinName!
        
            if item.exterior != nil && item.exterior != Exterior.None {
                cell.itemNameLabel.text =  cell.itemNameLabel.text! + " (" + item.exterior!.stringDescription() + ")"
            }
        
            cell.itemNameLabel.textColor = UIColor.whiteColor()
            cell.itemNameLabel.font = UIFont.systemFontOfSize(15.0, weight: UIFontWeightMedium)
            cell.itemNameLabel.sizeToFit()
            cell.itemNameLabel.frame = CGRectMake(105.0, cell.itemPriceLabel.frame.origin.y + cell.itemPriceLabel.frame.size.height, self.view.frame.size.width - 145.0, cell.itemNameLabel.frame.size.height)
            
            cell.addSubview(cell.itemNameLabel)
        
            // Skin Meta
            cell.itemMetaLabel = UILabel()
        
            if item.type == Type.Gift || item.type == Type.MusicKit || item.type == Type.Pass {
                
                
            } else if item.type == Type.Container {
                
                if item.tournament != nil && item.tournament != Tournament.None {
                    
                    cell.itemMetaLabel.text = item.tournament!.stringDescription()
                    
                    if item.containedItems != nil && item.containedItems!.count > 0 {
                        
                        cell.itemMetaLabel.text = (item.containedItems!.count.description + " Items • " + item.tournament!.stringDescription()).uppercaseString
                        
                    }
                    
                }
                
                if item.collection != nil && item.collection != Collection.None {
                    
                    cell.itemMetaLabel.text = item.collection!.stringDescription()
                    
                    if item.containedItems != nil {
                        
                        cell.itemMetaLabel.text = (item.containedItems!.count.description + " Items • " + item.collection!.stringDescription()).uppercaseString
                        
                    }
                    
                }
                
            } else if item.type == Type.Sticker {
                
                if item.stickerCollection != nil && item.stickerCollection != StickerCollection.None {
                    
                    cell.itemMetaLabel.text = item.stickerCollection!.stringDescription().uppercaseString
                    
                }
                
                if item.tournament != nil && item.tournament != Tournament.None {
                    
                    cell.itemMetaLabel.text = item.tournament!.stringDescription().uppercaseString
                }
                
            } else if item.type == Type.Key || item.type == Type.Tag {
            
                if item.usage != nil && item.usage != "" {
                    cell.itemMetaLabel.text = item.usage!.uppercaseString
                    
                }
            
            } else {
                
                if item.weapon != nil && item.weapon != Weapon.None && item.collection != nil && item.collection != Collection.None {
                
                    cell.itemMetaLabel.text = item.weapon!.stringDescription().uppercaseString + " • " + item.collection!.stringDescription().uppercaseString
                
                } else if item.weapon != nil {
                    
                    cell.itemMetaLabel.text = item.weapon!.stringDescription().uppercaseString
                
                } else if item.collection != nil {
                
                    cell.itemMetaLabel.text = item.collection!.stringDescription().uppercaseString
                
                }
                
            }
        
            cell.itemMetaLabel.textColor = UIColor.metaTextColor()
            cell.itemMetaLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightRegular)
            cell.itemMetaLabel.sizeToFit()
            cell.itemMetaLabel.frame = CGRectMake(105.0, cell.itemNameLabel.frame.origin.y + cell.itemNameLabel.frame.size.height + 2.0, self.view.frame.size.width - 145.0, cell.itemMetaLabel.frame.size.height)
        
            cell.addSubview(cell.itemMetaLabel)
        
            // Category Tag
            if item.category != nil && item.category != Category.None && item.category != nil && item.category != Category.Normal {
            
                cell.itemCategoryLabel = UILabel()
                cell.itemCategoryLabel.text = item.category!.stringDescription()
                cell.itemCategoryLabel.textColor = item.category!.colorForCategory()
                cell.itemCategoryLabel.font = UIFont.systemFontOfSize(8.0, weight: UIFontWeightBold)
                cell.itemCategoryLabel.textAlignment = NSTextAlignment.Center
                cell.itemCategoryLabel.layer.borderColor = item.category!.colorForCategory().CGColor
                cell.itemCategoryLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                cell.itemCategoryLabel.sizeToFit()
                cell.itemCategoryLabel.clipsToBounds = true
                cell.itemCategoryLabel.frame = CGRectMake(105.0, cell.itemMetaLabel.frame.origin.y + cell.itemMetaLabel.frame.size.height + 4.0, cell.itemCategoryLabel.frame.size.width + 12.0, cell.itemCategoryLabel.frame.size.height + 6.0)
                cell.itemCategoryLabel.layer.cornerRadius = cell.itemCategoryLabel.frame.size.height/2
                
                cell.addSubview(cell.itemCategoryLabel)
            }
        
            // Quality Tag
            if item.quality != Quality.None && item.quality != nil {
                
                cell.itemQualityLabel = UILabel()
                cell.itemQualityLabel.text = item.quality!.stringDescription()
                cell.itemQualityLabel.textColor = item.quality!.colorForQuality()
                cell.itemQualityLabel.font = UIFont.systemFontOfSize(8.0, weight: UIFontWeightBold)
                cell.itemQualityLabel.textAlignment = NSTextAlignment.Center
                cell.itemQualityLabel.layer.borderColor = item.quality!.colorForQuality().CGColor
                cell.itemQualityLabel.layer.borderWidth = (1.0 / UIScreen.mainScreen().scale) * 2.0
                cell.itemQualityLabel.sizeToFit()
                cell.itemQualityLabel.clipsToBounds = true
                
                if cell.itemCategoryLabel != nil {
 
                    cell.itemQualityLabel.frame = CGRectMake(cell.itemCategoryLabel.frame.origin.x + cell.itemCategoryLabel.frame.size.width + 4.0, cell.itemMetaLabel.frame.origin.y + cell.itemMetaLabel.frame.size.height + 4.0, cell.itemQualityLabel.frame.size.width + 12.0, cell.itemQualityLabel.frame.size.height + 6.0)
                
                } else {
                    
                    cell.itemQualityLabel.frame = CGRectMake(105.0, cell.itemMetaLabel.frame.origin.y + cell.itemMetaLabel.frame.size.height + 4.0, cell.itemQualityLabel.frame.size.width + 12.0, cell.itemQualityLabel.frame.size.height + 6.0)
                    
                }
                
                cell.itemQualityLabel.layer.cornerRadius = cell.itemQualityLabel.frame.size.height/2
                
                cell.addSubview(cell.itemQualityLabel)
            }
        
            cell.backgroundColor = UIColor.tableViewCellColor()
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
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
            resultViewController.title = searchResultsDataSource[indexPath.row].skinName
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

