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

    let searchBar = MTSearchField.newAutoLayoutView()
    var searchBarConstraintRight: NSLayoutConstraint!
    let cancelButton = UIButton.newAutoLayoutView()
    var searchIsActive: Bool = false

    var keyboardAnimationDuration: Double!
    var keyboardAnimationCurve: UInt!
    
    var marketCommunicator: MTSteamMarketCommunicator!
    var currentSearch: MTSearch!
    
    let filterDataSource = MTFilterDataSource()
    var searchFilterTableView: UITableView!
    var previousSectionHeader: MTSearchFilterCategoryHeaderView!
    var searchFilterTableViewWidth: NSLayoutConstraint!
    var searchFilterTableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        searchBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MTSearchViewController.tappedSearchBar(_:))))

        searchBar.leftView = magnifyingGlass
        searchBar.leftViewMode = .Always
        searchBar.delegate = self

        searchBar.autoSetDimension(.Height, toSize: 30)
        searchBar.autoPinEdge(.Left, toEdge: .Left, ofView: (navigationController?.navigationBar)!, withOffset: 8)
        searchBarConstraintRight = searchBar.autoPinEdge(.Right, toEdge: .Right, ofView: (navigationController?.navigationBar)!, withOffset: -76)
        searchBar.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: (navigationController?.navigationBar)!, withOffset: -8)

        navigationController?.navigationBar.addSubview(cancelButton)
        cancelButton.setTitle("Done", forState: .Normal)
        cancelButton.setTitleColor(UIColor.appTintColor(), forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
        cancelButton.titleLabel?.textAlignment = .Center
        cancelButton.addTarget(self, action: #selector(MTSearchViewController.cancelSearch), forControlEvents: .TouchUpInside)
        cancelButton.autoPinEdge(.Left, toEdge: .Right, ofView: searchBar, withOffset: 8)
        cancelButton.autoSetDimensionsToSize(CGSizeMake(58, 30))
        cancelButton.autoAlignAxis(.Horizontal, toSameAxisOfView: searchBar)

        searchFilterTableView = UITableView(frame: CGRectZero, style: .Grouped)
        self.view.addSubview(searchFilterTableView)
        
        searchFilterTableView.delegate = self
        searchFilterTableView.dataSource = self
        searchFilterTableView.registerClass(MTSearchFilterSelectableCell.self, forCellReuseIdentifier: "MTSearchFilterSelectableCell")
        searchFilterTableView.backgroundColor = UIColor.backgroundColor()
        searchFilterTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        searchFilterTableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0)
        searchFilterTableView.separatorColor = UIColor.whiteColor().colorWithAlphaComponent(0.05)
        searchFilterTableView.allowsMultipleSelection = true
        
        let tableViewhHeaderView = MTSearchFilterTableViewHeader()
        tableViewhHeaderView.frame.size.height = 60
        searchFilterTableView.tableHeaderView = tableViewhHeaderView
        
        searchFilterTableView.autoPinEdge(.Top, toEdge: .Top, ofView: self.view)
        searchFilterTableView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        searchFilterTableViewWidth = searchFilterTableView.autoSetDimension(.Width, toSize: 0)
        searchFilterTableViewHeight = searchFilterTableView.autoSetDimension(.Height, toSize: 0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MTSearchViewController.keyboardWillAnimate(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MTSearchViewController.keyboardWillAnimate(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        searchBar.becomeFirstResponder()
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

extension MTSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == searchFilterTableView {
            searchBar.resignFirstResponder()
        }
    }
    
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
                            
                            self.previousSectionHeader.retractCell(animated: true)
                            
                            var indexPaths: [NSIndexPath] = []
                            for i in 0..<self.filterDataSource.filters[selectedCategory].options!.count {
                                indexPaths.append(NSIndexPath(forRow: i, inSection: selectedCategory))
                            }
                            
                            self.filterDataSource.removeOptionsFromFilterCategory(selectedCategory)
                            self.searchFilterTableView.beginUpdates()
                            self.searchFilterTableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                            self.searchFilterTableView.endUpdates()
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
                }
            })
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MTSearchFilterSelectableCell", forIndexPath: indexPath) as! MTSearchFilterSelectableCell
        
        if let options = filterDataSource.displayedFilters[indexPath.section].options {
            cell.textLabel!.text = options[indexPath.row].name
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
