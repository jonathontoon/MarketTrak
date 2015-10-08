//
//  ViewController.swift
//  MarketTrak
//
//  Created by Jonathon Toon on 9/30/15.
//  Copyright © 2015 Jonathon Toon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kanna

class ViewController: UIViewController {

    let marketCommunicator: MTSteamMarketCommunicator = MTSteamMarketCommunicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        marketCommunicator.getResultsForSearch(
            MTSearch(
                query: "fade"
            )
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

