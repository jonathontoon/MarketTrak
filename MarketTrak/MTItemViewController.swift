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
        
        self.title = String(item.quantity)
        view.backgroundColor = UIColor.backgroundColor()
        
        navigationController?.setNavigationBarHidden(true, animated: false)

        itemTableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.registerClass(MTItemWearCell.self, forCellReuseIdentifier: "MTItemWearCell")
        itemTableView.registerClass(MTItemDescriptionCell.self, forCellReuseIdentifier: "MTItemDescriptionCell")
        itemTableView.registerClass(MTItemCollectionCell.self, forCellReuseIdentifier: "MTItemCollectionCell")
        itemTableView.tableHeaderView = MTItemImageHeaderView(item: item, frame: CGRectMake(0, 0, itemTableView.frame.size.width, 310))
        itemTableView.backgroundColor = UIColor.searchResultCellColor()
        itemTableView.separatorStyle = .None
        itemTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 51.0, 0)
        view.addSubview(itemTableView)

        view.addSubview(bottomNavigationBar)
        bottomNavigationBar.backgroundColor = UIColor.searchResultCellColor()
        bottomNavigationBar.layer.shadowColor = UIColor.whiteColor().colorWithAlphaComponent(0.1).CGColor
        bottomNavigationBar.layer.shadowRadius = 0.0
        bottomNavigationBar.layer.shadowOpacity = 1.0
        bottomNavigationBar.layer.shadowOffset = CGSizeMake(0, (1.0 / UIScreen.mainScreen().scale) * -1)
        
        bottomNavigationBar.addSubview(leftButton)
        leftButton.setImage(UIImage(named: "back_icon")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        leftButton.tintColor = UIColor.appTintColor()
        leftButton.setTitleColor(leftButton.tintColor, forState: .Normal)
        leftButton.setTitleColor(leftButton.tintColor.colorWithAlphaComponent(0.5), forState: .Highlighted)
        leftButton.addTarget(self, action: #selector(MTItemViewController.backButtonPressed(_:)), forControlEvents: .TouchUpInside)
        
        bottomNavigationBar.addSubview(rightButton)
        rightButton.setImage(UIImage(named: "share_icon")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        rightButton.tintColor = UIColor.appTintColor()
        rightButton.setTitleColor(rightButton.tintColor, forState: .Normal)
        rightButton.setTitleColor(rightButton.tintColor.colorWithAlphaComponent(0.5), forState: .Highlighted)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bottomNavigationBar.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self.view)
        bottomNavigationBar.autoPinEdge(.Left, toEdge: .Left, ofView: self.view)
        bottomNavigationBar.autoPinEdge(.Right, toEdge: .Right, ofView: self.view)
        bottomNavigationBar.autoSetDimension(.Height, toSize:  50)
     
        leftButton.autoPinEdge(.Left, toEdge: .Left, ofView: bottomNavigationBar, withOffset: 15)
        leftButton.autoAlignAxis(.Horizontal, toSameAxisOfView: bottomNavigationBar, withOffset: 1)
        leftButton.autoSetDimensionsToSize(CGSizeMake(24, 24))
        
        rightButton.autoPinEdge(.Right, toEdge: .Right, ofView: bottomNavigationBar, withOffset: -15)
        rightButton.autoAlignAxis(.Horizontal, toSameAxisOfView: bottomNavigationBar, withOffset: 1)
        rightButton.autoSetDimensionsToSize(CGSizeMake(26, 26))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func backButtonPressed(button: UIButton) {
        navigationController?.popViewControllerAnimated(true)
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
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows = 2
        
        if item.isOwned == true {
            numberOfRows += 1
        }
        
        if item.stickerCollection != nil || item.collection != nil {
            numberOfRows += 1
        }
        
        return numberOfRows
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
            case 1:
                if item.stickerCollection != nil || item.collection != nil {
                    return 78
                } else if item.isOwned == true {
                    return 100
                } else {
                    return 200
                }
            case 2:
                if item.stickerCollection != nil || item.collection != nil {
                    if item.isOwned == true {
                        return 100
                    } else {
                        return 200
                    }
                } else {
                    return 200
                }
            default:
                return 104
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell! = MTItemTitleCell(item: item, reuseIdentifier: "MTItemTitleCell")
        
        if indexPath.row == 1 {
            cell = MTItemCollectionCell(item: item, reuseIdentifier: "MTItemCollectionCell")
        } else if indexPath.row == 2 {
            if item.isOwned == true {
                cell = MTItemWearCell()
            } else {
                cell = MTItemDescriptionCell(item: item, reuseIdentifier: "MTItemDescriptionCell")
            }
        } else if indexPath.row == 3 {
            if item.isOwned == true {
                cell = MTItemDescriptionCell(item: item, reuseIdentifier: "MTItemDescriptionCell")
            }
        }

        cell.backgroundColor = UIColor.searchResultCellColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            if item.collection != nil || item.stickerCollection != nil {
                
                let collectionListViewController = MTCollectionListViewController(parentItem: item)
                self.navigationController?.pushViewController(collectionListViewController, animated: true)
                
            }
        }
    }
}

extension MTItemViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let view = self.itemTableView.tableHeaderView!
        var rect = view.bounds
            rect.origin.y = max(0, -scrollView.contentOffset.y)
        print(scrollView.contentOffset.y)
        self.itemTableView.tableHeaderView!.bounds = rect
    }
    
}
