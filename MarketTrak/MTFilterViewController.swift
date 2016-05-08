//
//  MTFilterViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 5/4/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTFilterViewController: MTViewController {
    
    let filterDataSource = MTFilterDataSource()
    let tableView = UITableView(frame: CGRectZero, style: .Grouped)
    var tableViewSizeConstraint: [NSLayoutConstraint]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Filters"
        
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close_button"), style: .Done, target: self, action: "dismissViewController")
  
        view.addSubview(tableView)
        tableView.registerClass(MTFilterCategoryCell.self, forCellReuseIdentifier: "MTFilterCategoryCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.backgroundColor()
        tableView.autoPinEdge(.Top, toEdge: .Top, ofView: view)
        tableView.autoPinEdge(.Left, toEdge: .Left, ofView: view)
        tableViewSizeConstraint = tableView.autoSetDimensionsToSize(CGSizeZero)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableViewSizeConstraint[0].constant = self.view.frame.size.width
        tableViewSizeConstraint[1].constant = self.view.frame.size.height
    }
    
    func dismissViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension MTFilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterDataSource.currentFilters.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let filter = filterDataSource.currentFilters[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MTFilterCategoryCell", forIndexPath: indexPath) as! MTFilterCategoryCell
        cell.filterTitle.text = filter["name"].stringValue.uppercaseString
        
        if indexPath.row == 0 {
            cell.keywordSearchTextfield.hidden = false
            cell.keywordSearchTextfield.attributedPlaceholder = NSAttributedString(string: "Type here...", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor().colorWithAlphaComponent(0.3)])
            cell.selectedFilterTitles.hidden = true
        } else {
            cell.selectedFilterTitles.hidden = false
            cell.selectedFilterTitles.text = "Select a "+filter["name"].stringValue
            cell.keywordSearchTextfield.hidden = true
        }
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
}