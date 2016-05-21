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

extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        if let index = indexOf({ $0 == object }) {
            removeAtIndex(index)
        }
    }
}

class MTSearchField: UITextField {
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 30, 0)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 30, 0)
    }
}

class MTMarketViewController: MTViewController, UIGestureRecognizerDelegate {
 
    var previousController: MTViewController! = nil
    
    var marketCommunicator: MTSteamMarketCommunicator!
    var currentSearch: MTSearch!
    var itemResultDataSource: [MTItem]!
    
    let searchBar = MTSearchField.newAutoLayoutView()
    var searchBarConstraintRight: NSLayoutConstraint!
    let cancelButton = UIButton.newAutoLayoutView()
    var searchIsActive: Bool = false
    
    var keyboardAnimationDuration: Double!
    var keyboardAnimationCurve: UInt!
    
    var itemSize: CGSize!
    var itemResultsCollectionView: UICollectionView!
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    var itemResultCollectionViewWidth: NSLayoutConstraint!
    var itemResultCollectionViewHeight: NSLayoutConstraint!
    
    let filterDataSource = MTFilterDataSource()
    var searchFilterTableView: UITableView!
    var previousSectionHeader: MTSearchFilterCategoryHeaderView!
    var searchFilterTableViewWidth: NSLayoutConstraint!
    var searchFilterTableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        currentSearch = MTSearch()
        marketCommunicator.getResultsForSearch(currentSearch)
        
        view.backgroundColor = UIColor.backgroundColor()
    
        navigationController?.navigationBar.addSubview(searchBar)
        
        let magnifyingGlass = UIImageView(image: UIImage(named: "magnifyingGlass")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate))
        magnifyingGlass.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        magnifyingGlass.frame = CGRectMake(0.0, 0.0, magnifyingGlass.frame.size.width + 20, magnifyingGlass.frame.size.height)
        magnifyingGlass.contentMode = .Center
        
        searchBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        searchBar.textColor = UIColor.whiteColor()
        searchBar.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
        searchBar.attributedPlaceholder = NSAttributedString(string: "Search for items...", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor().colorWithAlphaComponent(0.3)])
        searchBar.layer.cornerRadius = 5
        searchBar.keyboardAppearance = .Dark
        searchBar.returnKeyType = .Search
        searchBar.autocorrectionType = .No
        searchBar.clearButtonMode = .WhileEditing
        
        searchBar.leftView = magnifyingGlass
        searchBar.leftViewMode = .Always
        searchBar.delegate = self
        
        searchBar.autoSetDimension(.Height, toSize: 30)
        searchBar.autoPinEdge(.Left, toEdge: .Left, ofView: (navigationController?.navigationBar)!, withOffset: 8)
        searchBarConstraintRight = searchBar.autoPinEdge(.Right, toEdge: .Right, ofView: (navigationController?.navigationBar)!, withOffset: -8)
        searchBar.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: (navigationController?.navigationBar)!, withOffset: -8)
        
        navigationController?.navigationBar.addSubview(cancelButton)
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.setTitleColor(UIColor.appTintColor(), forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(16, weight: UIFontWeightRegular)
        cancelButton.titleLabel?.textAlignment = .Center
        cancelButton.addTarget(self, action: #selector(MTMarketViewController.cancelSearch), forControlEvents: .TouchUpInside)
        cancelButton.autoPinEdge(.Left, toEdge: .Right, ofView: searchBar, withOffset: 8)
        cancelButton.autoSetDimensionsToSize(CGSizeMake(58, 30))
        cancelButton.autoAlignAxis(.Horizontal, toSameAxisOfView: searchBar)
        
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
        itemResultsCollectionView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0)
        itemResultsCollectionView.autoPinEdge(.Top, toEdge: .Top, ofView: self.view)
        itemResultsCollectionView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        itemResultCollectionViewWidth = itemResultsCollectionView.autoSetDimension(.Width, toSize: 0)
        itemResultCollectionViewHeight = itemResultsCollectionView.autoSetDimension(.Height, toSize: 0)
        
        searchFilterTableView = UITableView(frame: CGRectZero, style: .Grouped)
        self.view.addSubview(searchFilterTableView)
        
        searchFilterTableView.delegate = self
        searchFilterTableView.dataSource = self
        searchFilterTableView.registerClass(MTSearchFilterSelectableCell.self, forCellReuseIdentifier: "MTSearchFilterSelectableCell")
        searchFilterTableView.backgroundColor = UIColor.backgroundColor()
        searchFilterTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        searchFilterTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        searchFilterTableView.alpha = 0.0
        searchFilterTableView.separatorColor = UIColor.whiteColor().colorWithAlphaComponent(0.05)
        searchFilterTableView.allowsMultipleSelection = true
        searchFilterTableView.autoPinEdge(.Top, toEdge: .Top, ofView: self.view)
        searchFilterTableView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        searchFilterTableViewWidth = searchFilterTableView.autoSetDimension(.Width, toSize: 0)
        searchFilterTableViewHeight = searchFilterTableView.autoSetDimension(.Height, toSize: 0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MTMarketViewController.keyboardWillAnimate(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MTMarketViewController.keyboardWillAnimate(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func viewWillLayoutSubviews() {
        itemResultCollectionViewWidth.constant = self.view.frame.size.width
        itemResultCollectionViewHeight.constant = self.view.frame.size.height
        itemResultsCollectionView.layoutIfNeeded()
        
        searchFilterTableViewWidth.constant = self.view.frame.size.width
        searchFilterTableViewHeight.constant = self.view.frame.size.height
        searchFilterTableView.layoutIfNeeded()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        canScrollToTop = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        canScrollToTop = false
    }
    
    func scrollToTop() {
        itemResultsCollectionView.setContentOffset(CGPoint(x: 0, y: -20), animated: true)
    }
    
    func keyboardWillAnimate(notification: NSNotification) {
        
        keyboardAnimationDuration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        keyboardAnimationCurve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt


        if notification.name == UIKeyboardWillShowNotification {
         
            dispatch_async(dispatch_get_main_queue(),{
                
                if self.searchIsActive == true {
                    self.searchBarConstraintRight.constant = -76
                
                    UIView.animateWithDuration(self.keyboardAnimationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: self.keyboardAnimationCurve), animations: {
                        self.searchFilterTableView.alpha = 1.0
                        self.navigationController?.navigationBar.layoutIfNeeded()
                    }, completion: nil)
                }
                
            })
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(),{
                
                if self.searchIsActive == false {
                    self.searchBarConstraintRight.constant = -8
               
                    UIView.animateWithDuration(self.keyboardAnimationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: self.keyboardAnimationCurve), animations: {
                        self.searchFilterTableView.alpha = 0.0
                        self.navigationController?.navigationBar.layoutIfNeeded()
                    }, completion: nil)
                }
                
            })
            
        }
    }
}

