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
        itemTableView.tableHeaderView = MTItemImageHeaderView(item: item, frame: CGRectMake(0, 0, itemTableView.frame.size.width, 316))
        itemTableView.backgroundColor = UIColor.searchResultCellColor()
        itemTableView.separatorStyle = .None
        itemTableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 135.0, 0.0)
        itemTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 115.0, 0.0)
        view.addSubview(itemTableView)
        
        
        let backButtonImage = UIImage(named: "back_arrow_icon")?.imageWithRenderingMode(.AlwaysTemplate)
        let backButton = UIButton(frame: CGRectMake(0, 0, 100, 20))
            backButton.setTitle("Back", forState: .Normal)
            backButton.addTarget(self, action: #selector(MTItemViewController.backButtonPressed(_:)), forControlEvents: .TouchUpInside)
            //backButton.setImage(backButtonImage, forState: .Normal)
            backButton.tintColor = UIColor.appTintColor()
        view.addSubview(backButton)

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
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if item.isOwned == true {
            return 4
        }
        
        return 3
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
            case 1:
                return 74
            case 2:
                return 200
            default:
                return 98
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell! = MTItemTitleCell(item: item, reuseIdentifier: "MTItemTitleCell")
        
        if indexPath.row == 1 {
            cell = MTItemCollectionCell()
            cell.textLabel?.text = item.type == Type.Sticker ? item.stickerCollection : item.collection
        } else if indexPath.row == 2 {
            if item.isOwned == true {
                cell = MTItemWearCell()
            } else {
                cell = MTItemDescriptionCell()
            }
        } else if indexPath.row == 3 {
            if item.isOwned == true {
                cell = MTItemDescriptionCell()
            }
        }

        cell.backgroundColor = UIColor.searchResultCellColor()
        
        return cell
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
