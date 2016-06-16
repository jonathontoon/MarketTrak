//
//  MTSearchViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 11/7/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

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

class MTSearchViewController: MTViewController {

    var marketCommunicator: MTSteamMarketCommunicator!
    var searchQuery: MTSearch!
    
    var searchBar: MTSearchField!
    var searchBarConstraintRight: NSLayoutConstraint!
    var cancelButton: UIButton!
    var containerTitleView: UIView!
    var searchIsActive: Bool = false

    var keyboardAnimationDuration: Double!
    var keyboardAnimationCurve: UInt!
    var keyboardFrame: CGSize!
    
    let filterDataSource = MTFilterDataSource()
    var searchFilterTableView: UITableView!
    var previousSectionHeader: MTSearchFilterCategoryHeaderView!
    var searchFilterTableViewWidth: NSLayoutConstraint!
    var searchFilterTableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.backgroundColor()
        
        marketCommunicator = MTSteamMarketCommunicator()
        marketCommunicator.delegate = self
        
        containerTitleView = UIView(frame: CGRectMake(0, 0, view.frame.size.width, 30))
        self.navigationItem.titleView = containerTitleView
        
        searchBar =  MTSearchField.newAutoLayoutView()

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
        searchBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MTSearchViewController.tappedSearchBar(_:))))
        searchBar.becomeFirstResponder()
        containerTitleView.addSubview(searchBar)
        
        cancelButton = UIButton(type: .System)
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.setTitleColor(UIColor.appTintColor(), forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
        cancelButton.titleLabel?.textAlignment = .Center
        cancelButton.addTarget(self, action: #selector(MTSearchViewController.cancelSearch), forControlEvents: .TouchUpInside)
        containerTitleView.addSubview(cancelButton)
        
        var offset: CGFloat = -10
        if view.frame.size.width == 375 {
            offset = -8
        } else if view.frame.size.width > 375 {
            offset = -4
        }
        
        cancelButton.autoPinEdge(.Right, toEdge: .Right, ofView: containerTitleView, withOffset: offset)
        cancelButton.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: containerTitleView)
        cancelButton.autoSetDimensionsToSize(CGSizeMake(54, 30))
        
        searchBar.autoSetDimension(.Height, toSize: 30)
        searchBar.autoPinEdge(.Left, toEdge: .Left, ofView: containerTitleView)
        searchBar.autoPinEdge(.Right, toEdge: .Left, ofView: cancelButton, withOffset: -15)
        searchBar.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: containerTitleView)
        
        searchFilterTableView = UITableView(frame: CGRectZero, style: .Grouped)
        self.view.addSubview(searchFilterTableView)
        
        searchFilterTableView.delegate = self
        searchFilterTableView.dataSource = self
        searchFilterTableView.registerClass(MTSearchFilterSelectableCell.self, forCellReuseIdentifier: "MTSearchFilterSelectableCell")
        searchFilterTableView.backgroundColor = UIColor.backgroundColor()
        searchFilterTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        searchFilterTableView.contentInset = UIEdgeInsetsMake(0, 0, 56, 0)
        searchFilterTableView.separatorColor = UIColor.whiteColor().colorWithAlphaComponent(0.05)
        searchFilterTableView.allowsMultipleSelection = true
        
        let tableViewhHeaderView = MTSearchFilterTableViewHeader()
            tableViewhHeaderView.frame.size.height = 56
        searchFilterTableView.tableHeaderView = tableViewhHeaderView
        
        searchFilterTableView.autoPinEdge(.Top, toEdge: .Top, ofView: self.view)
        searchFilterTableView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        searchFilterTableViewWidth = searchFilterTableView.autoSetDimension(.Width, toSize: 0)
        searchFilterTableViewHeight = searchFilterTableView.autoSetDimension(.Height, toSize: 0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MTSearchViewController.keyboardWillAnimate(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MTSearchViewController.keyboardWillAnimate(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        searchFilterTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        searchBar.resignFirstResponder()
        self.hideLoadingIndicator()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        searchFilterTableViewWidth.constant = self.view.frame.size.width
        searchFilterTableViewHeight.constant = self.view.frame.size.height
        searchFilterTableView.layoutIfNeeded()
    }
    
    func tappedSearchBar(recgonizer: UITapGestureRecognizer!) {
        dispatch_async(dispatch_get_main_queue(),{
            self.searchBar.becomeFirstResponder()
        })
    }
    
    func keyboardWillAnimate(notification: NSNotification) {
        
        keyboardAnimationDuration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        keyboardAnimationCurve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        keyboardFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
        
        searchFilterTableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.height, 0)
        
        if notification.name == UIKeyboardWillShowNotification {
            
            dispatch_async(dispatch_get_main_queue(),{
                
                if self.searchIsActive == true {
                    
                    UIView.animateWithDuration(self.keyboardAnimationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: self.keyboardAnimationCurve), animations: {
                        self.navigationController?.navigationBar.layoutIfNeeded()
                    }, completion: nil)
                }
                
            })
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(),{
                
                if self.searchIsActive == false {
                    UIView.animateWithDuration(self.keyboardAnimationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: self.keyboardAnimationCurve), animations: {
                        self.navigationController?.navigationBar.layoutIfNeeded()
                    }, completion: nil)
                }
                
            })
            
        }
    }
}

