//
//  MTAddItemToWatchListViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 7/18/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTAddItemToWatchListViewController: MTViewController {

    let closeButton = UIButton.newAutoLayoutView()
    
    let titleLabel = UILabel.newAutoLayoutView()
    let subTitleLabel = UILabel.newAutoLayoutView()
    
    let notificationAmountTextField = UITextField.newAutoLayoutView()
    let subtextLabel = UILabel.newAutoLayoutView()
    let addToWatchListButton = UIButton.newAutoLayoutView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let containerTitleView = UIView(frame: CGRectMake(0, 0, 200, 33))
//        self.navigationItem.titleView = containerTitleView
//        containerTitleView.sizeToFit()
//        
//        let titleLabel = UILabel()
//        titleLabel.text = "Search Results"
//        titleLabel.font = UIFont.systemFontOfSize(15, weight: UIFontWeightMedium)
//        titleLabel.textColor = UIColor.whiteColor()
//        titleLabel.textAlignment = .Center
//        titleLabel.sizeToFit()
//        titleLabel.frame = CGRectMake(0, -2, containerTitleView.frame.size.width, 17)
//        containerTitleView.addSubview(titleLabel)
//        
//        let subTitleLabel = UILabel()
//        
//        subTitleLabel.text = (numberOfFilters!.description + " Filters Applied").uppercaseString
//        if numberOfFilters == 0 {
//            subTitleLabel.text = "No Filters Applied".uppercaseString
//        } else if numberOfFilters == 1 {
//            subTitleLabel.text = "1 Filter Applied".uppercaseString
//        }
//        
//        subTitleLabel.font = UIFont.systemFontOfSize(10, weight: UIFontWeightRegular)
//        subTitleLabel.textColor = UIColor.subTextColor()
//        subTitleLabel.textAlignment = .Center
//        subTitleLabel.frame = CGRectMake(0, 17, containerTitleView.frame.size.width, 12)
//        containerTitleView.addSubview(subTitleLabel)
   
        addToWatchListButton.backgroundColor = UIColor.appTintColor()
        addToWatchListButton.layer.cornerRadius = 5
        addToWatchListButton.setTitle("Add To Watchlist", forState: .Normal)
        addToWatchListButton.titleLabel!.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
        addToWatchListButton.titleLabel!.textColor = UIColor.whiteColor()
        addToWatchListButton.tintColor = UIColor.whiteColor()
        view.addSubview(addToWatchListButton)
        addToWatchListButton.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: 15.0)
        addToWatchListButton.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: -15.0)
        addToWatchListButton.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view, withOffset: -15.0)
        addToWatchListButton.autoSetDimension(.Height, toSize: 49)
        
        notificationAmountTextField.textColor = UIColor.appTintColor()
        notificationAmountTextField.font = UIFont.systemFontOfSize(75, weight: UIFontWeightLight)
        notificationAmountTextField.placeholder = "$1.00"
        notificationAmountTextField.textAlignment = .Center
        view.addSubview(notificationAmountTextField)
        notificationAmountTextField.autoPinEdge(.Top, toEdge: .Top, ofView: view)
        notificationAmountTextField.autoPinEdge(.Left, toEdge: .Left, ofView: view)
        notificationAmountTextField.autoPinEdge(.Right, toEdge: .Right, ofView: view)
        notificationAmountTextField.autoPinEdge(.Bottom, toEdge: .Top, ofView: addToWatchListButton, withOffset: -15.0)

    }
    
}