extension MTMarketViewController: UITextFieldDelegate {
    
    func cancelSearch() {
        searchIsActive = false
        searchBar.resignFirstResponder()
        
        searchBarConstraintRight.constant = -8
        
        UIView.animateWithDuration(keyboardAnimationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: keyboardAnimationCurve), animations: {
            self.searchFilterTableView.alpha = 0.0
            self.navigationController?.navigationBar.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        searchIsActive = true
        searchFilterTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let queryFilter = MTFilterCategory()
            queryFilter.category = "query"
            queryFilter.name = "Keyword"
        
        let filterOption = MTFilter()
            filterOption.name = textField.text
            filterOption.tag = textField.text!+"&descriptions=1"
        
            queryFilter.options = [filterOption]
        
        currentSearch = MTSearch(filters: [queryFilter])
        marketCommunicator.getResultsForSearch(currentSearch)
        
        searchIsActive = false
        searchBar.resignFirstResponder()
        
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
        
        if scrollView == searchFilterTableView {
            searchBar.resignFirstResponder()
        }
    }
}

extension MTMarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filterDataSource.displayedFilters.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let options = filterDataSource.displayedFilters[section].options {
            return options.count
        }

        return 0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 49
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let filterCategoryView = MTSearchFilterCategoryHeaderView()
            filterCategoryView.filterCategoryName.text = filterDataSource.displayedFilters[section].name
            filterCategoryView.filtersSelected.text = "Any"
            filterCategoryView.section = section
        
