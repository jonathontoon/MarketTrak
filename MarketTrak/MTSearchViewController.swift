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
    var searchResultsDataSource: [MTListingItem]!
    var searchResultsTableView: UITableView!
    
    var searchBar: CLTokenInputView!
    
    var optionsToolbar: UIView!
    
    var searchFilterTableView: UITableView!
    var searchFilterDataSource: [Any]! = [Any]()
    
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
        
        let searchNavigationBar = UIView(frame: CGRectMake(0.0, 0.0, self.view.frame.size.width, 64.0))
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
        
        searchFilterTableView = UITableView(frame: self.view.frame)
        searchFilterTableView.delegate = self
        searchFilterTableView.dataSource = self
        searchFilterTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MTFilterCell")
        searchFilterTableView.frame.origin.y = searchNavigationBar.frame.size.height
        searchFilterTableView.backgroundColor = UIColor.tableViewCellColor()
        searchFilterTableView.alpha = 0.0
        self.view.addSubview(searchFilterTableView)
        
        searchFilterDataSource = [
            Collection.allValues(),
            ProfessionalPlayer.allValues(),
            Team.allValues(),
            Weapon.allValues(),
            Exterior.allValues(),
            Category.allValues(),
            Quality.allValues(),
            StickerCollection.allValues(),
            StickerCategory.allValues(),
            Tournament.allValues(),
            Type.allValues()
        ]
        
        print(searchFilterDataSource[2].dynamicType)
        
        searchBar = CLTokenInputView(frame: CGRectMake(10.0, 24.0, self.view.frame.size.width - 20.0, 32.0))
        searchBar.layer.cornerRadius = 5.0
        searchBar.layer.masksToBounds = true
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor.searchBarColor()
        searchBar.tintColor = UIColor.appTintColor()
        searchBar.fieldColor = UIColor.whiteColor()
        searchBar.keyboardType = UIKeyboardType.Default
        searchBar.keyboardAppearance = UIKeyboardAppearance.Dark
        searchBar.returnKeyType = UIReturnKeyType.Search
        searchBar.fieldName = nil
        searchBar.placeholderText = "Search for items..."
        searchBar.drawBottomBorder = false
        searchBar.accessoryView = nil
        
        let searchBarTextField = searchBar.subviews[0] as! CLBackspaceDetectingTextField
            searchBarTextField.frame.origin.y = 100.0
            searchBarTextField.textColor = UIColor.whiteColor()
            searchBarTextField.font = UIFont.systemFontOfSize(14.0)
            searchBarTextField.text = "baller"

        let magnifyingGlass = UIImageView(image: UIImage(named: "magnifyingGlass")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate))
        magnifyingGlass.tintColor = UIColor.appTintColor()
        magnifyingGlass.sizeToFit()
        magnifyingGlass.frame = CGRectMake(0.0, 0.0, magnifyingGlass.frame.size.width, magnifyingGlass.frame.size.height)
        
        let paddingView = UIView(frame: magnifyingGlass.frame)
            paddingView.frame.size = CGSizeMake(magnifyingGlass.frame.size.width + 5.0, magnifyingGlass.frame.size.height + 5.0)
            magnifyingGlass.center = paddingView.center
            paddingView.addSubview(magnifyingGlass)
        
        searchBar.fieldView = paddingView
        
        searchNavigationBar.addSubview(searchBar)
        self.view.addSubview(searchNavigationBar)
        
        
        let token = CLToken(displayText: searchBarTextField.text!, context: nil)
        searchBar.addToken(token)

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.setNavigationBarHidden(true, animated: false)
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
        if tableView == searchResultsTableView {
             return 0.01
        }
        
        return  30.0
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
        
        if tableView == searchResultsTableView {
        
            let item = searchResultsDataSource[indexPath.row]
            var cell: MTSearchResultCell! = tableView.dequeueReusableCellWithIdentifier("MTSearchResultCell", forIndexPath: indexPath) as! MTSearchResultCell
            
            if cell == nil {
                cell = MTSearchResultCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MTSearchResultCell")
            }
            
            cell.delegate = self
            cell.renderCellContentForItem(item, indexPath: indexPath, resultCount: searchResultsDataSource.count)
            
            return cell
        }
        
        //let filterDataSource = searchFilterDataSource[indexPath.section]
        
        //let filter = (filterDataSource as! [Any])[indexPath.row]
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("MTFilterCell", forIndexPath: indexPath) as! UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MTFilterCell")
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
        if tableView == searchResultsTableView {
           return 1
        }
        
        return searchFilterDataSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchResultsTableView {
             return searchResultsDataSource == nil ? 0 : searchResultsDataSource.count
        }
        
        return 2
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

extension MTSearchViewController: UITextFieldDelegate, CLTokenInputViewDelegate {
    
    func tokenInputViewDidBeginEditing(view: CLTokenInputView) {
        UIView.animateWithDuration(0.25, animations: {
            self.searchFilterTableView.alpha = 1.0
        })
    }
    
    func tokenInputViewDidEndEditing(view: CLTokenInputView) {
        
        if !view.isSearching {
            view.unselectAllTokenViewsAnimated(true)
            UIView.animateWithDuration(0.25, animations: {
                self.searchFilterTableView.alpha = 0.0
            })
        }
    }

    func tokenInputView(view: CLTokenInputView, didChangeText text: String?) {
        print("Text")
    }
    
    func tokenInputView(view: CLTokenInputView, didAddToken token: CLToken) {
        print("added")
    }
    
    func tokenInputView(view: CLTokenInputView, didRemoveToken token: CLToken) {
        print("removed")
    }
    
//    func tokenField(tokenField: TITokenField!, willAddToken token: TIToken!) -> Bool {
//        
//        //token.tintColor = UIColor.starItemColor()
//        //token.textColor = token.tintColor
//        //token.backgroundColor = token.tintColor
//        
//        return true
//    }
//    
//    func tokenField(tokenField: TITokenField!, didAddToken token: TIToken!) {
//        print("Added")
//        
//        dispatch_async(dispatch_get_main_queue(), {
//            self.currentSearch = MTSearch(
//                query: token.title,
//                count: 1000
//            )
//            self.marketCommunicator.getResultsForSearch(self.currentSearch)
//            
//            //self.searchBar.resignFirstResponder()
//        })
//
//    }
//    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        UIView.animateWithDuration(0.25, animations: {
//            self.searchFilterTableView.alpha = 1.0
//        })
//    }
//    
////    func textFieldShouldReturn(textField: UITextField) -> Bool {
////        
////        return true
////    }
//    
//    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
//        if searchBar.tokenField.text?.characters.count == 0 {
//            currentSearch =  MTSearch(
//                count: 1000
//            )
//            marketCommunicator.getResultsForSearch(currentSearch)
//            
//        }
//        
//        UIView.animateWithDuration(0.25, animations: {
//            self.searchFilterTableView.alpha = 0.0
//        })
//        
//        searchBar.resignFirstResponder()
//        
//        return true
//    }
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
