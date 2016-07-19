//
//  MTAddItemToWatchListViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 7/18/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit

class MTAddItemToWatchListViewController: MTViewController {

    var item: MTItem!
    
    let closeButton = UIButton.newAutoLayoutView()
    
    let titleLabel = UILabel.newAutoLayoutView()
    let subTitleLabel = UILabel.newAutoLayoutView()
    
    let notificationAmountContainer = UIView.newAutoLayoutView()
    
    let notificationAmountTextField = UITextField.newAutoLayoutView()
    let subtextLabel = UILabel.newAutoLayoutView()
    let addToWatchListButton = UIButton.newAutoLayoutView()
    var addToWatchListButtonBottomConstraint: NSLayoutConstraint!
    
    var keyboardAnimationDuration: Double!
    var keyboardAnimationCurve: UInt!
    var keyboardFrame: CGSize!
    
    init(item: MTItem!) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containerTitleView = UIView(frame: CGRectMake(0, 0, 200, 33))
        self.navigationItem.titleView = containerTitleView
        containerTitleView.sizeToFit()
        
        let titleLabel = UILabel()
        
        if item.weaponType != nil && item.weaponType! != .None {
            titleLabel.text = item.weaponType!.stringDescription() + " | " + item.name!
        } else if item.type! == .Sticker {
            titleLabel.text = item.type!.stringDescription() + " | " + item.name!
        } else {
            titleLabel.text = item.name!
        }
        
        if item.category! == .Star {
            if !item.name!.containsString("★") {
                titleLabel.text = "★ " + item.weaponType!.stringDescription() + " | " + item.name!
            }
        }
        
        if item.category! == .StarStatTrak™ {
            if !item.name!.containsString("★") {
                titleLabel.text = "★ " + item.weaponType!.stringDescription() + " | " + item.name!
            }
        }

        
            titleLabel.font = UIFont.systemFontOfSize(15, weight: UIFontWeightMedium)
            titleLabel.textColor = UIColor.whiteColor()
            titleLabel.textAlignment = .Center
            titleLabel.sizeToFit()
            titleLabel.frame = CGRectMake(0, -2, containerTitleView.frame.size.width, 17)
            containerTitleView.addSubview(titleLabel)
        
        let subTitleLabel = UILabel()
        if item.type == Type.MusicKit {
            subTitleLabel.text = item.artistName!.uppercaseString
        } else if item.type == Type.Container {
            subTitleLabel.text = ("Container Series #" + item.containerSeries!.stringValue).uppercaseString
        } else {
            if item.weaponType != nil && item.weaponType != .None && item.exterior != nil && item.exterior! != .None && item.exterior! != Exterior.NotPainted {
                subTitleLabel.text = item.exterior!.stringDescription().uppercaseString
            } else {
                if item.tournament != nil && item.tournament != .None {
                    subTitleLabel.text = item.tournament!.uppercaseString
                } else if item.collection != nil && item.collection != .None {
                    subTitleLabel.text = item.collection!.uppercaseString
                } else if item.stickerCollection != nil && item.stickerCollection != .None {
                    subTitleLabel.text = item.stickerCollection!.uppercaseString
                } else {
                    subTitleLabel.text = "No information available".uppercaseString
                }
            }
        }
        
            subTitleLabel.font = UIFont.systemFontOfSize(10, weight: UIFontWeightRegular)
            subTitleLabel.textColor = UIColor.subTextColor()
            subTitleLabel.textAlignment = .Center
            subTitleLabel.frame = CGRectMake(0, 17, containerTitleView.frame.size.width, 12)
        containerTitleView.addSubview(subTitleLabel)

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(MTAddItemToWatchListViewController.dismissSettingsViewController))
        
        addToWatchListButton.backgroundColor = UIColor.appTintColor()
        addToWatchListButton.layer.cornerRadius = 5
        addToWatchListButton.setTitle("Add To Watchlist", forState: .Normal)
        addToWatchListButton.titleLabel!.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
        addToWatchListButton.titleLabel!.textColor = UIColor.whiteColor()
        addToWatchListButton.tintColor = UIColor.whiteColor()
        view.addSubview(addToWatchListButton)
        addToWatchListButton.autoSetDimension(.Height, toSize: 49)
        addToWatchListButton.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: 15.0)
        addToWatchListButton.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: -15.0)
        addToWatchListButtonBottomConstraint = addToWatchListButton.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: view, withOffset: -16.0)
        
        view.addSubview(notificationAmountContainer)
        notificationAmountContainer.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: 15.0)
        notificationAmountContainer.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: -15.0)
        notificationAmountContainer.autoPinEdge(.Top, toEdge: .Top, ofView: view)
        notificationAmountContainer.autoPinEdge(.Bottom, toEdge: .Top, ofView: addToWatchListButton)
        
        subtextLabel.text = "Will send alert when under $10.10 USD".uppercaseString
        subtextLabel.textColor = UIColor.subTextColor()
        subtextLabel.font = UIFont.systemFontOfSize(10.0, weight: UIFontWeightRegular)
        subtextLabel.textAlignment = .Center
        notificationAmountContainer.addSubview(subtextLabel)
        subtextLabel.autoSetDimension(.Height, toSize: 10.0)
        subtextLabel.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: 15.0)
        subtextLabel.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: -15.0)
        subtextLabel.autoPinEdge(.Bottom, toEdge: .Top, ofView: addToWatchListButton, withOffset: -15.0)

        notificationAmountTextField.textColor = UIColor.appTintColor()
        notificationAmountTextField.font = UIFont.systemFontOfSize(75, weight: UIFontWeightLight)
        notificationAmountTextField.text = item.currentPrice?.currencyAmount.stringValue
        notificationAmountTextField.textAlignment = .Center
        notificationAmountTextField.becomeFirstResponder()
        notificationAmountTextField.autocorrectionType = .No
        notificationAmountTextField.keyboardAppearance = .Dark
        notificationAmountTextField.keyboardType = .DecimalPad
        notificationAmountContainer.addSubview(notificationAmountTextField)
        notificationAmountTextField.autoSetDimension(.Height, toSize: 76.0)
        notificationAmountTextField.autoPinEdge(.Left, toEdge: .Left, ofView: view, withOffset: 15.0)
        notificationAmountTextField.autoPinEdge(.Right, toEdge: .Right, ofView: view, withOffset: -15.0)
        notificationAmountTextField.autoAlignAxis(.Horizontal, toSameAxisOfView: notificationAmountContainer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MTSearchViewController.keyboardWillAnimate(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MTSearchViewController.keyboardWillAnimate(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        notificationAmountTextField.resignFirstResponder()
    }
    
    func keyboardWillAnimate(notification: NSNotification) {
        
        keyboardAnimationDuration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        keyboardAnimationCurve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        keyboardFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
        
        self.addToWatchListButtonBottomConstraint.constant = (-1 * self.keyboardFrame.height) - 16
    }
    
    func dismissSettingsViewController() {
        dispatch_async(dispatch_get_main_queue(),{
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
}
