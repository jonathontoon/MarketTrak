//
//  MTItemViewController.swift
//
//
//  Created by Jonathon Toon on 10/11/15.
//
//

import UIKit
import SDWebImage

class MTItemViewController: UIViewController {
    
    var item: MTItem!
    
    let bottomNavigationBar = UIView.newAutoLayoutView()
    let leftButton = UIButton.newAutoLayoutView()
    let rightButton = UIButton.newAutoLayoutView()
    
    var itemTableView: UITableView!
    
    init(item: MTItem!) {
        super.init(nibName: nil, bundle: nil)
        
        self.item = item
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = item.quantity
        view.backgroundColor = UIColor.backgroundColor()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
     
        let backButtonImage = UIImage(named: "back_arrow_icon")?.imageWithRenderingMode(.AlwaysTemplate)
        let backButton = UIBarButtonItem(image: backButtonImage, style: UIBarButtonItemStyle.Done, target: self, action: #selector(MTItemViewController.backButtonPressed(_:)))
        backButton.tintColor = UIColor.appTintColor()
        navigationItem.leftBarButtonItem = backButton
        
        itemTableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.registerClass(MTItemTitleCell.self, forCellReuseIdentifier: "MTItemTitleCell")
        itemTableView.registerClass(MTItemWearCell.self, forCellReuseIdentifier: "MTItemWearCell")
        itemTableView.registerClass(MTItemDescriptionCell.self, forCellReuseIdentifier: "MTItemDescriptionCell")
        itemTableView.registerClass(MTItemCollectionCell.self, forCellReuseIdentifier: "MTItemCollectionCell")
        itemTableView.backgroundColor = UIColor.backgroundColor()
        itemTableView.separatorColor = UIColor.tableViewSeparatorColor()
        itemTableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 135.0, 0.0)
        itemTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 115.0, 0.0)
        view.addSubview(itemTableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        dump(item)
    }
    
    func backButtonPressed(button: UIButton) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

extension MTItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var numberOfSections: Int = 1
        
        if item.isOwned == true {
            numberOfSections += 1
        }
        
        if item.desc != nil && item.desc != "" {
            numberOfSections += 1
        }
        
        if item.collection != nil && item.collection != "" {
            numberOfSections += 1
        }
        
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height: CGFloat = 35.0
        
        if section == 0 {
            height = 0.1
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRectMake(0.0, 0.0, tableView.frame.size.width, 35.0))
        headerView.backgroundColor = tableView.backgroundColor
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height: CGFloat = 50.0
        
        if indexPath.section == 0 && indexPath.row == 0 {
            height = 373.0
        }
        
        if indexPath.section == 1 && indexPath.row == 0 && item.isOwned == true {
            return 174.0
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if indexPath.section == 1 {
            if item.isOwned == true {
                cell = MTItemWearCell()
            } else {
                cell = MTItemDescriptionCell()
            }
        } else if indexPath.section == 2 {
            if item.isOwned == true {
                cell = MTItemDescriptionCell()
            } else {
                cell = MTItemCollectionCell()
            }
        } else if indexPath.section == 3 {
            cell = MTItemCollectionCell()
        } else {
            if indexPath.row == 0 {
                cell = MTItemTitleCell(item: item, frame: CGRectMake(0.0, 0.0, view.frame.size.width, self.tableView(tableView, heightForRowAtIndexPath: indexPath)), reuseIdentifier: "MTItemTitleCell")
            } else {
                cell = MTItemWatchCell()
            }
        }
        
        cell.backgroundColor = UIColor.searchResultCellColor()
        
        return cell
    }
    
}