            if filterCategoryView.section == filterDataSource.selectedCategory {
                filterCategoryView.expandCell(false)
            } else {
                filterCategoryView.retractCell(false)
            }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MTMarketViewController.didTapViewForHeaderInSection(_:)))
            filterCategoryView.addGestureRecognizer(tapGestureRecognizer)
        
        return filterCategoryView
        
    }
    
    func didTapViewForHeaderInSection(recognizer: UITapGestureRecognizer!) {
        
        if case let headerView as MTSearchFilterCategoryHeaderView = recognizer.view {
            
            print(headerView.expanded)
            
            if headerView.expanded == false {
                headerView.expandCell(true)
                
                if let selectedCategory = filterDataSource.selectedCategory {
                
                    if headerView.section != selectedCategory {
                        
                        previousSectionHeader.retractCell(true)
                        
                        var indexPaths: [NSIndexPath] = []
                        for i in 0..<self.filterDataSource.filters[selectedCategory].options!.count {
                            indexPaths.append(NSIndexPath(forRow: i, inSection: selectedCategory))
                        }
                        
                        filterDataSource.removeOptionsFromFilterCategory(selectedCategory)
                        
                        searchFilterTableView.beginUpdates()
                        searchFilterTableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                        searchFilterTableView.endUpdates()
                    }
                }
                
                filterDataSource.addOptionsToFilterCategory(headerView.section!)
                
                var indexPaths: [NSIndexPath] = []
                for i in 0..<self.filterDataSource.filters[headerView.section!].options!.count {
                    indexPaths.append(NSIndexPath(forRow: i, inSection: headerView.section!))
                }

                searchFilterTableView.beginUpdates()
                searchFilterTableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                searchFilterTableView.endUpdates()
                
                previousSectionHeader = headerView
                
            } else {
                headerView.retractCell(true)
                
                var indexPaths: [NSIndexPath] = []
                for i in 0..<self.filterDataSource.filters[headerView.section!].options!.count {
                    indexPaths.append(NSIndexPath(forRow: i, inSection: headerView.section!))
                }
                
                filterDataSource.removeOptionsFromFilterCategory(headerView.section!)
                
                self.searchFilterTableView.beginUpdates()
                self.searchFilterTableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                self.searchFilterTableView.endUpdates()
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MTSearchFilterSelectableCell", forIndexPath: indexPath) as! MTSearchFilterSelectableCell
        
        if let options = filterDataSource.displayedFilters[indexPath.section].options {
            cell.textLabel!.text = options[indexPath.row].name
            cell.selectionStyle = .None
            
            if filterDataSource.selectedFilters.contains(indexPath) {
                cell.accessoryView = UIImageView(image: UIImage(named: "cell_selected"))
            } else {
                cell.accessoryView = UIImageView(image: UIImage(named: "cell_unselected")?.imageWithRenderingMode(.AlwaysTemplate))
                cell.accessoryView!.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
            }
        }
        
        return cell

    }
    

//    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//        
//        print("willSelect "+indexPath.section.description)
//        
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        
//        if cell!.isKindOfClass(MTSearchFilterCategoryCell) {
//            
////            if let _ = filterDataSource.selectedCategory {
////                if filterDataSource.selectedCategory != indexPath {
////                    self.tableView(searchFilterTableView, willDeselectRowAtIndexPath: filterDataSource.selectedCategory!)
////                }
////            }
//            
//            (cell as! MTSearchFilterCategoryCell).expandCell(true)
//            
//            var indexPaths: [NSIndexPath] = []
//            for i in 0..<self.filterDataSource.filters[indexPath.section].options!.count {
//                indexPaths.append(NSIndexPath(forRow: i+1, inSection: indexPath.section))
//            }
//            
//            filterDataSource.addOptionsToFilterCategory(indexPath)
//            
//            self.searchFilterTableView.beginUpdates()
//            self.searchFilterTableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
//            self.searchFilterTableView.endUpdates()
//
//        } else if cell!.isKindOfClass(MTSearchFilterSelectableCell) {
//            
//            if !filterDataSource.selectedFilters.contains(indexPath) {
//                filterDataSource.selectedFilters.append(indexPath)
//                cell!.accessoryView = UIImageView(image: UIImage(named: "cell_selected"))
//             } else {
//                cell!.selected = false
//                filterDataSource.selectedFilters.remove(indexPath)
//                cell!.accessoryView = UIImageView(image: UIImage(named: "cell_unselected")?.imageWithRenderingMode(.AlwaysTemplate))
//                cell!.accessoryView!.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
//            }
//        }
//        
//        return indexPath
//    }
    
//    func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//        
//        print("willDeselect "+indexPath.section.description)
//        
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        
//        if cell!.isKindOfClass(MTSearchFilterCategoryCell) {
//            
//            (cell as! MTSearchFilterCategoryCell).retractCell(true)
//            var indexPaths: [NSIndexPath] = []
//            
//            if filterDataSource.selectedCategory == indexPath {
//                
//                for i in 0..<filterDataSource.displayedFilters[filterDataSource.selectedCategory!.section].options!.count {
//                    indexPaths.append(NSIndexPath(forRow: i+1, inSection: filterDataSource.selectedCategory!.section))
//                }
//                
//                filterDataSource.removeOptionsToFilterCategory(filterDataSource.selectedCategory!)
//                
//            } else {
//                
//                for i in 0..<filterDataSource.displayedFilters[indexPath.section].options!.count {
//                    indexPaths.append(NSIndexPath(forRow: i+1, inSection: indexPath.section))
//                }
//                
//                filterDataSource.removeOptionsToFilterCategory(indexPath)
//                
//            }
//            
//            self.searchFilterTableView.beginUpdates()
//            self.searchFilterTableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
//            self.searchFilterTableView.endUpdates()
//            
//        } else if cell!.isKindOfClass(MTSearchFilterSelectableCell) {
//            filterDataSource.selectedFilters.remove(indexPath)
//            cell!.accessoryView = UIImageView(image: UIImage(named: "cell_unselected")?.imageWithRenderingMode(.AlwaysTemplate))
//            cell!.accessoryView!.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
//        }
//        
//        return indexPath
//    }
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