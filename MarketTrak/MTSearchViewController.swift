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
import RTIconButton
import DGElasticPullToRefresh

class MTSearchViewController: UIViewController {

    var marketCommunicator: MTSteamMarketCommunicator!
    var currentSearch: MTSearch!
    var searchResultsDataSource: [MTListingItem]!
    
    var searchBar: MTTintTextField!
    
    var searchResultsTableView: UITableView!
    
    var optionsToolbar: UIView!
    var filterButton: RTIconButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        self.title = "Search"
        self.view.backgroundColor = UIColor.backgroundColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        currentSearch = MTSearch(
            count: 1000
        )
        marketCommunicator.getResultsForSearch(currentSearch)
        
        let width = self.view.frame.size.width >= 414.0 ? self.view.frame.size.width - 32.0 : self.view.frame.size.width - 24.0
        
        searchBar = MTTintTextField(frame: CGRectMake(0.0, 0.0, width * 0.90, 29.0))
        searchBar.attributedPlaceholder = NSAttributedString(
            string: "Search for items...",
            attributes: [
                NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0.5),
                NSFontAttributeName: UIFont.systemFontOfSize(14.0, weight: UIFontWeightRegular)
            ]
        )
        searchBar.font = UIFont.systemFontOfSize(14.0, weight: UIFontWeightRegular)
        searchBar.tintColor = UIColor.searchBarPlaceholderColor()
        searchBar.backgroundColor = UIColor.searchBarColor()
        searchBar.textColor = UIColor.whiteColor()
        searchBar.leftViewMode = UITextFieldViewMode.Always
        searchBar.layer.cornerRadius = 5.0
        searchBar.rightView?.tintColor = UIColor.appTintColor()
        searchBar.clearButtonMode = UITextFieldViewMode.Always
        searchBar.returnKeyType = UIReturnKeyType.Search
        searchBar.keyboardType = UIKeyboardType.Default
        searchBar.keyboardAppearance = UIKeyboardAppearance.Dark
        searchBar.delegate = self
        
        let magnifyingGlass = UIImageView(image: UIImage(named: "magnifyingGlass")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate))
            magnifyingGlass.tintColor = UIColor.appTintColor()
            magnifyingGlass.sizeToFit()
            magnifyingGlass.frame = CGRectMake(7.0, magnifyingGlass.frame.origin.y, magnifyingGlass.frame.size.width, magnifyingGlass.frame.size.height)
        
        let paddingView = UIView(frame: CGRectMake(0.0, 0.0, magnifyingGlass.frame.size.width + 14.0, magnifyingGlass.frame.size.height))
            paddingView.addSubview(magnifyingGlass)
        
        searchBar.leftView = paddingView
        
        filterButton = RTIconButton(frame: CGRectMake(searchBar.frame.size.width + 9.0, 0.0, width * 0.10, searchBar.frame.size.height))
        filterButton.setImage(UIImage(named: "filterIcon")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: UIControlState.Normal)
        filterButton.iconMargin = 4.0
        filterButton.iconPosition = GSIconPosition.Left.rawValue
        filterButton.iconSize = CGSizeMake(23, 19)
        filterButton.layer.cornerRadius = 5.0
        filterButton.backgroundColor = UIColor.navigationBarColor()
        filterButton.addTarget(self, action: "filterButtonDown:", forControlEvents: UIControlEvents.TouchDown)
        filterButton.addTarget(self, action: "filterButtonUpOutside:", forControlEvents: UIControlEvents.TouchUpOutside)
        filterButton.addTarget(self, action: "filterButtonUp:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let searchView = UIView(frame: CGRectMake(0.0, 3.0, self.view.frame.size.width, 29.0))
            searchView.addSubview(searchBar)
            searchView.addSubview(filterButton)
        
        self.navigationItem.titleView = searchView
 
        searchResultsTableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
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
        
        let statusBarView = UIView(frame: CGRectMake(0.0, 0.0, self.view.frame.size.width, 20.0))
            statusBarView.backgroundColor = UIColor.navigationBarColor()
        
        self.navigationController!.view.addSubview(statusBarView)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if self.navigationController!.navigationBar.hidden {
            self.navigationController!.setNavigationBarHidden(false, animated: false)
        }
    }
    
    func filterButtonDown(button: UIButton!) {
        button.tintColor = UIColor.appTintColor().colorWithAlphaComponent(0.8)
        button.setTitleColor(UIColor.appTintColor().colorWithAlphaComponent(0.6), forState: UIControlState.Normal)
    }
    
    func filterButtonUpOutside(button: UIButton!) {
        button.tintColor = UIColor.appTintColor()
        button.setTitleColor(UIColor.appTintColor(), forState: UIControlState.Normal)
    }
    
    func filterButtonUp(button: UIButton!) {
        button.tintColor = UIColor.appTintColor()
        button.setTitleColor(UIColor.appTintColor(), forState: UIControlState.Normal)
        
        let filterViewController = MTFilterSearchViewController()
            filterViewController.title = "Filters"
            filterViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext

        self.navigationController!.tabBarController!.presentViewController(filterViewController, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    deinit {
        searchResultsTableView.dg_removePullToRefresh()
    }
}

extension MTSearchViewController: MTSteamMarketCommunicatorDelegate {
    
    func searchResultsReturnedSuccessfully(searchResults: [MTListingItem]!) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        dispatch_async(dispatch_get_main_queue(), {
            
            if self.navigationController!.navigationBar.hidden {
                self.navigationController!.setNavigationBarHidden(false, animated: false)
            }
            
            self.searchResultsDataSource = searchResults
            self.searchResultsTableView.setContentOffset(CGPointMake(0.0, 0.0), animated: false)

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
        
            cell.itemImageViewMask = UIImageView(frame: CGRectMake(15.0, 15.0, 75.0, 75.0))
            cell.itemImageViewMask.image = UIImage(named: "gradientImage")
            cell.itemImageViewMask.layer.cornerRadius = 3.0
            cell.itemImageViewMask.clipsToBounds = true
        
            cell.contentView.addSubview(cell.itemImageViewMask)
        
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
            cell.itemPriceLabel.textColor = UIColor.priceTintColor()
            cell.itemPriceLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightMedium)
            cell.itemPriceLabel.sizeToFit()
        
            cell.itemPriceLabel.frame = CGRectMake(102.0, cell.itemImageViewMask.frame.origin.y + 4.5, self.view.frame.size.width - 142.0, cell.itemPriceLabel.frame.size.height)
        
            if item.quality == Quality.None || item.quality == nil {
                cell.itemPriceLabel.frame = CGRectMake(102.0, cell.itemImageViewMask.frame.origin.y + 14.0, self.view.frame.size.width - 142.0, cell.itemPriceLabel.frame.size.height)
            }
        
            cell.contentView.addSubview(cell.itemPriceLabel)
        
            // Skin Name
            cell.itemNameLabel = UILabel()
            cell.itemNameLabel.text = searchResultsDataSource[indexPath.row].itemName!
        
            if item.exterior != nil && item.exterior != Exterior.None {
                cell.itemNameLabel.text =  cell.itemNameLabel.text! + " (" + item.exterior!.stringDescription() + ")"
            }
        
            if item.type == Type.MusicKit {
                
                cell.itemNameLabel.text = searchResultsDataSource[indexPath.row].itemName!
                
                if item.artist != nil {
                    cell.itemNameLabel.text = searchResultsDataSource[indexPath.row].itemName! + " " + item.artist!
                }
            }
        
            cell.itemNameLabel.textColor = UIColor.whiteColor()
            cell.itemNameLabel.font = UIFont.systemFontOfSize(15.0, weight: UIFontWeightMedium)
            cell.itemNameLabel.sizeToFit()
            cell.itemNameLabel.frame = CGRectMake(102.0, cell.itemPriceLabel.frame.origin.y + cell.itemPriceLabel.frame.size.height, self.view.frame.size.width - 142.0, cell.itemNameLabel.frame.size.height)
            
            cell.contentView.addSubview(cell.itemNameLabel)
        
            // Skin Meta
            cell.itemMetaLabel = UILabel()
        
            if item.type == Type.MusicKit {
              
                if item.artist != nil {
                    cell.itemMetaLabel.text = item.type!.stringDescription().uppercaseString
                }
                
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
                
            } else if item.type == Type.Key || item.type == Type.Tag || item.type == Type.Pass || item.type == Type.Gift || item.type == Type.Tool {
            
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
            cell.itemMetaLabel.frame = CGRectMake(102.0, cell.itemNameLabel.frame.origin.y + cell.itemNameLabel.frame.size.height + 2.0, self.view.frame.size.width - 142.0, cell.itemMetaLabel.frame.size.height)
        
            cell.contentView.addSubview(cell.itemMetaLabel)
        
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
                cell.itemCategoryLabel.frame = CGRectMake(102.0, cell.itemMetaLabel.frame.origin.y + cell.itemMetaLabel.frame.size.height + 4.0, cell.itemCategoryLabel.frame.size.width + 12.0, cell.itemCategoryLabel.frame.size.height + 6.0)
                cell.itemCategoryLabel.layer.cornerRadius = cell.itemCategoryLabel.frame.size.height/2
                
                cell.contentView.addSubview(cell.itemCategoryLabel)
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
                    
                    cell.itemQualityLabel.frame = CGRectMake(102.0, cell.itemMetaLabel.frame.origin.y + cell.itemMetaLabel.frame.size.height + 4.0, cell.itemQualityLabel.frame.size.width + 12.0, cell.itemQualityLabel.frame.size.height + 6.0)
                    
                }
                
                cell.itemQualityLabel.layer.cornerRadius = cell.itemQualityLabel.frame.size.height/2
                
                cell.contentView.addSubview(cell.itemQualityLabel)
            }
        
            cell.backgroundColor = UIColor.tableViewCellColor()
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        
            if indexPath.row != searchResultsDataSource.count-1 {
                
                cell.separator = UIView(frame: CGRectMake(indexPath.row < searchResultsDataSource.count-1 ? 15.0 : 0.0, cell.frame.size.height - (1.0 / UIScreen.mainScreen().scale), cell.frame.size.width, 1.0 / UIScreen.mainScreen().scale))
                cell.separator.backgroundColor = UIColor.tableViewSeparatorColor()
                cell.addSubview(cell.separator)
                
            }
        
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

extension MTSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        dispatch_async(dispatch_get_main_queue(), {
            self.currentSearch = MTSearch(
                query: self.searchBar.text!,
                count: 1000
            )
            
            self.marketCommunicator.getResultsForSearch(self.currentSearch)
            
            self.searchBar.resignFirstResponder()
        })

        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if searchBar.text?.characters.count == 0 {
            self.currentSearch = MTSearch(
                count: 1000
            )
            
            marketCommunicator.getResultsForSearch(self.currentSearch)
        }
        
        searchBar.resignFirstResponder()
        
        return true
    }
}

extension MTSearchViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if searchResultsTableView == scrollView {
            searchBar.resignFirstResponder()
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        if velocity.y < -0.2 {
            self.navigationController!.setNavigationBarHidden(false, animated: true)
        } else if velocity.y > 0.7 {
            self.navigationController!.setNavigationBarHidden(true, animated: true)
        }
    }
}
