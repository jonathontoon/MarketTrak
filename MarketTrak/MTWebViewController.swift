//
//  MTWebViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 6/4/16.
//  Copyright © 2016 Jonathon Toon. All rights reserved.
//

import UIKit
import TOWebViewController

class MTWebViewController: TOWebViewController {
    
    var item: MTItem!
    
    init(item: MTItem!) {
       super.init(URL: item.itemURL!)
    
        self.item = item
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationButtonsHidden = true
        hideWebViewBoundaries = true
        showPageTitles = false
        buttonTintColor = UIColor.appTintColor()
        loadingBarTintColor = UIColor.appTintColor()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.backgroundColor = UIColor.backgroundColor()
        
        title = item.name!
        
        if item.weaponType != nil && item.weaponType != WeaponType.None  {
            title = item.weaponType!.stringDescription() + " | " + item.name! + " ("+item.exterior!.stringDescription()+")"
        } else {
            if item.type == Type.MusicKit || item.type == Type.Sticker {
                title = item.type.stringDescription() + " | " + item.name!
            }
        }
        
        if item.name! == "★" {
            title = "★ " + item.weaponType!.stringDescription() + " ("+item.exterior!.stringDescription()+")"
        }
        
        view.tintColor = UIColor.appTintColor()
        
        for v in view.subviews {
            if v.isKindOfClass(UIWebView) {
                v.opaque = true
                v.backgroundColor = UIColor(rgba: "#1b2838")
            }
        }

    }
    
}