extension MTSearchViewController: MTSteamMarketCommunicatorDelegate {
    
    func searchResultsReturnedSuccessfully(searchResults: [MTItem]!) {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            if searchResults.count == 0 {
                
                self.hideLoadingIndicator()
                
                let alertView = UIAlertController(title: "Sorry, An Error Occured", message: "No items were found,\ntry another search.", preferredStyle: .Alert)
                    alertView.addAction(UIAlertAction(title: "Okay", style: .Cancel, handler: nil))
                self.presentViewController(alertView, animated: true, completion: nil)
                
                return
            }
            
            let searchResultViewController = MTSearchResultsViewController(dataSource: searchResults, numberOfFilters: self.searchQuery.filterCategories.count)
                searchResultViewController.searchQuery = self.searchQuery
            self.navigationController?.pushViewController(searchResultViewController, animated: true)
            
        })
    }
}

extension MTSearchViewController: UITextFieldDelegate {

    func cancelSearch() {
        searchIsActive = false
        
        dispatch_async(dispatch_get_main_queue(),{
            self.searchBar.resignFirstResponder()
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {

        searchIsActive = true
        searchFilterTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        return true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {

        var filtersForSearch: [MTFilterCategory] = []
        
        if textField.text != "" {
        
            let keywordFilterCategory = MTFilterCategory()
                keywordFilterCategory.category = "query"
                keywordFilterCategory.name = "Keyword"

            let keywordFilterOption = MTFilter()
                keywordFilterOption.name = textField.text
                keywordFilterOption.tag = textField.text!+"&descriptions=1"

                keywordFilterCategory.options = [keywordFilterOption]
            
            filtersForSearch.append(keywordFilterCategory)
        }
        
        for filter in filterDataSource.filters {
            
            let filterCategory = MTFilterCategory()
                filterCategory.category = filter.category
                filterCategory.name = filter.name
            
            for indexPath in filterDataSource.selectedFilters {
                
                if filter == filterDataSource.filters[indexPath.section] {
                    
                    let filterOption = MTFilter()
                        filterOption.name = filterDataSource.filters[indexPath.section].options![indexPath.row].name
                        filterOption.tag = filterDataSource.filters[indexPath.section].options![indexPath.row].tag
                    
                    filterCategory.options!.append(filterOption)
                    
                }
                
            }
            
            if filterCategory.options?.count > 0 {
                filtersForSearch.append(filterCategory)
            }
            
        }

        searchIsActive = false
        searchBar.resignFirstResponder()
 
        showLoadingIndicator()
        
        searchQuery = MTSearch(filterCategories: filtersForSearch)
        marketCommunicator.getResultsForSearch(searchQuery)
        
        return true
    }
}

extension MTSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return 60
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 49
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let filterCategoryView = MTSearchFilterCategoryHeaderView()
            filterCategoryView.separatorView.hidden = section == 0 ? true : false
            filterCategoryView.section = section
        
        if filterCategoryView.section == filterDataSource.selectedCategory {
            filterCategoryView.expandCell(animated: false)
        } else {
            filterCategoryView.retractCell(animated: false)
        }
        
        filterCategoryView.updateLabels(filterDataSource)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MTSearchViewController.didTapViewForHeaderInSection(_:)))
        filterCategoryView.addGestureRecognizer(tapGestureRecognizer)
        
        return filterCategoryView
    }
    
