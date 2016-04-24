//
//  MTBrowseViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 11/7/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON

class MTBrowseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let filterIndex:Int!
    let browseDataSource: JSON!
    
    let browseTableView = UITableView.newAutoLayoutView()
    
    var browseTableViewWidth: NSLayoutConstraint!
    var browseTableViewHeight: NSLayoutConstraint!
    
    init(filterIndex index: Int? = nil) {
        let path = NSBundle.mainBundle().pathForResource("MarketFilters", ofType: "json")
        let jsonData = NSData(contentsOfFile:path!)
        
        if let i = index  {
            let json = JSON(data: jsonData!)
            browseDataSource = json[i]
        } else {
            browseDataSource = JSON(data: jsonData!)
        }

        filterIndex = index
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = browseDataSource["name"].string
        
        dispatch_async(dispatch_get_main_queue(), {
            self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back_button")
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back_button")
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        })
        
        if filterIndex == nil {
            
            title = "Browse Market"
            
            let leftButton = UIBarButtonItem(image: UIImage(named: "close_button")?.imageWithRenderingMode(.AlwaysTemplate), style: .Done, target: self, action: #selector(MTBrowseViewController.closeBrowseView))
            let spaceFix = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: self, action: nil)
                spaceFix.width = -7
            navigationItem.leftBarButtonItems   = [spaceFix, leftButton]
            
        }
        
        view.backgroundColor = UIColor.backgroundColor()
        
        self.view.addSubview(browseTableView)
        browseTableView.delegate = self
        browseTableView.dataSource = self
        browseTableView.backgroundColor = UIColor.backgroundColor()
        browseTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MTBrowseTableViewCell")
        browseTableView.separatorColor = UIColor.whiteColor().colorWithAlphaComponent(0.05)
        browseTableView.tableFooterView = UIView(frame: CGRectZero)
        browseTableView.autoPinEdge(.Top, toEdge: .Top, ofView: self.view)
        browseTableView.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        browseTableViewWidth = browseTableView.autoSetDimension(.Width, toSize: 0)
        browseTableViewHeight = browseTableView.autoSetDimension(.Height, toSize: 0)
        
    }
    
    override func viewWillLayoutSubviews() {
        browseTableViewWidth.constant = self.view.frame.size.width
        browseTableViewHeight.constant = self.view.frame.size.height
        browseTableView.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func backBrowseView() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func closeBrowseView() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension MTBrowseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MTBrowseTableViewCell", forIndexPath: indexPath)
            cell.textLabel?.text = browseDataSource[indexPath.row]["name"].string
        
            if filterIndex != nil {
                cell.textLabel?.text = browseDataSource["options"][indexPath.row]["name"].string
            }
        
            cell.backgroundColor = UIColor.searchResultCellColor()
            cell.backgroundView = UIView(frame: cell.contentView.frame)
            cell.backgroundView!.backgroundColor = cell.backgroundColor
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.textLabel?.font = UIFont.systemFontOfSize(15, weight: UIFontWeightMedium)
            cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var viewController: UIViewController! = MTBrowseViewController(filterIndex: indexPath.row)
            viewController.title = browseDataSource[indexPath.row]["name"].string
        
        if filterIndex != nil {
            
            let filter = MTFilter()
                filter.name = browseDataSource["name"].string
                filter.category = browseDataSource["category"].string
            let filterOption = MTFilterOption()
                filterOption.name = browseDataSource["options"][indexPath.row]["name"].string
                filterOption.tag = browseDataSource["options"][indexPath.row]["tag"].string
                filter.options = [filterOption]
            
            viewController = MTResultViewController(query:
                MTSearch(
                    filters: [filter],
                    count: 2000
                )
            )
            
            viewController.title = browseDataSource["options"][indexPath.row]["name"].string
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filterIndex != nil {
            return browseDataSource["options"].count
        }
        
        return browseDataSource.count
    }

}
