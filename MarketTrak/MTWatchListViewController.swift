//
//  MTWatchListViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 11/7/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit

class MTWatchListViewController: MTViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = nil
        view.backgroundColor = UIColor.redColor()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }

}