    func didTapViewForHeaderInSection(recognizer: UITapGestureRecognizer!) {
        
        if case let headerView as MTSearchFilterCategoryHeaderView = recognizer.view {
            
            dispatch_async(dispatch_get_main_queue(),{
               
                if headerView.expanded == false {
                    headerView.expandCell(animated: true)
                    
                    if let selectedCategory = self.filterDataSource.selectedCategory {
                        
                        if headerView.section != selectedCategory {
                            
                            if let previousHeader = self.previousSectionHeader {
                                previousHeader.retractCell(animated: true)
                            }
                            
                            var indexPaths: [NSIndexPath] = []
                            for i in 0..<self.filterDataSource.filters[selectedCategory].options!.count {
                                indexPaths.append(NSIndexPath(forRow: i, inSection: selectedCategory))
                            }
                            
                            self.filterDataSource.removeOptionsFromFilterCategory(selectedCategory)
                            self.searchFilterTableView.beginUpdates()
                            self.searchFilterTableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                            self.searchFilterTableView.endUpdates()
                            self.searchFilterTableView.reloadData()
                        }
                    }
                    
                    self.filterDataSource.addOptionsToFilterCategory(headerView.section!)
                    
                    var indexPaths: [NSIndexPath] = []
                    for i in 0..<self.filterDataSource.filters[headerView.section!].options!.count {
                        indexPaths.append(NSIndexPath(forRow: i, inSection: headerView.section!))
                    }
                    
                    self.searchFilterTableView.beginUpdates()
                    self.searchFilterTableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                    self.searchFilterTableView.endUpdates()
                    
                    headerView.updateLabels(self.filterDataSource)
                    
                    self.previousSectionHeader = headerView
                    
                } else {
                    headerView.retractCell(animated: true)
                    
                    var indexPaths: [NSIndexPath] = []
                    for i in 0..<self.filterDataSource.filters[headerView.section!].options!.count {
                        indexPaths.append(NSIndexPath(forRow: i, inSection: headerView.section!))
                    }
                    
                    self.filterDataSource.removeOptionsFromFilterCategory(headerView.section!)
                    
                    self.searchFilterTableView.beginUpdates()
                    self.searchFilterTableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                    self.searchFilterTableView.endUpdates()
                    
                    headerView.updateLabels(self.filterDataSource)
                    self.previousSectionHeader = headerView
                }
            })
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MTSearchFilterSelectableCell", forIndexPath: indexPath) as! MTSearchFilterSelectableCell
        
        if let options = filterDataSource.displayedFilters[indexPath.section].options {
            cell.textLabel!.text = options[indexPath.row].name
            
            if filterDataSource.displayedFilters[indexPath.section].name == "Quality" {
                cell.textLabel!.textColor = determineQuality(options[indexPath.row].name).colorForQuality()
            } else if filterDataSource.displayedFilters[indexPath.section].name == "Category" {
                cell.textLabel!.textColor = determineCategory(options[indexPath.row].name).colorForCategory()
            }
            
            cell.selectionStyle = .None
            cell.backgroundColor = UIColor.backgroundColor()
            
            if filterDataSource.selectedFilters.contains(indexPath) {
                cell.accessoryView = UIImageView(image: UIImage(named: "cell_selected"))
            } else {
                cell.accessoryView = UIImageView(image: UIImage(named: "cell_unselected")?.imageWithRenderingMode(.AlwaysTemplate))
                cell.accessoryView!.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
            }
        }
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MTSearchFilterSelectableCell
        
        if !filterDataSource.selectedFilters.contains(indexPath) {
            filterDataSource.selectedFilters.append(indexPath)
            cell.accessoryView = UIImageView(image: UIImage(named: "cell_selected"))
        } else {
            cell.selected = false
            filterDataSource.selectedFilters.remove(indexPath)
            cell.accessoryView = UIImageView(image: UIImage(named: "cell_unselected")?.imageWithRenderingMode(.AlwaysTemplate))
            cell.accessoryView!.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        }

        dispatch_async(dispatch_get_main_queue(),{
            self.searchFilterTableView.reloadData()
        })
        
        return indexPath
    }
    
    func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MTSearchFilterSelectableCell
        
        filterDataSource.selectedFilters.remove(indexPath)
        cell.accessoryView = UIImageView(image: UIImage(named: "cell_unselected")?.imageWithRenderingMode(.AlwaysTemplate))
        cell.accessoryView!.tintColor = UIColor.whiteColor().colorWithAlphaComponent(0.1)
        
        dispatch_async(dispatch_get_main_queue(),{
            self.searchFilterTableView.reloadData()
        })
        
        return indexPath
    }
}
